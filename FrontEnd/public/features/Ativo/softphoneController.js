var App;
(function (App) {
    'use strict';
    App.modules.App.constant("softphoneController",
        function (
            $scope,
            $rootScope,
            // apiSocket,
            $interval,
            $timeout,
            //notificationsFactory,
            //softphoneFactory,
            // ngToast,
            $window,
            luarApp,
            updateUIJsSIP
            //SearchContacts,
            //modalService,
            //callsSocket
        ) {
            JsSIP.debug.disable("JsSIP:*");

            var _this = {};
            _this.useVideo = false;
            _this.phone = null;
            _this.callNumbers = ["", "", "", ""];
            $rootScope.newCall = false;
            _this.volumes = { ring: 0.75, call: 1 };
            _this.showStatusWarning = false;
            _this.browser = true;            
            _this.luarApp = luarApp;
            var _rootScope = $rootScope;

            _this.incomingCallAudio = new window.Audio('app/incoming.mp3');
            _this.incomingCallAudio.loop = true;
            _this.incomingCallAudio.crossOrigin="anonymous";
            _this.incomingCallAudio.volume = _this.volumes?.ring || 0.75;
                        
            _this.externalCallAudio = new window.Audio('app/external.mp3');
            _this.externalCallAudio.volume = _this.volumes.ring;
            _this.externalCallAudio.loop = true;
            //_this.externalCallAudio.autoplay = true;
            _this.externalCallAudio.crossOrigin="anonymous";

            _this.ConfigurationJsSIP = {
                'uri': _rootScope.currentUser.LoginSIP + '@' + _this.luarApp.URLJSSIP,
                'password': _rootScope.currentUser.SenhaSIP,
                'username': _rootScope.currentUser.LoginSIP,
                'register': true
            };

            let oscillator1, oscillator2;
            let context;

            const DEFAULT_RINGTONE = "ring01";
            const PHONE_LENGTH = 16;
            const PAD_KEYS = [
                "0",
                "1",
                "2",
                "3",
                "4",
                "5",
                "6",
                "7",
                "8",
                "9",
                "*",
                "#",
            ];

            const contextClass =
                window.AudioContext ||
                window.webkitAudioContext ||
                window.mozAudioContext ||
                window.oAudioContext ||
                window.msAudioContext;

            const remoteAudio = new window.Audio();
            remoteAudio.autoplay = true;

            _this.user = {};
          
            const listAudioDevices = () => {
                navigator.mediaDevices.enumerateDevices().then(devices => {
                    _this.audioInputs = devices.filter(
                        device => device.kind == "audioinput"
                    );

                    _this.audioOutputs = devices.filter(
                        device => device.kind == "audiooutput"
                    );

                    _this.audioInputs.map((device, index) => {
                        device.label ? device.label : `Microfone ${index}`;
                    });

                    _this.audioOutputs.map((device, index) => {
                        device.label ? device.label : `Saída de áudio ${index}`;
                    });

                    validadeOldDevices(devices);
                    navigator.mediaDevices.ondevicechange = listAudioDevices;
                    $scope.$evalAsync();
                });
            };

            _this.Registrar = function () {
                                                 
                const socket = new JsSIP.WebSocketInterface('wss://' + _this.luarApp.URLJSSIP + '/ws');
                _this.ConfigurationJsSIP.sockets = [socket];
                _this.phone = new JsSIP.UA(_this.ConfigurationJsSIP);

                _this.phone.on("newRTCSession", rtcSession => {
                     
                    var newSession = rtcSession.session;

                    const sessionIndex =
                      rtcSession.session.direction === "incoming"
                        ? getAvailableLine()
                        : _this.sessionIndex;

                    if (rtcSession.request && rtcSession.request.from) {
                        //session.remote_identity.uri.user;
                        // session.remote_identity.display_name; 
                        _this.RecebendoLigacaoName = rtcSession.request.from.display_name;
                        _this.RecebendoLigacaoUser = rtcSession.request.from.uri.user;
                    }
                    else {
                        _this.RecebendoLigacaoName = '';
                        _this.RecebendoLigacaoUser = '';
                    }

                    _this.SessionJsSIP = newSession; 
                    _this.SessionJsSIP.sendDTMF = sendDTMF;
            
                    const completeSession = session => {
                      _this.clearSession(session);
                      _this.updateUI(session);
                    };
            
                    _this.SessionJsSIP.on("ended", () =>
                      completeSession(_this.SessionJsSIP)
                    );
            
                    _this.SessionJsSIP.on("failed", () =>
                      completeSession(_this.SessionJsSIP)
                    );
            
                    _this.SessionJsSIP.on("accepted", () =>
                      _this.updateUI(_this.SessionJsSIP)
                    );
            
                    _this.SessionJsSIP.on("confirmed", () =>
                      _this.updateUI(_this.SessionJsSIP)
                    );
            
                    _this.SessionJsSIP.on("icecandidate", data => {
                      $timeout(() => {
                        const { ready, candidate } = data;
                        const { connection } = _this.SessionJsSIP;
            
                        if (connection.iceGatheringState !== "complete") {
                          console.warn(
                            `Timeout gathering ice candidate ${candidate.address}!`
                          );
                          ready();
                        }
                      }, 2000);
                    });
            
                    _this.SessionJsSIP.on("peerconnection", peer =>
                      addTrack(peer.peerconnection, _this.SessionJsSIP)
                    );
            
                    _this.updateUI(_this.SessionJsSIP);
            
                    if (_this.SessionJsSIP.direction === "incoming") {
                      const hasCall = _this.SessionJsSIP.phoneStatus === "Em ligação... ";
                      
                      if (hasCall) {
                        _this.callBeep.play();
                      }
            
                      if (!hasCall) {
                         _this.incomingCallAudio.play();
                      }            
            
                      _this.sourceCall = null;
                      $rootScope.newCall = true;
                    }
                  });                

                _this.phone.on("connecting", () => console.log("Trying to connect..."));
                _this.phone.on("connected", () => console.log("Connected!"));

                _this.phone.on("disconnected", () => console.log("Disconnected!"));

                _this.phone.on("newRTCSession", rtcSession => {
                
                    _this.SessionJsSIP = rtcSession.session;
                    rtcSession.session.sendDTMF = sendDTMF;

                    const completeSession = session => {
                        _this.clearSession(session);
                        _this.updateUI(session);
                    };

                    _this.SessionJsSIP.on("ended", () =>
                        completeSession(_this.SessionJsSIP)
                    );

                    _this.SessionJsSIP.on("failed", () =>
                        completeSession(_this.SessionJsSIP)
                    );

                    _this.SessionJsSIP.on("accepted", () =>
                        _this.updateUI(_this.SessionJsSIP)
                    );

                    _this.SessionJsSIP.on("confirmed", () =>
                        _this.updateUI(_this.SessionJsSIP)
                    );

                    _this.SessionJsSIP.on("icecandidate", data => {
                        $timeout(() => {
                            const { ready, candidate } = data;
                            const { connection } = _this.SessionJsSIP;

                            if (connection.iceGatheringState !== "complete") {
                                console.warn(
                                    `Timeout gathering ice candidate ${candidate.address}!`
                                );
                                ready();
                            }
                        }, 2000);
                    });

                    _this.SessionJsSIP.on("peerconnection", peer =>
                        addTrack(peer.peerconnection, _this.SessionJsSIP)
                    );

                    _this.updateUI(_this.SessionJsSIP);

                    if (_this.SessionJsSIP.direction === "incoming") {
                        const hasCall = _this.SessionJsSIP.phoneStatus === "Em ligação... ";                        

                        if (hasCall) {
                            _this.callBeep.play();
                        }

                        if (!hasCall) {
                            _this.incomingCallAudio.play();
                        }

                        _this.sourceCall = null;
                        $rootScope.newCall = true;
                    }
                });

                _this.phone.on("newMessage", () => console.log("New message!"));

                _this.phone.on("registered", () => {
                    console.log("Softphone registered!");
                    $scope.$evalAsync();
                });

                // _this.phone.on(
                //     "unregistered",
                //     softphoneFactory.showLostConnectionMessage
                // );

                _this.phone.start();

                if (_this.browser) {
                    listAudioDevices();
                }
            };

            _this.TestarUtilizaJsSIP = function () {
                return _this.ConfigurationJsSIP && _this.ConfigurationJsSIP.username && _this.ConfigurationJsSIP.password;
            }

            _this.unRegister = function () {
                _this.phone.stop();
                _this.phone.unregister();
                $scope.$evalAsync();
            };

            _this.answerOrCall = (pFone) => {
                 
                if (!_this.browser && !_this.user.microphone && _this.audioInputs) {
                    _this.user.microphone = _this.audioInputs[0].deviceId;
                }

                const callOptions = {
                    mediaConstraints: {
                        audio: {
                            deviceId: {
                                exact: _this.user.microphone || "default",
                            },
                        },
                        video: _this.useVideo,
                        pcConfig: {
                            iceServers: [{ urls: ["stun:stun.l.google.com:19302"] }],
                        },
                    },
                };

                if (!_this.phone || !_this.phone.isRegistered()) return;

                if (_this.SessionJsSIP) {
                    if (_this.SessionJsSIP.isEstablished()) {
                        _this.hangup(_this.SessionJsSIP);
                        return;
                    }

                    if (_this.SessionJsSIP.isInProgress()) {
                        if (_this.SessionJsSIP.direction === "outgoing") {
                            _this.hangup(_this.SessionJsSIP);
                            return;
                        }

                        if (_this.SessionJsSIP.isInProgress()) {
                            _this.SessionJsSIP.answer(callOptions);
                            _this.changeCurrentLine(_this.SessionJsSIP);
                            return;
                        }
                    }
                }

                 
                if (["Ausente", "Ocupado"].includes($rootScope.loggedUserStatus)) {
                    _this.showStatusWarning = true;
                }

                _this.SessionJsSIP = _this.phone.call(pFone, callOptions);
                addTrack(_this.SessionJsSIP.connection, _this.SessionJsSIP);                
            };

            _this.verifyMaxLength = (event, isScreen) => {
                if (isScreen && event.target?.innerText.length >= PHONE_LENGTH) {
                    event.preventDefault();
                    return false;
                }

                if (_this.callNumbers[0].length >= PHONE_LENGTH) {
                    return false;
                }

                return true;
            };

            const setCursorToEnd = element => {
                if (!element.childNodes.length) return;

                const setpos = document.createRange();
                const set = window.getSelection();

                setpos.setStart(element.childNodes[0], element.innerText.length);
                setpos.collapse(true);
                set.removeAllRanges();
                set.addRange(setpos);

                element.focus();
            };

            _this.padClick = function (number, code) {
                const event = { key: number, keyCode: code };
                _this.getKeys(event);
            };

            _this.findContacts = event => {
                const isEditableSpan = event.target?.localName === "span";

                if (event.keyCode === 13) {
                    if (_this.contacts?.length) {
                        _this.callContact(_this.contacts[0].phone);
                    }

                    if (isEditableSpan) {
                        event.target.innerText = event.target.innerText.replace(/\n/g, "");
                        setCursorToEnd(event.target);
                    }

                    event.preventDefault();
                    return;
                }

                if (isEditableSpan && event.target.innerText.length > 20) {
                    event.target.innerText = event.target.innerText.substring(0, 20);
                    setCursorToEnd(event.target);

                    return;
                }

                _this.contacts = null;

                if (searchContacts.isNotAPhone(event.target.innerText)) {
                    _this.contacts = searchContacts.search(event.target.innerText);
                }
            };

            _this.getKeys = function (event) {
                const isActionKey = [13, 8].includes(event.keyCode);
                const isValidPadKey = PAD_KEYS.includes(event.key);
                const isScreen = event.target?.localName === "span";

                if (!isValidPadKey && !isActionKey) return;

                if (isScreen && searchContacts.isNotAPhone(event.target?.innerText))
                    return;

                if (!_this.phone || !_this.phone.isRegistered()) {
                    return;
                }

                if (event.keyCode === 13) {
                    _this.answerOrCall();
                    event.preventDefault();

                    return;
                }

                if (!isScreen && event.keyCode === 8) {
                    const callNumber = _this.callNumbers[0];
                    _this.callNumbers[0] = callNumber.slice(0, -1);
                    return;
                }

                if (!_this.verifyMaxLength(event, isScreen)) {
                    return;
                }

                const tones = [
                    [941.0, 1336.0],
                    [697.0, 1209.0],
                    [697.0, 1336.0],
                    [697.0, 1477.0],
                    [770.0, 1209.0],
                    [770.0, 1336.0],
                    [770.0, 1477.0],
                    [852.0, 1209.0],
                    [852.0, 1336.0],
                    [852.0, 1477.0],
                    [941.0, 1209.0],
                    [941.0, 1477.0],
                ];

                if (!isValidPadKey) {
                    event.preventDefault();
                    return;
                }

                const [freq1, freq2] = tones[PAD_KEYS.indexOf(event.key)];
                _this.playTone(freq1, freq2);
                $timeout(() => _this.stopTone(), 180);

                const session = _this.SessionJsSIP;

                if (session) {
                    sendDTMF(session.connection, event.key);

                    return;
                }

                if (!isScreen) {
                    const callNumber = _this.callNumbers[0];
                    _this.callNumbers[0] = callNumber + event.key;
                }
            };

            const sendDTMF = (connection, tones) => {
                if (!connection.getSenders()) return;

                const dtmfSender = connection.getSenders()[0].dtmf;

                dtmfSender.insertDTMF(String(tones));
            };

            _this.callContact = phone => {
                _this.contacts = searchContacts.clear();
                _this.callNumbers[0] = phone;
                _this.answerOrCall(phone);
            };

            _this.pasteClipboard = event => {
                event.preventDefault();

                const session = _this.SessionJsSIP;

                if (!_this.phone || !_this.phone.isRegistered() || session) {
                    return;
                }

                const paste = event.originalEvent.clipboardData.getData("text/plain");
                const pattern = /([\d*#])/gi;
                let digits = paste.match(pattern);

                if (digits) {
                    digits = digits.join("");

                    const finalLength =
                        _this.callNumbers[0].length + digits.length;

                    if (finalLength > PHONE_LENGTH) {
                        digits = digits.substr(
                            0,
                            digits.length - (finalLength - PHONE_LENGTH)
                        );
                    }

                    _this.callNumbers[0] += digits;
                }
            };

            _this.hangup = function (session) {
                _this.clearSession(session);
            };

            _this.mute = () => {
                const session = _this.SessionJsSIP;

                if (!session || !session.isEstablished()) return;

                if (session.isMuted().audio) {
                    session.unmute({ audio: true });
                } else {
                    session.mute({ audio: true });
                }
            };

            _this.hold = session => {

                if (!session || !session.isEstablished()) return;

                if (!session.isOnHold().local) {
                    session.hold();
                } else {
                    session.unhold();
                }
            };

            _this.updateUI = session => {
                 
                if (session) {
                    if (session.isInProgress()) {
                        const username = session.remote_identity.uri.user;
                        const name = session.remote_identity.display_name;

                        if (session.direction === "incoming") {
                            // const newNotification = {
                            //     title: "Recebendo ligação",
                            //     body: `Recebendo ligação de: ${username} - ${name}\nClique aqui para atender.`,
                            //     onClick: () => _this.answerOrCall(session),
                            // };

                            // if (notificationsFactory.isBrowserMinimized) {
                            //     notificationsFactory.notify(newNotification);
                            // }
                        }

                        // _this.SessionJsSIP.avatar = _this.peersAvatars[username];

                        if (session.direction === "incoming") {
                            _this.SessionJsSIP.phoneStatus = "Recebendo ligação...";
                        } else {
                            _this.SessionJsSIP.phoneStatus = "Discando...";
                        }
                    } else if (session.isEstablished()) {
                        _this.SessionJsSIP.phoneStatus = "Em ligação... ";
                        _this.startCallTimer(session);

                         _this.incomingCallAudio.pause();
                         _this.externalCallAudio.pause();
                        $rootScope.newCall = false;
                    }
                    else {
                        _this.incomingCallAudio.pause();
                        _this.externalCallAudio.pause();
                    }

                    updateUIJsSIP();
                }

                if (!session) {
                     _this.incomingCallAudio.pause();
                     _this.externalCallAudio.pause();
                    $rootScope.newCall = false;
                }

                $scope.$evalAsync();
            };

            _this.startCallTimer = session => {
                stopCallTimer(session);
                _this.SessionJsSIP.callTime = 0;

                _this.SessionJsSIP.callTimer = $interval(() => {
                    _this.SessionJsSIP.callTime += 1;
                }, 1000);
            };

            const stopCallTimer = session => {
                if (!_this.SessionJsSIP) {
                    return;
                }

                $interval.cancel(_this.SessionJsSIP.callTimer);
            };

            const stopQualityTimer = session => {
                if (!_this.SessionJsSIP) {
                    return;
                }

                $interval.cancel(_this.SessionJsSIP.qualityTimer);
            };

            _this.enableVideo = function () {
                _this.useVideo = !_this.useVideo;
            };
            _this.closeVideo = function () {
                _this.remoteVideo.srcObject = null;
            };

            _this.pauseVideo = function () {
                if (!_this.remoteVideo.paused) {
                    _this.remoteVideo.pause();
                    _this.localVideo.pause();
                    return;
                }

                if (_this.remoteVideo.paused) {
                    _this.remoteVideo.play();
                    _this.localVideo.play();
                    return;
                }
            };

            const qualifyCall = ({ packetsLost, packetsReceived, jitter }) => {
                const lost = (100 / (packetsLost + packetsReceived)) * packetsLost;

                if (lost < 0.5 && jitter < 0.02) {
                    return 3;
                }

                if ((lost > 0.5 && lost < 1) || (jitter > 0.02 && jitter < 0.04)) {
                    return 2;
                }

                return 1;
            };

            const addTrack = (connection, session) => {
                 
                connection.ontrack = event => {
                      
                    _this.SessionJsSIP.stream = event.streams[0];

                    setTrack(_this.SessionJsSIP);                    

                    _this.SessionJsSIP.quality = 3;

                    _this.SessionJsSIP.qualityTimer = $interval(() => {
                        connection.getStats().then(
                            stats =>
                                stats.forEach(stat => {
                                    if (stat.type === "inbound-rtp") {
                                        _this.SessionJsSIP.quality = qualifyCall(stat);
                                    }
                                }),
                            error => console.log(error)
                        );
                    }, 5000);
                };
            };

            const setTrack = session => {
                 
                const stream = session.stream;

                if (!stream) {
                    return;
                }

                if (stream.getAudioTracks()[0]) {
                    remoteAudio.srcObject = stream;
                    if (_this.browser) {
                        setCallHeadphone(_this.user);
                    }
                }

                if (!_this.useVideo) return;

                if (stream.getVideoTracks().length > 0) {
                    _this.remoteVideo.srcObject = stream;
                    const localStream = session.connection.getLocalStreams()[0];

                    if (localStream.getVideoTracks()[0]) {
                        _this.localVideo.srcObject = localStream;
                    }
                }
            };

            _this.playTone = function (freq1, freq2) {
                if (!context) {
                    context = new contextClass();
                }

                _this.stopTone();

                oscillator1 = context.createOscillator();
                oscillator1.frequency.value = freq1;

                let gainNode = context.createGain
                    ? context.createGain()
                    : context.createGainNode();

                oscillator1.connect(gainNode, 0, 0);
                gainNode.connect(context.destination);

                gainNode.gain.value = (_this.volumes.ring || 1) / 10;
                oscillator1.start ? oscillator1.start(0) : oscillator1.noteOn(0);

                oscillator2 = context.createOscillator();
                oscillator2.frequency.value = freq2;

                gainNode = context.createGain
                    ? context.createGain()
                    : context.createGainNode();

                oscillator2.connect(gainNode);
                gainNode.connect(context.destination);

                gainNode.gain.value = (_this.volumes.ring || 1) / 10;
                oscillator2.start ? oscillator2.start(0) : oscillator2.noteOn(0);
            };

            _this.stopTone = () => {
                if (oscillator1) {
                    oscillator1.disconnect();
                }

                if (oscillator2) {
                    oscillator2.disconnect();
                }
            };

            _this.clearSession = session => {

                if (session && (session.isEstablished() || session.isInProgress())) {
                    session.terminate();
                }

                if (_this.localVideo) {
                    _this.localVideo.srcObject = null;
                }

                if (_this.remoteAudio) {
                    _this.remoteVideo.srcObject = null;
                }

                stopCallTimer(session);
                stopQualityTimer(session);

                session = null;
                $rootScope.newCall = false;
            };

            const getCurrentUser = () => {
                if (!_this.browser) {
                    navigator.mediaDevices.getUserMedia({ audio: true, video: false }).then(
                        () => listAudioDevices(),
                        err => {
                            console.log(err);
                        }
                    );
                }

                // usersAPI.getUser($rootScope.loggedUserId).then(
                //     function (response) {
                //         _this.user = response.data;

                //         if (!_this.user || !_this.user.Peer) {
                //             return;
                //         }

                //         const userRingTone = _this.user.ringtone
                //             ? "./assets/sounds/" + _this.user.ringtone + ".mp3"
                //             : "./assets/sounds/" + DEFAULT_RINGTONE + ".mp3";

                //         const externalRingTone = _this.user.externalRingtone
                //             ? "./assets/sounds/" + _this.user.externalRingtone + ".mp3"
                //             : "./assets/sounds/" + DEFAULT_RINGTONE + ".mp3";

                //         _this.incomingCallAudio = new window.Audio(userRingTone);
                //         _this.incomingCallAudio.volume = _this.volumes?.ring || 0.75;
                //         _this.incomingCallAudio.loop = true;

                //         _this.externalCallAudio = new window.Audio(externalRingTone);
                //         _this.externalCallAudio.volume = _this.volumes.ring;
                //         _this.externalCallAudio.loop = true;

                //         _this.sip = {
                //             host: `wss://${config.asteriskUrl}${config.asteriskPath}`,
                //             uri: `sip:${_this.user.Peer.username}@${config.asteriskUrl}`,
                //             password: _this.user.Peer.secret,
                //         };

                //         _this.register();
                //         if (_this.browser) {
                //             listAudioDevices();
                //         }

                //         loadUserConfig();
                //     },
                //     function (error) {
                //         console.error(error);
                //     }
                // );
            };

            const registerUserSofphone = () => {
                 
                verifyBrowser();

                if (!_this.phone && !_this.hideSidebar && $rootScope.logged) {
                    getCurrentUser();
                    // notificationsFactory.askPermission();

                    // notificationsFactory.verifyPermission().then(granted => {
                    //     !granted &&
                    //         ngToast.warning({
                    //             content:
                    //                 "<i class='fa fa-exclamation-triangle'></i> Você não permitiu a exibição de notificações de novas ligações.",
                    //         });
                    // });

                    if (_this.browser) {
                        verifyPermissionMicrophone().then(granted => {
                            !granted &&
                                ngToast.danger({
                                    content:
                                        "<i class='fa fa-exclamation-triangle'></i> Você precisa permitir o uso do microphone para usar o softphone.",
                                });
                        });
                    }

                    setNextSession();
                    // loadPeersAvatars();
                }
            };

            const _verifyPermissionMicrophone = async () => {
                const { state } = await navigator.permissions.query({
                  name: "microphone",
                });
            
                return state !== "denied";
            };

            _this.changeCurrentLine = lineIndex => {
                setTrack(_this.SessionJsSIP);
                // if (_this.sessionIndex === lineIndex) {
                //     return;
                // }

                // _this.hold(_this.sessionIndex);
                // _this.sessionIndex = lineIndex;

                // if (_this.sessions[lineIndex]) {
                //     setTrack(lineIndex);
                //     _this.hold(lineIndex);
                // }
            };

            const getAvailableLine = () => {
                // for (const [index, session] of _this.sessions.entries()) {
                //     if (!session) {
                //         return index;
                //     }
                // }
            };

            const setNextSession = () => {
                // if (_this.sessions[_this.sessionIndex]) {
                //     _this.sessionIndex = getAvailableLine();
                // }
            };

            $rootScope.$on("logout", function () {
                if (_this.phone) {
                    _this.phone.stop();
                    _this.phone.unregister();
                    _this.phone = null;
                }
            });

            $rootScope.$on("login", function () {
                registerUserSofphone();
            });

            $rootScope.$on("changeUserSettings", function () {
                loadUserConfig();
                adjustVolumeLevels();
                loadUserRingtone();
            });

            _this.afterLoaded = function () {
                _this.remoteVideo = document.getElementById("remoteVideo");
                _this.localVideo = document.getElementById("localVideo");
            };
            
            const loadUserConfig = () => {
                _this.user.speaker = $window.localStorage.speaker;
                _this.user.headphone = $window.localStorage.headphone;
                _this.user.microphone = $window.localStorage.microphone;

                _this.volumes.ring = Number($window.localStorage?.ringVolume) ?? 0.75;
                _this.volumes.call = Number($window.localStorage?.callVolume) ?? 1;

                setCallSpeaker(_this.user);
                adjustVolumeLevels();
            };

            const setCallSpeaker = ({ speaker }) => {
                if (speaker) {
                    _this.incomingCallAudio.setSinkId(speaker);
                    _this.externalCallAudio.setSinkId(speaker);
                }
            };

            const setCallHeadphone = ({ headphone }) => {
                if (headphone) {
                    remoteAudio.setSinkId(headphone);

                    if (_this.remoteVideo.srcObject) {
                        _this.remoteVideo.setSinkId(headphone);
                    }
                }
            };

            const adjustVolumeLevels = () => {
                if (_this.incomingCallAudio) {
                    _this.incomingCallAudio.volume = _this.volumes.ring;
                }

                if (_this.externalCallAudio) {
                    _this.externalCallAudio.volume = _this.volumes.ring;
                }

                if (remoteAudio) {
                    remoteAudio.volume = _this.volumes.call;
                }

                if (_this.remoteVideo) {
                    _this.remoteVideo.volume = _this.volumes.call;
                }
            };

            const validadeOldDevices = devices => {
                const { speaker, microphone, headphone } = _this.user;

                const hasSpeaker = devices.find(
                    device => device.deviceId == speaker && device.kind == "audiooutput"
                );

                if (speaker && !hasSpeaker) {
                    _this.user.speaker = "default";
                }

                const hasMicrophone = devices.find(
                    device => device.deviceId == microphone && device.kind == "audioinput"
                );

                if (microphone && !hasMicrophone) {
                    _this.user.microphone = "default";
                }

                if (_this.browser) {
                    const hasHeadphone = devices.find(
                        device => device.deviceId == headphone && device.kind == "audiooutput"
                    );

                    if (headphone && !hasHeadphone) {
                        _this.user.headphone = "default";
                    }
                }
            };

            // const loadUserRingtone = () => {
            //     usersAPI.getUser($rootScope.loggedUserId).then(
            //         function (response) {
            //             _this.user = response.data;

            //             const userRingTone = _this.user.ringtone
            //                 ? "./assets/sounds/" + _this.user.ringtone + ".mp3"
            //                 : config.ringTone;

            //             const externalRingTone = _this.user.externalRingtone
            //                 ? "./assets/sounds/" + _this.user.externalRingtone + ".mp3"
            //                 : config.ringTone;

            //             if (_this.incomingCallAudio) {
            //                 _this.incomingCallAudio.stop();
            //             }

            //             if (_this.externalCallAudio) {
            //                 _this.externalCallAudio.stop();
            //             }

            //             _this.incomingCallAudio = new window.Audio(userRingTone);
            //             _this.incomingCallAudio.volume = _this.volumes.ring;
            //             _this.incomingCallAudio.loop = true;

            //             _this.externalCallAudio = new window.Audio(externalRingTone);
            //             _this.externalCallAudio.volume = _this.volumes.ring;
            //             _this.externalCallAudio.loop = true;
            //         },
            //         function (error) {
            //             console.error(error);
            //         }
            //     );
            // };

            // const loadPeersAvatars = () => {
            //     usersAPI
            //         .getUsers({ attributes: '["avatar"]', include: "[]" })
            //         .then(({ data: users }) => {
            //             const avatars = {};

            //             users.forEach(user => {
            //                 if (user.Peer) {
            //                     avatars[user.Peer?.username] = user.avatar || "user.jpg";
            //                 }
            //             });

            //             _this.peersAvatars = avatars;
            //         });
            // };

            const verifyBrowser = () => {
                const userAgent = $window.navigator.userAgent;
                const browsers = {
                    chrome: /chrome/i,
                    safari: /safari/i,
                    firefox: /firefox/i,
                    ie: /internet explorer/i,
                };

                for (var browser in browsers) {
                    if (browsers[browser].test(userAgent) && browser === "firefox") {
                        _this.browser = false;
                    }
                }
            };

            const setUserBeepTone = () => {
                // const userBeepTone = "./assets/sounds/beep_1.mp3";
                // _this.callBeep = new window.Audio(userBeepTone);
                // _this.callBeep.volume = _this.volumes.ring;
                // _this.callBeep.loop = false;
            };

            // apiSocket.on("peer:update", () => {
            //     loadPeersAvatars();
            // });

            registerUserSofphone();
            setUserBeepTone();
            // const searchContacts = SearchContacts;

            // _this.$on("$destroy", () => {
            //     // callsSocket.remove("historyCallOut", onHistoryCallOut);
            // });

            return _this;
        }
    );
})(App || (App = {}));
