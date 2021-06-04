function ABTO(){
    
    var ABTOPhone = null;

    var btnCall, btnHangUp, btnHold, btnTransfer;
    var btnMute, btnUnMute;
    var btnAccept, btnReject;
    var btnRegister, btnUnRegister;
    var chkbxWithVideo;
    var select_account;
    var btnSendMessage, message_text, chat_table;
    var __nt = null;

    var inCall = false;

    var phoneRing = null;
    var phoneRingLoop = false;

    var secure = (window.location.protocol === "https:");
    function initPhone(){
        ABTOPhone = new ABTOPhoneUA();    

        ABTOPhone.onConnected = function() {};

        ABTOPhone.onConnectionError = function(error) {
            //document.getElementById('init_status').textContent = 'Error';
            ABTOPhone.close();
        };

        ABTOPhone.onRegistered = function() {
        //  document.getElementById('init_status').textContent = 'Registered';
        //  btnSendMessage.disabled = false;
        };

        ABTOPhone.onRegisterError = function(error) {
        //   document.getElementById('init_status').textContent = 'UnRegistered';
        //   btnSendMessage.disabled = true;
        };

        ABTOPhone.onNewCall = function(id) {};

        ABTOPhone.onHangUp = function(id) {//cancelled
            inCall = false;
            stopRinger();
            showIncomingCall(null);
        };

        ABTOPhone.onLocalVideoStarted = function(stream) {};

        ABTOPhone.onRemoteVideoStarted = function(stream) {};

        ABTOPhone.onInvited = function(id, from) {
            if (!inCall) {
                incomingCall(id, from);
            } else {
                this.reject();
            }
        };

        ABTOPhone.onEstablished = function(id, from) {
        // document.getElementById('call_status').textContent = "Call from "+ from;
            inCall = true;
            stopRinger();
        };

        ABTOPhone.onEstablishError = function(id) {//rejected
            inCall = false;
            stopRinger();
            showIncomingCall(null);
        };

        ABTOPhone.onHold = function(id, holdON, thisSideInitiated) {

        };

        ABTOPhone.onMessage = function(from, text) {
        // addChatSentence(from, text, false);
        };

        ABTOPhone.onCallCleared = function(id) {
        //  document.getElementById('call_status').textContent = "";
            inCall = false;
        };

        ABTOPhone.onUnregistered = function() {
        /*   document.getElementById('init_status').textContent = 'UnRegistered';     */
        };
    }

    function registerPhone(sipID, sipPW, sipDN, wsPort, secure) {
        ABTOPhone.setSipUserName(sipID);
        ABTOPhone.setSipLogin(sipID);
        ABTOPhone.setSipPassword(sipPW);
        ABTOPhone.setSipDomain(sipDN);
        ABTOPhone.setWSPort(wsPort);
        ABTOPhone.setSecure(secure);

        ABTOPhone.initAndRegister();
    }        

    function setupRinger(filename){
        //create the phone ringing audio
        phoneRing = new Audio();
        phoneRingLoop = true;

        phoneRing.src = filename;

        phoneRing.addEventListener('ended', function() {
            if (phoneRingLoop) {
                this.play();
            }
        }, false);

        phoneRing.play();
    }

    function setupRingerIn(){
        setupRinger('sounds/ringtone.wav');
    }

    function setupRingerOut(){
        setupRinger('sounds/ringbacktone.wav');
    }

    function stopRinger(){
        phoneRingLoop = false;

        if (phoneRing!= null) {
            phoneRing.pause();
        }
    }

    function unInitPhone() {
        if(ABTOPhone != null){
            ABTOPhone.close();
        }
    }

    function ReceberLigacao(){
        ABTOPhone.accept();
        stopRinger();
        showIncomingCall(null);
    }

    function RejeitarLigacao(){
        ABTOPhone.reject();
        stopRinger();
        showIncomingCall(null);
    }

    function EmEspera(){
        ABTOPhone.hold();
    }

    function Transferir(Numero){
        ABTOPhone.transfer( Numero );
    }

    function Desligar(){
        ABTOPhone.bye();
        stopRinger();
    }

    function Ligar(Numero){
        if (!inCall && ABTOPhone.call(Numero)) {
            setupRingerOut();
        }
    }
}