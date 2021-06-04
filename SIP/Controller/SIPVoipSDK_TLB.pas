unit SIPVoipSDK_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 17244 $
// File generated on 30.09.2015 11:39:33 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\ABTO Software\VoIP Video SIP SDK\binary\SIPVoipSDK.dll (1)
// LIBID: {51E1C96F-F16B-4D5A-A790-4C72E219F9AE}
// LCID: 0
// Helpfile:
// HelpString: ABTO Voip Video SIP SDK 4.0 Type Library
// DepndLst:
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TCConfig) : Server C:\Program Files\ABTO Software\VoIP Video SIP SDK\binary\SIPVoipSDK.dll contains no icons
//   Error creating palette bitmap of (TCSubscriptions) : Server C:\Program Files\ABTO Software\VoIP Video SIP SDK\binary\SIPVoipSDK.dll contains no icons
//   Error creating palette bitmap of (TCAbtoPhone) : Server C:\Program Files\ABTO Software\VoIP Video SIP SDK\binary\SIPVoipSDK.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties
// which return objects that may need to be explicitly created via a function
// call prior to any access via the property. These items have been disabled
// in order to prevent accidental use from within the object inspector. You
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively
// removing them from the $IFDEF blocks. However, such items must still be
// programmatically created via a method of the appropriate CoClass before
// they can be used.
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SIPVoipSDKMajorVersion = 1;
  SIPVoipSDKMinorVersion = 0;

  LIBID_SIPVoipSDK: TGUID = '{51E1C96F-F16B-4D5A-A790-4C72E219F9AE}';

  IID_IConfig: TGUID = '{61E86A3E-6ED9-4B8E-88E0-DF9BEA33F54D}';
  CLASS_CConfig: TGUID = '{1C80CD16-C949-44AE-91A5-73854630B78A}';
  IID_ISubscriptions: TGUID = '{D7CB76AD-3559-4FF4-8313-41CCA1A6ED19}';
  CLASS_CSubscriptions: TGUID = '{B2B9E376-45C6-4623-8CF9-B0FDEDCFC21B}';
  DIID__IAbtoPhoneEvents: TGUID = '{4EBC3861-0D3F-48A3-8322-E45E74DBDEF5}';
  IID_IAbtoPhone: TGUID = '{F9EE5EB0-F289-45FA-836E-6F381A306FC5}';
  CLASS_CAbtoPhone: TGUID = '{9BCEE7C8-3FE1-49FA-94D5-FC92DB4301F1}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum LogLevelType
type
  LogLevelType = TOleEnum;
const
  eLogNone = $FFFFFFFF;
  eLogCritical = $00000002;
  eLogError = $00000003;
  eLogWarning = $00000004;
  eLogInfo = $00000006;
  eLogDebug = $00000007;

// Constants for enum ToneType
type
  ToneType = TOleEnum;
const
  eToneDtmf = $00000001;
  eToneBaudot = $00000002;
  eToneSIT = $00000004;
  eToneMF = $00000008;
  eToneEnergy = $00000010;

// Constants for enum TransportType
type
  TransportType = TOleEnum;
const
  eTransportUDP = $00000001;
  eTransportTCP = $00000002;
  eTransportTLSv1 = $00000004;
  eTransportSSLv23 = $00000008;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IConfig = interface;
  IConfigDisp = dispinterface;
  ISubscriptions = interface;
  ISubscriptionsDisp = dispinterface;
  _IAbtoPhoneEvents = dispinterface;
  IAbtoPhone = interface;
  IAbtoPhoneDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CConfig = IConfig;
  CSubscriptions = ISubscriptions;
  CAbtoPhone = IAbtoPhone;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PInteger1 = ^LONG_PTR; {*}
  PInteger2 = ^Integer; {*}

  LONG_PTR = Integer; 

// *********************************************************************//
// Interface: IConfig
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {61E86A3E-6ED9-4B8E-88E0-DF9BEA33F54D}
// *********************************************************************//
  IConfig = interface(IDispatch)
    ['{61E86A3E-6ED9-4B8E-88E0-DF9BEA33F54D}']
    procedure Set_StunServer(const StunAddress: WideString); safecall;
    function Get_StunServer: WideString; safecall;
    procedure Set_ListenPort(Port: Integer); safecall;
    function Get_ListenPort: Integer; safecall;
    procedure Set_RtpStartPort(Port: Integer); safecall;
    function Get_RtpStartPort: Integer; safecall;
    procedure Set_ActivePlaybackDevice(const DeviceName: WideString); safecall;
    function Get_ActivePlaybackDevice: WideString; safecall;
    function Get_PlaybackDeviceCount: Integer; safecall;
    function Get_PlaybackDevice(Index: Integer): WideString; safecall;
    procedure Set_ActiveRecordDevice(const DeviceName: WideString); safecall;
    function Get_ActiveRecordDevice: WideString; safecall;
    function Get_RecordDeviceCount: Integer; safecall;
    function Get_RecordDevice(Index: Integer): WideString; safecall;
    procedure Set_MinJitterDelay(Delay: Integer); safecall;
    function Get_MinJitterDelay: Integer; safecall;
    procedure Set_MaxJitterDelay(Delay: Integer); safecall;
    function Get_MaxJitterDelay: Integer; safecall;
    procedure Set_SoundBufferDepth(Depth: Integer); safecall;
    function Get_SoundBufferDepth: Integer; safecall;
    procedure Set_EchoCancelationEnabled(Enabled: Integer); safecall;
    function Get_EchoCancelationEnabled: Integer; safecall;
    procedure Set_SilenceDetectionEnabled(Enabled: Integer); safecall;
    function Get_SilenceDetectionEnabled: Integer; safecall;
    procedure Set_AutoGainControlEnabled(Enabled: Integer); safecall;
    function Get_AutoGainControlEnabled: Integer; safecall;
    procedure Set_NoiseReductionEnabled(Enabled: Integer); safecall;
    function Get_NoiseReductionEnabled: Integer; safecall;
    procedure Set_UserAgent(const AgentName: WideString); safecall;
    function Get_UserAgent: WideString; safecall;
    procedure Set_CallerId(const Id: WideString); safecall;
    function Get_CallerId: WideString; safecall;
    procedure Set_RegDomain(const Domain: WideString); safecall;
    function Get_RegDomain: WideString; safecall;
    procedure Set_RegUser(const User: WideString); safecall;
    function Get_RegUser: WideString; safecall;
    procedure Set_RegPass(const Pass: WideString); safecall;
    function Get_RegPass: WideString; safecall;
    procedure Set_RegAuthId(const AuthId: WideString); safecall;
    function Get_RegAuthId: WideString; safecall;
    procedure Set_RegExpire(Expire: Integer); safecall;
    function Get_RegExpire: Integer; safecall;
    procedure Set_ProxyDomain(const Domain: WideString); safecall;
    function Get_ProxyDomain: WideString; safecall;
    procedure Set_ProxyUser(const User: WideString); safecall;
    function Get_ProxyUser: WideString; safecall;
    procedure Set_ProxyPass(const Pass: WideString); safecall;
    function Get_ProxyPass: WideString; safecall;
    procedure Set_LicenseUserId(const UserId: WideString); safecall;
    function Get_LicenseUserId: WideString; safecall;
    procedure Set_LicenseKey(const Key: WideString); safecall;
    function Get_LicenseKey: WideString; safecall;
    function Get_CodecCount: Integer; safecall;
    function Get_CodecName(Index: Integer): WideString; safecall;
    function Get_CodecSelected(Index: Integer): Integer; safecall;
    procedure SetCodecOrder(const CodecsListAsStr: WideString; SelectedCount: Integer); safecall;
    function Load(const fileName: WideString): Integer; safecall;
    procedure Store(const fileName: WideString); safecall;
    procedure Set_SamplesPerSecond(Samples: Integer); safecall;
    function Get_SamplesPerSecond: Integer; safecall;
    procedure Set_ActiveNetworkInterface(const DeviceName: WideString); safecall;
    function Get_ActiveNetworkInterface: WideString; safecall;
    function Get_NetworkInterfaceCount: Integer; safecall;
    function Get_NetworkInterface(Index: Integer): WideString; safecall;
    procedure Set_DialToneEnabled(Enabled: Integer); safecall;
    function Get_DialToneEnabled: Integer; safecall;
    procedure Set_VolumeUpdateSubscribed(Enabled: Integer); safecall;
    function Get_VolumeUpdateSubscribed: Integer; safecall;
    procedure Set_LogLevel(level: LogLevelType); safecall;
    function Get_LogLevel: LogLevelType; safecall;
    procedure Set_AdditionalDnsServer(const dnsServerIPAddress: WideString); safecall;
    function Get_AdditionalDnsServer: WideString; safecall;
    procedure Set_AdditionalSDPContent(const sdpContent: WideString); safecall;
    function Get_AdditionalSDPContent: WideString; safecall;
    procedure Set_AutoAnswerEnabled(Enabled: Integer); safecall;
    function Get_AutoAnswerEnabled: Integer; safecall;
    procedure Set_MP3RecordingEnabled(Enabled: Integer); safecall;
    function Get_MP3RecordingEnabled: Integer; safecall;
    procedure Set_LocalAudioEnabled(Enabled: Integer); safecall;
    function Get_LocalAudioEnabled: Integer; safecall;
    procedure Set_LocalVideoWindow(hVideoWindow: LONG_PTR); safecall;
    function Get_LocalVideoWindow: LONG_PTR; safecall;
    procedure Set_RemoteVideoWindow(hVideoWindow: LONG_PTR); safecall;
    function Get_RemoteVideoWindow: LONG_PTR; safecall;
    procedure Set_RingToneEnabled(Enabled: Integer); safecall;
    function Get_RingToneEnabled: Integer; safecall;
    procedure Set_ActiveVideoDevice(const DeviceName: WideString); safecall;
    function Get_ActiveVideoDevice: WideString; safecall;
    function Get_VideoDeviceCount: Integer; safecall;
    function Get_VideoDevice(Index: Integer): WideString; safecall;
    procedure Set_VideoCallEnabled(Enabled: Integer); safecall;
    function Get_VideoCallEnabled: Integer; safecall;
    procedure Set_LocalTonesEnabled(Enabled: Integer); safecall;
    function Get_LocalTonesEnabled: Integer; safecall;
    procedure Set_CallInviteTimeout(sec: Integer); safecall;
    function Get_CallInviteTimeout: Integer; safecall;
    procedure Set_EncryptedCallEnabled(Enabled: Integer); safecall;
    function Get_EncryptedCallEnabled: Integer; safecall;
    procedure Set_MixerFilePlayerEnabled(Enabled: Integer); safecall;
    function Get_MixerFilePlayerEnabled: Integer; safecall;
    procedure Set_RegRealm(const Domain: WideString); safecall;
    function Get_RegRealm: WideString; safecall;
    procedure Set_KeepAliveTimeSIP(seconds: Integer); safecall;
    function Get_KeepAliveTimeSIP: Integer; safecall;
    procedure Set_KeepAliveTimeRTP(seconds: Integer); safecall;
    function Get_KeepAliveTimeRTP: Integer; safecall;
    procedure Set_ICEEnabled(Enabled: Integer); safecall;
    function Get_ICEEnabled: Integer; safecall;
    procedure Set_DtmfAsSipInfoEnabled(Enabled: Integer); safecall;
    function Get_DtmfAsSipInfoEnabled: Integer; safecall;
    procedure Set_RingToneFile(const wavFile: WideString); safecall;
    function Get_RingToneFile: WideString; safecall;
    procedure Set_LogPath(const logFilePath: WideString); safecall;
    function Get_LogPath: WideString; safecall;
    procedure Set_VideoFrameWidth(Width: Integer); safecall;
    function Get_VideoFrameWidth: Integer; safecall;
    procedure Set_VideoFrameHeight(Height: Integer); safecall;
    function Get_VideoFrameHeight: Integer; safecall;
    procedure Set_SDPInRingingMsgEnabled(Enabled: Integer); safecall;
    function Get_SDPInRingingMsgEnabled: Integer; safecall;
    procedure Set_SignallingTransport(transp: Integer); safecall;
    function Get_SignallingTransport: Integer; safecall;
    procedure Set_LoopbackNetworkInterfaceEnabled(Enabled: Integer); safecall;
    function Get_LoopbackNetworkInterfaceEnabled: Integer; safecall;
    function ExSipAccount_Count: Integer; safecall;
    procedure ExSipAccount_Get(ExAccountIdx: Integer; out Domain: WideString; out User: WideString; 
                               out Pass: WideString; out AuthId: WideString; 
                               out DisplName: WideString; out Expire: Integer; out bEnable: Integer); safecall;
    procedure ExSipAccount_Add(const Domain: WideString; const User: WideString; 
                               const Pass: WideString; const AuthId: WideString; 
                               const DisplName: WideString; Expire: Integer; bEnable: Integer; 
                               bDefault: Integer); safecall;
    procedure ExSipAccount_ResetAll; safecall;
    function ExSipAccount_GetDefaultIdx: Integer; safecall;
    procedure ExSipAccount_SetDefaultIdx(ExAccountIdx: Integer); safecall;
    procedure Set_FixedTransportInterfaceEnabled(Enabled: Integer); safecall;
    function Get_FixedTransportInterfaceEnabled: Integer; safecall;
    function LoadFromStr(const str: WideString): Integer; safecall;
    function StoreAsStr: WideString; safecall;
    procedure Set_ComfortNoiseOnMutedMicEnabled(Enabled: Integer); safecall;
    function Get_ComfortNoiseOnMutedMicEnabled: Integer; safecall;
    procedure Set_ProvisionalMode(mode: Integer); safecall;
    function Get_ProvisionalMode: Integer; safecall;
    procedure Set_SendRingingMsgEnabled(Enabled: Integer); safecall;
    function Get_SendRingingMsgEnabled: Integer; safecall;
    procedure Set_TonesTypesToDetect(types: Integer); safecall;
    function Get_TonesTypesToDetect: Integer; safecall;
    procedure ExSipAccount_Set(ExAccountIdx: Integer; const Domain: WideString; 
                               const User: WideString; const Pass: WideString; 
                               const AuthId: WideString; const DisplName: WideString; 
                               Expire: Integer; bEnable: Integer); safecall;
    function Get_ExSipAccountStr(ExAccountIdx: Integer): WideString; safecall;
    procedure Set_AudioQosDscpVal(val: Integer); safecall;
    function Get_AudioQosDscpVal: Integer; safecall;
    procedure Set_VideoQosDscpVal(val: Integer); safecall;
    function Get_VideoQosDscpVal: Integer; safecall;
    procedure Set_AudioSSRCVal(val: Integer); safecall;
    function Get_AudioSSRCVal: Integer; safecall;
    procedure Set_VideoSSRCVal(val: Integer); safecall;
    function Get_VideoSSRCVal: Integer; safecall;
    procedure Set_TonesBaudRate(rate: Double); safecall;
    function Get_TonesBaudRate: Double; safecall;
    procedure Set_OverrideRtpDest(const dest: WideString); safecall;
    function Get_OverrideRtpDest: WideString; safecall;
    procedure RemoteVideoWindow_Get(wndIdx: Integer; var hVideoWnd: LONG_PTR); safecall;
    procedure RemoteVideoWindow_Set(wndIdx: Integer; hVideoWnd: LONG_PTR); safecall;
    procedure RemoteVideoWindow_Add(hVideoWnd: LONG_PTR); safecall;
    procedure RemoteVideoWindow_ResetAll; safecall;
    procedure RemoteVideoWindow_Count(var pVal: Integer); safecall;
    procedure Set_AECDelayMs(ms: Integer); safecall;
    function Get_AECDelayMs: Integer; safecall;
    procedure Set_DmpCreateEnabled(Enabled: Integer); safecall;
    function Get_DmpCreateEnabled: Integer; safecall;
    procedure Set_VideoAutoSendEnabled(Enabled: Integer); safecall;
    function Get_VideoAutoSendEnabled: Integer; safecall;
    procedure Set_ProxyForceForAllRequests(Enabled: Integer); safecall;
    function Get_ProxyForceForAllRequests: Integer; safecall;
    procedure Set_IntenalVolumeImplEnabled(Enabled: WordBool); safecall;
    function Get_IntenalVolumeImplEnabled: WordBool; safecall;
    procedure Set_AppendExtToRecFileNameEnabled(Enabled: WordBool); safecall;
    function Get_AppendExtToRecFileNameEnabled: WordBool; safecall;
    procedure Set_SubscriptionExpire(Expire: Integer); safecall;
    function Get_SubscriptionExpire: Integer; safecall;
    procedure Set_TlsPrivKeyPass(const Pass: WideString); safecall;
    function Get_TlsPrivKeyPass: WideString; safecall;
    property StunServer: WideString read Get_StunServer write Set_StunServer;
    property ListenPort: Integer read Get_ListenPort write Set_ListenPort;
    property RtpStartPort: Integer read Get_RtpStartPort write Set_RtpStartPort;
    property ActivePlaybackDevice: WideString read Get_ActivePlaybackDevice write Set_ActivePlaybackDevice;
    property PlaybackDeviceCount: Integer read Get_PlaybackDeviceCount;
    property PlaybackDevice[Index: Integer]: WideString read Get_PlaybackDevice;
    property ActiveRecordDevice: WideString read Get_ActiveRecordDevice write Set_ActiveRecordDevice;
    property RecordDeviceCount: Integer read Get_RecordDeviceCount;
    property RecordDevice[Index: Integer]: WideString read Get_RecordDevice;
    property MinJitterDelay: Integer read Get_MinJitterDelay write Set_MinJitterDelay;
    property MaxJitterDelay: Integer read Get_MaxJitterDelay write Set_MaxJitterDelay;
    property SoundBufferDepth: Integer read Get_SoundBufferDepth write Set_SoundBufferDepth;
    property EchoCancelationEnabled: Integer read Get_EchoCancelationEnabled write Set_EchoCancelationEnabled;
    property SilenceDetectionEnabled: Integer read Get_SilenceDetectionEnabled write Set_SilenceDetectionEnabled;
    property AutoGainControlEnabled: Integer read Get_AutoGainControlEnabled write Set_AutoGainControlEnabled;
    property NoiseReductionEnabled: Integer read Get_NoiseReductionEnabled write Set_NoiseReductionEnabled;
    property UserAgent: WideString read Get_UserAgent write Set_UserAgent;
    property CallerId: WideString read Get_CallerId write Set_CallerId;
    property RegDomain: WideString read Get_RegDomain write Set_RegDomain;
    property RegUser: WideString read Get_RegUser write Set_RegUser;
    property RegPass: WideString read Get_RegPass write Set_RegPass;
    property RegAuthId: WideString read Get_RegAuthId write Set_RegAuthId;
    property RegExpire: Integer read Get_RegExpire write Set_RegExpire;
    property ProxyDomain: WideString read Get_ProxyDomain write Set_ProxyDomain;
    property ProxyUser: WideString read Get_ProxyUser write Set_ProxyUser;
    property ProxyPass: WideString read Get_ProxyPass write Set_ProxyPass;
    property LicenseUserId: WideString read Get_LicenseUserId write Set_LicenseUserId;
    property LicenseKey: WideString read Get_LicenseKey write Set_LicenseKey;
    property CodecCount: Integer read Get_CodecCount;
    property CodecName[Index: Integer]: WideString read Get_CodecName;
    property CodecSelected[Index: Integer]: Integer read Get_CodecSelected;
    property SamplesPerSecond: Integer read Get_SamplesPerSecond write Set_SamplesPerSecond;
    property ActiveNetworkInterface: WideString read Get_ActiveNetworkInterface write Set_ActiveNetworkInterface;
    property NetworkInterfaceCount: Integer read Get_NetworkInterfaceCount;
    property NetworkInterface[Index: Integer]: WideString read Get_NetworkInterface;
    property DialToneEnabled: Integer read Get_DialToneEnabled write Set_DialToneEnabled;
    property VolumeUpdateSubscribed: Integer read Get_VolumeUpdateSubscribed write Set_VolumeUpdateSubscribed;
    property LogLevel: LogLevelType read Get_LogLevel write Set_LogLevel;
    property AdditionalDnsServer: WideString read Get_AdditionalDnsServer write Set_AdditionalDnsServer;
    property AdditionalSDPContent: WideString read Get_AdditionalSDPContent write Set_AdditionalSDPContent;
    property AutoAnswerEnabled: Integer read Get_AutoAnswerEnabled write Set_AutoAnswerEnabled;
    property MP3RecordingEnabled: Integer read Get_MP3RecordingEnabled write Set_MP3RecordingEnabled;
    property LocalAudioEnabled: Integer read Get_LocalAudioEnabled write Set_LocalAudioEnabled;
    property LocalVideoWindow: LONG_PTR read Get_LocalVideoWindow write Set_LocalVideoWindow;
    property RemoteVideoWindow: LONG_PTR read Get_RemoteVideoWindow write Set_RemoteVideoWindow;
    property RingToneEnabled: Integer read Get_RingToneEnabled write Set_RingToneEnabled;
    property ActiveVideoDevice: WideString read Get_ActiveVideoDevice write Set_ActiveVideoDevice;
    property VideoDeviceCount: Integer read Get_VideoDeviceCount;
    property VideoDevice[Index: Integer]: WideString read Get_VideoDevice;
    property VideoCallEnabled: Integer read Get_VideoCallEnabled write Set_VideoCallEnabled;
    property LocalTonesEnabled: Integer read Get_LocalTonesEnabled write Set_LocalTonesEnabled;
    property CallInviteTimeout: Integer read Get_CallInviteTimeout write Set_CallInviteTimeout;
    property EncryptedCallEnabled: Integer read Get_EncryptedCallEnabled write Set_EncryptedCallEnabled;
    property MixerFilePlayerEnabled: Integer read Get_MixerFilePlayerEnabled write Set_MixerFilePlayerEnabled;
    property RegRealm: WideString read Get_RegRealm write Set_RegRealm;
    property KeepAliveTimeSIP: Integer read Get_KeepAliveTimeSIP write Set_KeepAliveTimeSIP;
    property KeepAliveTimeRTP: Integer read Get_KeepAliveTimeRTP write Set_KeepAliveTimeRTP;
    property ICEEnabled: Integer read Get_ICEEnabled write Set_ICEEnabled;
    property DtmfAsSipInfoEnabled: Integer read Get_DtmfAsSipInfoEnabled write Set_DtmfAsSipInfoEnabled;
    property RingToneFile: WideString read Get_RingToneFile write Set_RingToneFile;
    property LogPath: WideString read Get_LogPath write Set_LogPath;
    property VideoFrameWidth: Integer read Get_VideoFrameWidth write Set_VideoFrameWidth;
    property VideoFrameHeight: Integer read Get_VideoFrameHeight write Set_VideoFrameHeight;
    property SDPInRingingMsgEnabled: Integer read Get_SDPInRingingMsgEnabled write Set_SDPInRingingMsgEnabled;
    property SignallingTransport: Integer read Get_SignallingTransport write Set_SignallingTransport;
    property LoopbackNetworkInterfaceEnabled: Integer read Get_LoopbackNetworkInterfaceEnabled write Set_LoopbackNetworkInterfaceEnabled;
    property FixedTransportInterfaceEnabled: Integer read Get_FixedTransportInterfaceEnabled write Set_FixedTransportInterfaceEnabled;
    property ComfortNoiseOnMutedMicEnabled: Integer read Get_ComfortNoiseOnMutedMicEnabled write Set_ComfortNoiseOnMutedMicEnabled;
    property ProvisionalMode: Integer read Get_ProvisionalMode write Set_ProvisionalMode;
    property SendRingingMsgEnabled: Integer read Get_SendRingingMsgEnabled write Set_SendRingingMsgEnabled;
    property TonesTypesToDetect: Integer read Get_TonesTypesToDetect write Set_TonesTypesToDetect;
    property ExSipAccountStr[ExAccountIdx: Integer]: WideString read Get_ExSipAccountStr;
    property AudioQosDscpVal: Integer read Get_AudioQosDscpVal write Set_AudioQosDscpVal;
    property VideoQosDscpVal: Integer read Get_VideoQosDscpVal write Set_VideoQosDscpVal;
    property AudioSSRCVal: Integer read Get_AudioSSRCVal write Set_AudioSSRCVal;
    property VideoSSRCVal: Integer read Get_VideoSSRCVal write Set_VideoSSRCVal;
    property TonesBaudRate: Double read Get_TonesBaudRate write Set_TonesBaudRate;
    property OverrideRtpDest: WideString read Get_OverrideRtpDest write Set_OverrideRtpDest;
    property AECDelayMs: Integer read Get_AECDelayMs write Set_AECDelayMs;
    property DmpCreateEnabled: Integer read Get_DmpCreateEnabled write Set_DmpCreateEnabled;
    property VideoAutoSendEnabled: Integer read Get_VideoAutoSendEnabled write Set_VideoAutoSendEnabled;
    property ProxyForceForAllRequests: Integer read Get_ProxyForceForAllRequests write Set_ProxyForceForAllRequests;
    property IntenalVolumeImplEnabled: WordBool read Get_IntenalVolumeImplEnabled write Set_IntenalVolumeImplEnabled;
    property AppendExtToRecFileNameEnabled: WordBool read Get_AppendExtToRecFileNameEnabled write Set_AppendExtToRecFileNameEnabled;
    property SubscriptionExpire: Integer read Get_SubscriptionExpire write Set_SubscriptionExpire;
    property TlsPrivKeyPass: WideString read Get_TlsPrivKeyPass write Set_TlsPrivKeyPass;
  end;

// *********************************************************************//
// DispIntf:  IConfigDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {61E86A3E-6ED9-4B8E-88E0-DF9BEA33F54D}
// *********************************************************************//
  IConfigDisp = dispinterface
    ['{61E86A3E-6ED9-4B8E-88E0-DF9BEA33F54D}']
    property StunServer: WideString dispid 200;
    property ListenPort: Integer dispid 201;
    property RtpStartPort: Integer dispid 231;
    property ActivePlaybackDevice: WideString dispid 202;
    property PlaybackDeviceCount: Integer readonly dispid 203;
    property PlaybackDevice[Index: Integer]: WideString readonly dispid 204;
    property ActiveRecordDevice: WideString dispid 205;
    property RecordDeviceCount: Integer readonly dispid 206;
    property RecordDevice[Index: Integer]: WideString readonly dispid 207;
    property MinJitterDelay: Integer dispid 208;
    property MaxJitterDelay: Integer dispid 209;
    property SoundBufferDepth: Integer dispid 210;
    property EchoCancelationEnabled: Integer dispid 211;
    property SilenceDetectionEnabled: Integer dispid 212;
    property AutoGainControlEnabled: Integer dispid 213;
    property NoiseReductionEnabled: Integer dispid 262;
    property UserAgent: WideString dispid 214;
    property CallerId: WideString dispid 215;
    property RegDomain: WideString dispid 216;
    property RegUser: WideString dispid 217;
    property RegPass: WideString dispid 218;
    property RegAuthId: WideString dispid 219;
    property RegExpire: Integer dispid 221;
    property ProxyDomain: WideString dispid 222;
    property ProxyUser: WideString dispid 223;
    property ProxyPass: WideString dispid 224;
    property LicenseUserId: WideString dispid 225;
    property LicenseKey: WideString dispid 227;
    property CodecCount: Integer readonly dispid 228;
    property CodecName[Index: Integer]: WideString readonly dispid 229;
    property CodecSelected[Index: Integer]: Integer readonly dispid 230;
    procedure SetCodecOrder(const CodecsListAsStr: WideString; SelectedCount: Integer); dispid 1;
    function Load(const fileName: WideString): Integer; dispid 2;
    procedure Store(const fileName: WideString); dispid 3;
    property SamplesPerSecond: Integer dispid 240;
    property ActiveNetworkInterface: WideString dispid 241;
    property NetworkInterfaceCount: Integer readonly dispid 242;
    property NetworkInterface[Index: Integer]: WideString readonly dispid 243;
    property DialToneEnabled: Integer dispid 244;
    property VolumeUpdateSubscribed: Integer dispid 245;
    property LogLevel: LogLevelType dispid 246;
    property AdditionalDnsServer: WideString dispid 247;
    property AdditionalSDPContent: WideString dispid 248;
    property AutoAnswerEnabled: Integer dispid 249;
    property MP3RecordingEnabled: Integer dispid 250;
    property LocalAudioEnabled: Integer dispid 251;
    property LocalVideoWindow: LONG_PTR dispid 252;
    property RemoteVideoWindow: LONG_PTR dispid 253;
    property RingToneEnabled: Integer dispid 254;
    property ActiveVideoDevice: WideString dispid 255;
    property VideoDeviceCount: Integer readonly dispid 256;
    property VideoDevice[Index: Integer]: WideString readonly dispid 257;
    property VideoCallEnabled: Integer dispid 258;
    property LocalTonesEnabled: Integer dispid 259;
    property CallInviteTimeout: Integer dispid 260;
    property EncryptedCallEnabled: Integer dispid 261;
    property MixerFilePlayerEnabled: Integer dispid 263;
    property RegRealm: WideString dispid 264;
    property KeepAliveTimeSIP: Integer dispid 265;
    property KeepAliveTimeRTP: Integer dispid 266;
    property ICEEnabled: Integer dispid 267;
    property DtmfAsSipInfoEnabled: Integer dispid 268;
    property RingToneFile: WideString dispid 269;
    property LogPath: WideString dispid 270;
    property VideoFrameWidth: Integer dispid 271;
    property VideoFrameHeight: Integer dispid 272;
    property SDPInRingingMsgEnabled: Integer dispid 273;
    property SignallingTransport: Integer dispid 274;
    property LoopbackNetworkInterfaceEnabled: Integer dispid 275;
    function ExSipAccount_Count: Integer; dispid 4;
    procedure ExSipAccount_Get(ExAccountIdx: Integer; out Domain: WideString; out User: WideString; 
                               out Pass: WideString; out AuthId: WideString; 
                               out DisplName: WideString; out Expire: Integer; out bEnable: Integer); dispid 5;
    procedure ExSipAccount_Add(const Domain: WideString; const User: WideString; 
                               const Pass: WideString; const AuthId: WideString; 
                               const DisplName: WideString; Expire: Integer; bEnable: Integer; 
                               bDefault: Integer); dispid 6;
    procedure ExSipAccount_ResetAll; dispid 7;
    function ExSipAccount_GetDefaultIdx: Integer; dispid 8;
    procedure ExSipAccount_SetDefaultIdx(ExAccountIdx: Integer); dispid 11;
    property FixedTransportInterfaceEnabled: Integer dispid 276;
    function LoadFromStr(const str: WideString): Integer; dispid 9;
    function StoreAsStr: WideString; dispid 10;
    property ComfortNoiseOnMutedMicEnabled: Integer dispid 277;
    property ProvisionalMode: Integer dispid 278;
    property SendRingingMsgEnabled: Integer dispid 279;
    property TonesTypesToDetect: Integer dispid 280;
    procedure ExSipAccount_Set(ExAccountIdx: Integer; const Domain: WideString; 
                               const User: WideString; const Pass: WideString; 
                               const AuthId: WideString; const DisplName: WideString; 
                               Expire: Integer; bEnable: Integer); dispid 12;
    property ExSipAccountStr[ExAccountIdx: Integer]: WideString readonly dispid 281;
    property AudioQosDscpVal: Integer dispid 282;
    property VideoQosDscpVal: Integer dispid 283;
    property AudioSSRCVal: Integer dispid 284;
    property VideoSSRCVal: Integer dispid 285;
    property TonesBaudRate: Double dispid 286;
    property OverrideRtpDest: WideString dispid 287;
    procedure RemoteVideoWindow_Get(wndIdx: Integer; var hVideoWnd: LONG_PTR); dispid 13;
    procedure RemoteVideoWindow_Set(wndIdx: Integer; hVideoWnd: LONG_PTR); dispid 14;
    procedure RemoteVideoWindow_Add(hVideoWnd: LONG_PTR); dispid 15;
    procedure RemoteVideoWindow_ResetAll; dispid 16;
    procedure RemoteVideoWindow_Count(var pVal: Integer); dispid 17;
    property AECDelayMs: Integer dispid 288;
    property DmpCreateEnabled: Integer dispid 289;
    property VideoAutoSendEnabled: Integer dispid 290;
    property ProxyForceForAllRequests: Integer dispid 291;
    property IntenalVolumeImplEnabled: WordBool dispid 292;
    property AppendExtToRecFileNameEnabled: WordBool dispid 293;
    property SubscriptionExpire: Integer dispid 294;
    property TlsPrivKeyPass: WideString dispid 295;
  end;

// *********************************************************************//
// Interface: ISubscriptions
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D7CB76AD-3559-4FF4-8313-41CCA1A6ED19}
// *********************************************************************//
  ISubscriptions = interface(IDispatch)
    ['{D7CB76AD-3559-4FF4-8313-41CCA1A6ED19}']
    function SubscribeBLF(const sipUri: WideString): Integer; safecall;
    function SubscribePresence(const sipUri: WideString): Integer; safecall;
    procedure UnSubscribeBLF(subscriptionId: Integer); safecall;
    procedure UnSubscribePresence(subscriptionId: Integer); safecall;
    function SubscribeMessageSummary: Integer; safecall;
    procedure UnSubscribeMessageSummary(subscriptionId: Integer); safecall;
    procedure Notify; safecall;
    procedure NotifyBLF; safecall;
    procedure NotifyPresence(open: Integer; const status: WideString); safecall;
    procedure Accept; safecall;
    procedure Reject; safecall;
    function SubscribeCustomEvent(const event: WideString; const mimeSubType: WideString; 
                                  const sipUri: WideString): Integer; safecall;
    procedure UnSubscribeCustomEvent(subscriptionId: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  ISubscriptionsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D7CB76AD-3559-4FF4-8313-41CCA1A6ED19}
// *********************************************************************//
  ISubscriptionsDisp = dispinterface
    ['{D7CB76AD-3559-4FF4-8313-41CCA1A6ED19}']
    function SubscribeBLF(const sipUri: WideString): Integer; dispid 2;
    function SubscribePresence(const sipUri: WideString): Integer; dispid 3;
    procedure UnSubscribeBLF(subscriptionId: Integer); dispid 5;
    procedure UnSubscribePresence(subscriptionId: Integer); dispid 6;
    function SubscribeMessageSummary: Integer; dispid 12;
    procedure UnSubscribeMessageSummary(subscriptionId: Integer); dispid 13;
    procedure Notify; dispid 7;
    procedure NotifyBLF; dispid 8;
    procedure NotifyPresence(open: Integer; const status: WideString); dispid 9;
    procedure Accept; dispid 10;
    procedure Reject; dispid 11;
    function SubscribeCustomEvent(const event: WideString; const mimeSubType: WideString; 
                                  const sipUri: WideString): Integer; dispid 14;
    procedure UnSubscribeCustomEvent(subscriptionId: Integer); dispid 15;
  end;

// *********************************************************************//
// DispIntf:  _IAbtoPhoneEvents
// Flags:     (4096) Dispatchable
// GUID:      {4EBC3861-0D3F-48A3-8322-E45E74DBDEF5}
// *********************************************************************//
  _IAbtoPhoneEvents = dispinterface
    ['{4EBC3861-0D3F-48A3-8322-E45E74DBDEF5}']
    procedure OnInitialized(const Msg: WideString); dispid 1;
    procedure OnLineSwiched(LineId: Integer); dispid 2;
    procedure OnEstablishedConnection(const AddrFrom: WideString; const AddrTo: WideString; 
                                      ConnectionId: Integer; LineId: Integer); dispid 3;
    procedure OnClearedConnection(ConnectionId: Integer; LineId: Integer); dispid 4;
    procedure OnIncomingCall(const AddrFrom: WideString; LineId: Integer); dispid 5;
    procedure OnEstablishedCall(const Msg: WideString; LineId: Integer); dispid 6;
    procedure OnClearedCall(const Msg: WideString; status: Integer; LineId: Integer); dispid 7;
    procedure OnVolumeUpdated(IsMicrophone: Integer; level: Integer); dispid 8;
    procedure OnRegistered(const Msg: WideString); dispid 9;
    procedure OnUnRegistered(const Msg: WideString); dispid 10;
    procedure OnPlayFinished(const Msg: WideString); dispid 11;
    procedure OnToneReceived(Tone: Integer; ConnectionId: Integer; LineId: Integer); dispid 12;
    procedure OnTextMessageReceived(const address: WideString; const message: WideString); dispid 13;
    procedure OnPhoneNotify(const Msg: WideString); dispid 14;
    procedure OnRemoteAlerting(ConnectionId: Integer; responseCode: Integer; 
                               const reasonMsg: WideString); dispid 15;
    procedure OnHoldCall(LineId: Integer; isHeld: Integer); dispid 16;
    procedure OnTextMessageSentStatus(const address: WideString; const reason: WideString; 
                                      bSuccess: Integer); dispid 17;
    procedure OnRecordFinished(const Msg: WideString); dispid 18;
    procedure OnSubscribeStatus(subscriptionId: Integer; statusCode: Integer; 
                                const statusMsg: WideString); dispid 19;
    procedure OnUnSubscribeStatus(subscriptionId: Integer; statusCode: Integer; 
                                  const statusMsg: WideString); dispid 20;
    procedure OnSubscriptionRequest(const fromUri: WideString; const eventStr: WideString); dispid 21;
    procedure OnSubscriptionNotify(subscriptionId: Integer; const StateStr: WideString; 
                                   const NotifyStr: WideString); dispid 22;
    procedure OnDetectedAnswerTime(TimeSpanMs: Integer; ConnectionId: Integer); dispid 23;
    procedure OnBaudotToneReceived(Tone: Integer; ConnectionId: Integer; LineId: Integer); dispid 24;
    procedure OnSubscriptionTerminated(const fromUri: WideString); dispid 25;
    procedure OnToneDetected(tType: ToneType; const ToneStr: WideString; ConnectionId: Integer; 
                             LineId: Integer); dispid 26;
    procedure OnReceivedSipNotifyMsg(const SipNotifyMsgStr: WideString); dispid 27;
    procedure OnPlayFinished2(const Msg: WideString; LineId: Integer); dispid 28;
    procedure OnRemoteAlerting2(ConnectionId: Integer; LineId: Integer; responseCode: Integer; 
                                const reasonMsg: WideString); dispid 29;
    procedure OnReceivedRequestInfo(ConnectionId: Integer; LineId: Integer; 
                                    const contentType: WideString; const body: WideString); dispid 30;
    procedure OnBaudotFinished(const Msg: WideString; LineId: Integer); dispid 31;
  end;

// *********************************************************************//
// Interface: IAbtoPhone
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9EE5EB0-F289-45FA-836E-6F381A306FC5}
// *********************************************************************//
  IAbtoPhone = interface(IDispatch)
    ['{F9EE5EB0-F289-45FA-836E-6F381A306FC5}']
    procedure Initialize; safecall;
    procedure InitializeEx(sendEventsFromSameThread: Integer); safecall;
    procedure SetCurrentLine(LineId: Integer); safecall;
    procedure StartCall(const Destination: WideString); safecall;
    procedure HangUp(ConnectionId: Integer); safecall;
    procedure HangUpLastCall; safecall;
    procedure AnswerCall; safecall;
    procedure RejectCall; safecall;
    procedure TransferCall(const Destination: WideString); safecall;
    procedure AttendedTransferCall(LineId: Integer); safecall;
    procedure HoldRetrieveCurrentCall; safecall;
    procedure JoinToCurrentCall(LineId: Integer); safecall;
    function PlayFile(const FilePath: WideString): Integer; safecall;
    procedure StopPlayback; safecall;
    procedure StartRecording(const FilePath: WideString); safecall;
    procedure StopRecording; safecall;
    procedure SendTextMessage(const address: WideString; const message: WideString; 
                              bSendUnicode: Integer); safecall;
    procedure SendTone(const Tone: WideString); safecall;
    procedure AppendWav(const DestinationFilename: WideString; const SourceFilename: WideString); safecall;
    function RetrieveExternalAddress: WideString; safecall;
    procedure ApplyConfig; safecall;
    procedure CancelConfig; safecall;
    function Get_Config: IConfig; safecall;
    procedure Set_PlaybackVolume(level: Integer); safecall;
    function Get_PlaybackVolume: Integer; safecall;
    procedure Set_PlaybackMuted(Muted: Integer); safecall;
    function Get_PlaybackMuted: Integer; safecall;
    procedure Set_RecordVolume(level: Integer); safecall;
    function Get_RecordVolume: Integer; safecall;
    procedure Set_RecordMuted(Muted: Integer); safecall;
    function Get_RecordMuted: Integer; safecall;
    procedure SetConnectionContribution(ConnectionId: Integer; inputGain: Integer; 
                                        outputGain: Integer); safecall;
    procedure SetConnectionContributionRelated(ConnectionIdInput: Integer; 
                                               ConnectionIdOutput: Integer; inputGain: Integer; 
                                               outputGain: Integer); safecall;
    procedure SetConnectionContributionRelatedLocal(ConnectionIdInput: Integer; inputGain: Integer; 
                                                    outputGain: Integer); safecall;
    function IsLineOccupied(LineId: Integer): Integer; safecall;
    procedure TransferConnection(ConnectionId: Integer; const Destination: WideString); safecall;
    function SDKPath: WideString; safecall;
    procedure PlayBuffer(bufferPtr: Int64; size: Integer; rate: Integer); safecall;
    procedure StartRecordingBuffer(bufferPtr: Int64; size: Integer); safecall;
    function RetrieveVersion: WideString; safecall;
    function Get_Subscriptions: ISubscriptions; safecall;
    function GetSIPHeaderValue(const Header: WideString): WideString; safecall;
    procedure SetSIPHeaderValue(const Header: WideString; const HeaderVal: WideString); safecall;
    procedure StartRecordingConnection(ConnectionId: Integer; const FilePath: WideString); safecall;
    procedure StopRecordingConnection(ConnectionId: Integer); safecall;
    function GetSIPBodyMultiPartMimeText(PartIdx: Integer): WideString; safecall;
    procedure SendToneEx(Tone: Integer; Duration: Integer; bSendAudio_InBand: Integer; 
                         bSend_RFC4733_OutOfBand: Integer; bSend_SIP_INFO: Integer); safecall;
    procedure HoldRetrieveCall(LineId: Integer); safecall;
    function GetSIPHeaderValueLine(const Header: WideString; LineId: Integer): WideString; safecall;
    procedure SendBaudotTone(BaudotTone: Integer); safecall;
    function DnsSrvLookup(const sipSrvName: WideString): Integer; safecall;
    procedure DnsSrvGetDetails(receivedRecordIndex: Integer; out hostName: WideString; 
                               out srcIP: WideString; out Port: Integer; out priority: Integer; 
                               out weight: Integer); safecall;
    function PlayFileLine(const FilePath: WideString; LineId: Integer): Integer; safecall;
    procedure SetPlayingFileContribution(gain: Integer); safecall;
    procedure StartVoiceEnergyDetectionPeriod(timeOutMs: Integer; minEnergyValue: Integer; 
                                              maxEnergyValue: Integer; ConnectionId: Integer); safecall;
    procedure StopPlaybackLine(LineId: Integer); safecall;
    procedure SyncDevicesList; safecall;
    procedure RestartAudioSubsystem; safecall;
    procedure StartSendingNoise(Tone1AmpPermille: Integer; Tone2AmpPermille: Integer; 
                                IntervalMs: Integer; FrequencyHz: Integer); safecall;
    function HasSIPBodyVideoMedia(LineId: Integer): Integer; safecall;
    procedure MoveConnectionToLine(LineId: Integer; ConnectionId: Integer); safecall;
    procedure StartRecordingConnectionBuffer(ConnectionId: Integer; bufferPtr: Int64; size: Integer); safecall;
    procedure BindToAudioDevices; safecall;
    procedure AttendedTransferCallLine(fromLineId: Integer; toLineId: Integer); safecall;
    procedure SendBaudotString(const BaudotString: WideString); safecall;
    procedure RestartAudioSubsystemEx(const PrimaryPlaybackDvc: WideString; 
                                      const SecPlaybackDvc: WideString; 
                                      const PrimaryRecordDvc: WideString; 
                                      const SecRecordDvc: WideString); safecall;
    function GetSIPHeaderValueLineArr(const Header: WideString; LineId: Integer): OleVariant; safecall;
    procedure MuteLocalVideo(bMute: Integer); safecall;
    function StartCall2(const Destination: WideString): Integer; safecall;
    function StartCallEx(const Destination: WideString; const FromDisplName: WideString): Integer; safecall;
    procedure UpdateCall(ConnectionId: Integer; const FromDisplName: WideString; 
                         bSendInvite: WordBool); safecall;
    procedure SendRequestInfo(ConnectionId: Integer; const contentType: WideString; 
                              const Msg: WideString); safecall;
    function StartCallExLine(LineId: Integer; const Destination: WideString; 
                             const FromDisplName: WideString): Integer; safecall;
    procedure MakeDumpFile; safecall;
    procedure AnswerCallLine(LineId: Integer); safecall;
    procedure RejectCallLine(LineId: Integer); safecall;
    function GetSIPMessageLine(LineId: Integer): WideString; safecall;
    procedure AssignVideoWindow(ConnectionId: Integer; hVideoWindow: LONG_PTR); safecall;
    function StartCall3(const Destination: WideString; const FromUserName: WideString): Integer; safecall;
    procedure SendBaudotTone2(BaudotTone: Integer; gain: Integer); safecall;
    procedure SendBaudotString2(const BaudotString: WideString; gain: Integer); safecall;
    procedure SendRequestMWINotify(const Destination: WideString; const body: WideString); safecall;
    function StartCall4(const Destination: WideString; transp: TransportType): Integer; safecall;
    property Config: IConfig read Get_Config;
    property PlaybackVolume: Integer read Get_PlaybackVolume write Set_PlaybackVolume;
    property PlaybackMuted: Integer read Get_PlaybackMuted write Set_PlaybackMuted;
    property RecordVolume: Integer read Get_RecordVolume write Set_RecordVolume;
    property RecordMuted: Integer read Get_RecordMuted write Set_RecordMuted;
    property Subscriptions: ISubscriptions read Get_Subscriptions;
  end;

// *********************************************************************//
// DispIntf:  IAbtoPhoneDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9EE5EB0-F289-45FA-836E-6F381A306FC5}
// *********************************************************************//
  IAbtoPhoneDisp = dispinterface
    ['{F9EE5EB0-F289-45FA-836E-6F381A306FC5}']
    procedure Initialize; dispid 1;
    procedure InitializeEx(sendEventsFromSameThread: Integer); dispid 2;
    procedure SetCurrentLine(LineId: Integer); dispid 3;
    procedure StartCall(const Destination: WideString); dispid 4;
    procedure HangUp(ConnectionId: Integer); dispid 5;
    procedure HangUpLastCall; dispid 6;
    procedure AnswerCall; dispid 7;
    procedure RejectCall; dispid 8;
    procedure TransferCall(const Destination: WideString); dispid 9;
    procedure AttendedTransferCall(LineId: Integer); dispid 10;
    procedure HoldRetrieveCurrentCall; dispid 11;
    procedure JoinToCurrentCall(LineId: Integer); dispid 12;
    function PlayFile(const FilePath: WideString): Integer; dispid 13;
    procedure StopPlayback; dispid 14;
    procedure StartRecording(const FilePath: WideString); dispid 15;
    procedure StopRecording; dispid 16;
    procedure SendTextMessage(const address: WideString; const message: WideString; 
                              bSendUnicode: Integer); dispid 17;
    procedure SendTone(const Tone: WideString); dispid 18;
    procedure AppendWav(const DestinationFilename: WideString; const SourceFilename: WideString); dispid 19;
    function RetrieveExternalAddress: WideString; dispid 20;
    procedure ApplyConfig; dispid 21;
    procedure CancelConfig; dispid 28;
    property Config: IConfig readonly dispid 200;
    property PlaybackVolume: Integer dispid 201;
    property PlaybackMuted: Integer dispid 202;
    property RecordVolume: Integer dispid 203;
    property RecordMuted: Integer dispid 204;
    procedure SetConnectionContribution(ConnectionId: Integer; inputGain: Integer; 
                                        outputGain: Integer); dispid 22;
    procedure SetConnectionContributionRelated(ConnectionIdInput: Integer; 
                                               ConnectionIdOutput: Integer; inputGain: Integer; 
                                               outputGain: Integer); dispid 24;
    procedure SetConnectionContributionRelatedLocal(ConnectionIdInput: Integer; inputGain: Integer; 
                                                    outputGain: Integer); dispid 25;
    function IsLineOccupied(LineId: Integer): Integer; dispid 23;
    procedure TransferConnection(ConnectionId: Integer; const Destination: WideString); dispid 26;
    function SDKPath: WideString; dispid 27;
    procedure PlayBuffer(bufferPtr: {??Int64}OleVariant; size: Integer; rate: Integer); dispid 29;
    procedure StartRecordingBuffer(bufferPtr: {??Int64}OleVariant; size: Integer); dispid 30;
    function RetrieveVersion: WideString; dispid 31;
    property Subscriptions: ISubscriptions readonly dispid 206;
    function GetSIPHeaderValue(const Header: WideString): WideString; dispid 32;
    procedure SetSIPHeaderValue(const Header: WideString; const HeaderVal: WideString); dispid 33;
    procedure StartRecordingConnection(ConnectionId: Integer; const FilePath: WideString); dispid 34;
    procedure StopRecordingConnection(ConnectionId: Integer); dispid 35;
    function GetSIPBodyMultiPartMimeText(PartIdx: Integer): WideString; dispid 36;
    procedure SendToneEx(Tone: Integer; Duration: Integer; bSendAudio_InBand: Integer; 
                         bSend_RFC4733_OutOfBand: Integer; bSend_SIP_INFO: Integer); dispid 37;
    procedure HoldRetrieveCall(LineId: Integer); dispid 38;
    function GetSIPHeaderValueLine(const Header: WideString; LineId: Integer): WideString; dispid 39;
    procedure SendBaudotTone(BaudotTone: Integer); dispid 40;
    function DnsSrvLookup(const sipSrvName: WideString): Integer; dispid 41;
    procedure DnsSrvGetDetails(receivedRecordIndex: Integer; out hostName: WideString; 
                               out srcIP: WideString; out Port: Integer; out priority: Integer; 
                               out weight: Integer); dispid 42;
    function PlayFileLine(const FilePath: WideString; LineId: Integer): Integer; dispid 43;
    procedure SetPlayingFileContribution(gain: Integer); dispid 44;
    procedure StartVoiceEnergyDetectionPeriod(timeOutMs: Integer; minEnergyValue: Integer; 
                                              maxEnergyValue: Integer; ConnectionId: Integer); dispid 45;
    procedure StopPlaybackLine(LineId: Integer); dispid 46;
    procedure SyncDevicesList; dispid 47;
    procedure RestartAudioSubsystem; dispid 48;
    procedure StartSendingNoise(Tone1AmpPermille: Integer; Tone2AmpPermille: Integer; 
                                IntervalMs: Integer; FrequencyHz: Integer); dispid 49;
    function HasSIPBodyVideoMedia(LineId: Integer): Integer; dispid 50;
    procedure MoveConnectionToLine(LineId: Integer; ConnectionId: Integer); dispid 51;
    procedure StartRecordingConnectionBuffer(ConnectionId: Integer; bufferPtr: {??Int64}OleVariant; 
                                             size: Integer); dispid 52;
    procedure BindToAudioDevices; dispid 53;
    procedure AttendedTransferCallLine(fromLineId: Integer; toLineId: Integer); dispid 54;
    procedure SendBaudotString(const BaudotString: WideString); dispid 55;
    procedure RestartAudioSubsystemEx(const PrimaryPlaybackDvc: WideString; 
                                      const SecPlaybackDvc: WideString; 
                                      const PrimaryRecordDvc: WideString; 
                                      const SecRecordDvc: WideString); dispid 56;
    function GetSIPHeaderValueLineArr(const Header: WideString; LineId: Integer): OleVariant; dispid 57;
    procedure MuteLocalVideo(bMute: Integer); dispid 58;
    function StartCall2(const Destination: WideString): Integer; dispid 59;
    function StartCallEx(const Destination: WideString; const FromDisplName: WideString): Integer; dispid 60;
    procedure UpdateCall(ConnectionId: Integer; const FromDisplName: WideString; 
                         bSendInvite: WordBool); dispid 61;
    procedure SendRequestInfo(ConnectionId: Integer; const contentType: WideString; 
                              const Msg: WideString); dispid 62;
    function StartCallExLine(LineId: Integer; const Destination: WideString; 
                             const FromDisplName: WideString): Integer; dispid 63;
    procedure MakeDumpFile; dispid 64;
    procedure AnswerCallLine(LineId: Integer); dispid 65;
    procedure RejectCallLine(LineId: Integer); dispid 66;
    function GetSIPMessageLine(LineId: Integer): WideString; dispid 67;
    procedure AssignVideoWindow(ConnectionId: Integer; hVideoWindow: LONG_PTR); dispid 68;
    function StartCall3(const Destination: WideString; const FromUserName: WideString): Integer; dispid 69;
    procedure SendBaudotTone2(BaudotTone: Integer; gain: Integer); dispid 70;
    procedure SendBaudotString2(const BaudotString: WideString; gain: Integer); dispid 71;
    procedure SendRequestMWINotify(const Destination: WideString; const body: WideString); dispid 72;
    function StartCall4(const Destination: WideString; transp: TransportType): Integer; dispid 73;
  end;

// *********************************************************************//
// The Class CoCConfig provides a Create and CreateRemote method to          
// create instances of the default interface IConfig exposed by              
// the CoClass CConfig. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCConfig = class
    class function Create: IConfig;
    class function CreateRemote(const MachineName: string): IConfig;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCConfig
// Help String      : Config Class
// Default Interface: IConfig
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCConfigProperties= class;
{$ENDIF}
  TCConfig = class(TOleServer)
  private
    FIntf: IConfig;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCConfigProperties;
    function GetServerProperties: TCConfigProperties;
{$ENDIF}
    function GetDefaultInterface: IConfig;
  protected
    procedure InitServerData; override;
    procedure Set_StunServer(const StunAddress: WideString);
    function Get_StunServer: WideString;
    procedure Set_ListenPort(Port: Integer);
    function Get_ListenPort: Integer;
    procedure Set_RtpStartPort(Port: Integer);
    function Get_RtpStartPort: Integer;
    procedure Set_ActivePlaybackDevice(const DeviceName: WideString);
    function Get_ActivePlaybackDevice: WideString;
    function Get_PlaybackDeviceCount: Integer;
    function Get_PlaybackDevice(Index: Integer): WideString;
    procedure Set_ActiveRecordDevice(const DeviceName: WideString);
    function Get_ActiveRecordDevice: WideString;
    function Get_RecordDeviceCount: Integer;
    function Get_RecordDevice(Index: Integer): WideString;
    procedure Set_MinJitterDelay(Delay: Integer);
    function Get_MinJitterDelay: Integer;
    procedure Set_MaxJitterDelay(Delay: Integer);
    function Get_MaxJitterDelay: Integer;
    procedure Set_SoundBufferDepth(Depth: Integer);
    function Get_SoundBufferDepth: Integer;
    procedure Set_EchoCancelationEnabled(Enabled: Integer);
    function Get_EchoCancelationEnabled: Integer;
    procedure Set_SilenceDetectionEnabled(Enabled: Integer);
    function Get_SilenceDetectionEnabled: Integer;
    procedure Set_AutoGainControlEnabled(Enabled: Integer);
    function Get_AutoGainControlEnabled: Integer;
    procedure Set_NoiseReductionEnabled(Enabled: Integer);
    function Get_NoiseReductionEnabled: Integer;
    procedure Set_UserAgent(const AgentName: WideString);
    function Get_UserAgent: WideString;
    procedure Set_CallerId(const Id: WideString);
    function Get_CallerId: WideString;
    procedure Set_RegDomain(const Domain: WideString);
    function Get_RegDomain: WideString;
    procedure Set_RegUser(const User: WideString);
    function Get_RegUser: WideString;
    procedure Set_RegPass(const Pass: WideString);
    function Get_RegPass: WideString;
    procedure Set_RegAuthId(const AuthId: WideString);
    function Get_RegAuthId: WideString;
    procedure Set_RegExpire(Expire: Integer);
    function Get_RegExpire: Integer;
    procedure Set_ProxyDomain(const Domain: WideString);
    function Get_ProxyDomain: WideString;
    procedure Set_ProxyUser(const User: WideString);
    function Get_ProxyUser: WideString;
    procedure Set_ProxyPass(const Pass: WideString);
    function Get_ProxyPass: WideString;
    procedure Set_LicenseUserId(const UserId: WideString);
    function Get_LicenseUserId: WideString;
    procedure Set_LicenseKey(const Key: WideString);
    function Get_LicenseKey: WideString;
    function Get_CodecCount: Integer;
    function Get_CodecName(Index: Integer): WideString;
    function Get_CodecSelected(Index: Integer): Integer;
    procedure Set_SamplesPerSecond(Samples: Integer);
    function Get_SamplesPerSecond: Integer;
    procedure Set_ActiveNetworkInterface(const DeviceName: WideString);
    function Get_ActiveNetworkInterface: WideString;
    function Get_NetworkInterfaceCount: Integer;
    function Get_NetworkInterface(Index: Integer): WideString;
    procedure Set_DialToneEnabled(Enabled: Integer);
    function Get_DialToneEnabled: Integer;
    procedure Set_VolumeUpdateSubscribed(Enabled: Integer);
    function Get_VolumeUpdateSubscribed: Integer;
    procedure Set_LogLevel(level: LogLevelType);
    function Get_LogLevel: LogLevelType;
    procedure Set_AdditionalDnsServer(const dnsServerIPAddress: WideString);
    function Get_AdditionalDnsServer: WideString;
    procedure Set_AdditionalSDPContent(const sdpContent: WideString);
    function Get_AdditionalSDPContent: WideString;
    procedure Set_AutoAnswerEnabled(Enabled: Integer);
    function Get_AutoAnswerEnabled: Integer;
    procedure Set_MP3RecordingEnabled(Enabled: Integer);
    function Get_MP3RecordingEnabled: Integer;
    procedure Set_LocalAudioEnabled(Enabled: Integer);
    function Get_LocalAudioEnabled: Integer;
    procedure Set_LocalVideoWindow(hVideoWindow: LONG_PTR);
    function Get_LocalVideoWindow: LONG_PTR;
    procedure Set_RemoteVideoWindow(hVideoWindow: LONG_PTR);
    function Get_RemoteVideoWindow: LONG_PTR;
    procedure Set_RingToneEnabled(Enabled: Integer);
    function Get_RingToneEnabled: Integer;
    procedure Set_ActiveVideoDevice(const DeviceName: WideString);
    function Get_ActiveVideoDevice: WideString;
    function Get_VideoDeviceCount: Integer;
    function Get_VideoDevice(Index: Integer): WideString;
    procedure Set_VideoCallEnabled(Enabled: Integer);
    function Get_VideoCallEnabled: Integer;
    procedure Set_LocalTonesEnabled(Enabled: Integer);
    function Get_LocalTonesEnabled: Integer;
    procedure Set_CallInviteTimeout(sec: Integer);
    function Get_CallInviteTimeout: Integer;
    procedure Set_EncryptedCallEnabled(Enabled: Integer);
    function Get_EncryptedCallEnabled: Integer;
    procedure Set_MixerFilePlayerEnabled(Enabled: Integer);
    function Get_MixerFilePlayerEnabled: Integer;
    procedure Set_RegRealm(const Domain: WideString);
    function Get_RegRealm: WideString;
    procedure Set_KeepAliveTimeSIP(seconds: Integer);
    function Get_KeepAliveTimeSIP: Integer;
    procedure Set_KeepAliveTimeRTP(seconds: Integer);
    function Get_KeepAliveTimeRTP: Integer;
    procedure Set_ICEEnabled(Enabled: Integer);
    function Get_ICEEnabled: Integer;
    procedure Set_DtmfAsSipInfoEnabled(Enabled: Integer);
    function Get_DtmfAsSipInfoEnabled: Integer;
    procedure Set_RingToneFile(const wavFile: WideString);
    function Get_RingToneFile: WideString;
    procedure Set_LogPath(const logFilePath: WideString);
    function Get_LogPath: WideString;
    procedure Set_VideoFrameWidth(Width: Integer);
    function Get_VideoFrameWidth: Integer;
    procedure Set_VideoFrameHeight(Height: Integer);
    function Get_VideoFrameHeight: Integer;
    procedure Set_SDPInRingingMsgEnabled(Enabled: Integer);
    function Get_SDPInRingingMsgEnabled: Integer;
    procedure Set_SignallingTransport(transp: Integer);
    function Get_SignallingTransport: Integer;
    procedure Set_LoopbackNetworkInterfaceEnabled(Enabled: Integer);
    function Get_LoopbackNetworkInterfaceEnabled: Integer;
    procedure Set_FixedTransportInterfaceEnabled(Enabled: Integer);
    function Get_FixedTransportInterfaceEnabled: Integer;
    procedure Set_ComfortNoiseOnMutedMicEnabled(Enabled: Integer);
    function Get_ComfortNoiseOnMutedMicEnabled: Integer;
    procedure Set_ProvisionalMode(mode: Integer);
    function Get_ProvisionalMode: Integer;
    procedure Set_SendRingingMsgEnabled(Enabled: Integer);
    function Get_SendRingingMsgEnabled: Integer;
    procedure Set_TonesTypesToDetect(types: Integer);
    function Get_TonesTypesToDetect: Integer;
    function Get_ExSipAccountStr(ExAccountIdx: Integer): WideString;
    procedure Set_AudioQosDscpVal(val: Integer);
    function Get_AudioQosDscpVal: Integer;
    procedure Set_VideoQosDscpVal(val: Integer);
    function Get_VideoQosDscpVal: Integer;
    procedure Set_AudioSSRCVal(val: Integer);
    function Get_AudioSSRCVal: Integer;
    procedure Set_VideoSSRCVal(val: Integer);
    function Get_VideoSSRCVal: Integer;
    procedure Set_TonesBaudRate(rate: Double);
    function Get_TonesBaudRate: Double;
    procedure Set_OverrideRtpDest(const dest: WideString);
    function Get_OverrideRtpDest: WideString;
    procedure Set_AECDelayMs(ms: Integer);
    function Get_AECDelayMs: Integer;
    procedure Set_DmpCreateEnabled(Enabled: Integer);
    function Get_DmpCreateEnabled: Integer;
    procedure Set_VideoAutoSendEnabled(Enabled: Integer);
    function Get_VideoAutoSendEnabled: Integer;
    procedure Set_ProxyForceForAllRequests(Enabled: Integer);
    function Get_ProxyForceForAllRequests: Integer;
    procedure Set_IntenalVolumeImplEnabled(Enabled: WordBool);
    function Get_IntenalVolumeImplEnabled: WordBool;
    procedure Set_AppendExtToRecFileNameEnabled(Enabled: WordBool);
    function Get_AppendExtToRecFileNameEnabled: WordBool;
    procedure Set_SubscriptionExpire(Expire: Integer);
    function Get_SubscriptionExpire: Integer;
    procedure Set_TlsPrivKeyPass(const Pass: WideString);
    function Get_TlsPrivKeyPass: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IConfig);
    procedure Disconnect; override;
    procedure SetCodecOrder(const CodecsListAsStr: WideString; SelectedCount: Integer);
    function Load(const fileName: WideString): Integer;
    procedure Store(const fileName: WideString);
    function ExSipAccount_Count: Integer;
    procedure ExSipAccount_Get(ExAccountIdx: Integer; out Domain: WideString; out User: WideString; 
                               out Pass: WideString; out AuthId: WideString; 
                               out DisplName: WideString; out Expire: Integer; out bEnable: Integer);
    procedure ExSipAccount_Add(const Domain: WideString; const User: WideString; 
                               const Pass: WideString; const AuthId: WideString; 
                               const DisplName: WideString; Expire: Integer; bEnable: Integer; 
                               bDefault: Integer);
    procedure ExSipAccount_ResetAll;
    function ExSipAccount_GetDefaultIdx: Integer;
    procedure ExSipAccount_SetDefaultIdx(ExAccountIdx: Integer);
    function LoadFromStr(const str: WideString): Integer;
    function StoreAsStr: WideString;
    procedure ExSipAccount_Set(ExAccountIdx: Integer; const Domain: WideString; 
                               const User: WideString; const Pass: WideString; 
                               const AuthId: WideString; const DisplName: WideString; 
                               Expire: Integer; bEnable: Integer);
    procedure RemoteVideoWindow_Get(wndIdx: Integer; var hVideoWnd: LONG_PTR);
    procedure RemoteVideoWindow_Set(wndIdx: Integer; hVideoWnd: LONG_PTR);
    procedure RemoteVideoWindow_Add(hVideoWnd: LONG_PTR);
    procedure RemoteVideoWindow_ResetAll;
    procedure RemoteVideoWindow_Count(var pVal: Integer);
    property DefaultInterface: IConfig read GetDefaultInterface;
    property PlaybackDeviceCount: Integer read Get_PlaybackDeviceCount;
    property PlaybackDevice[Index: Integer]: WideString read Get_PlaybackDevice;
    property RecordDeviceCount: Integer read Get_RecordDeviceCount;
    property RecordDevice[Index: Integer]: WideString read Get_RecordDevice;
    property CodecCount: Integer read Get_CodecCount;
    property CodecName[Index: Integer]: WideString read Get_CodecName;
    property CodecSelected[Index: Integer]: Integer read Get_CodecSelected;
    property NetworkInterfaceCount: Integer read Get_NetworkInterfaceCount;
    property NetworkInterface[Index: Integer]: WideString read Get_NetworkInterface;
    property VideoDeviceCount: Integer read Get_VideoDeviceCount;
    property VideoDevice[Index: Integer]: WideString read Get_VideoDevice;
    property ExSipAccountStr[ExAccountIdx: Integer]: WideString read Get_ExSipAccountStr;
    property StunServer: WideString read Get_StunServer write Set_StunServer;
    property ListenPort: Integer read Get_ListenPort write Set_ListenPort;
    property RtpStartPort: Integer read Get_RtpStartPort write Set_RtpStartPort;
    property ActivePlaybackDevice: WideString read Get_ActivePlaybackDevice write Set_ActivePlaybackDevice;
    property ActiveRecordDevice: WideString read Get_ActiveRecordDevice write Set_ActiveRecordDevice;
    property MinJitterDelay: Integer read Get_MinJitterDelay write Set_MinJitterDelay;
    property MaxJitterDelay: Integer read Get_MaxJitterDelay write Set_MaxJitterDelay;
    property SoundBufferDepth: Integer read Get_SoundBufferDepth write Set_SoundBufferDepth;
    property EchoCancelationEnabled: Integer read Get_EchoCancelationEnabled write Set_EchoCancelationEnabled;
    property SilenceDetectionEnabled: Integer read Get_SilenceDetectionEnabled write Set_SilenceDetectionEnabled;
    property AutoGainControlEnabled: Integer read Get_AutoGainControlEnabled write Set_AutoGainControlEnabled;
    property NoiseReductionEnabled: Integer read Get_NoiseReductionEnabled write Set_NoiseReductionEnabled;
    property UserAgent: WideString read Get_UserAgent write Set_UserAgent;
    property CallerId: WideString read Get_CallerId write Set_CallerId;
    property RegDomain: WideString read Get_RegDomain write Set_RegDomain;
    property RegUser: WideString read Get_RegUser write Set_RegUser;
    property RegPass: WideString read Get_RegPass write Set_RegPass;
    property RegAuthId: WideString read Get_RegAuthId write Set_RegAuthId;
    property RegExpire: Integer read Get_RegExpire write Set_RegExpire;
    property ProxyDomain: WideString read Get_ProxyDomain write Set_ProxyDomain;
    property ProxyUser: WideString read Get_ProxyUser write Set_ProxyUser;
    property ProxyPass: WideString read Get_ProxyPass write Set_ProxyPass;
    property LicenseUserId: WideString read Get_LicenseUserId write Set_LicenseUserId;
    property LicenseKey: WideString read Get_LicenseKey write Set_LicenseKey;
    property SamplesPerSecond: Integer read Get_SamplesPerSecond write Set_SamplesPerSecond;
    property ActiveNetworkInterface: WideString read Get_ActiveNetworkInterface write Set_ActiveNetworkInterface;
    property DialToneEnabled: Integer read Get_DialToneEnabled write Set_DialToneEnabled;
    property VolumeUpdateSubscribed: Integer read Get_VolumeUpdateSubscribed write Set_VolumeUpdateSubscribed;
    property LogLevel: LogLevelType read Get_LogLevel write Set_LogLevel;
    property AdditionalDnsServer: WideString read Get_AdditionalDnsServer write Set_AdditionalDnsServer;
    property AdditionalSDPContent: WideString read Get_AdditionalSDPContent write Set_AdditionalSDPContent;
    property AutoAnswerEnabled: Integer read Get_AutoAnswerEnabled write Set_AutoAnswerEnabled;
    property MP3RecordingEnabled: Integer read Get_MP3RecordingEnabled write Set_MP3RecordingEnabled;
    property LocalAudioEnabled: Integer read Get_LocalAudioEnabled write Set_LocalAudioEnabled;
    property LocalVideoWindow: LONG_PTR read Get_LocalVideoWindow write Set_LocalVideoWindow;
    property RemoteVideoWindow: LONG_PTR read Get_RemoteVideoWindow write Set_RemoteVideoWindow;
    property RingToneEnabled: Integer read Get_RingToneEnabled write Set_RingToneEnabled;
    property ActiveVideoDevice: WideString read Get_ActiveVideoDevice write Set_ActiveVideoDevice;
    property VideoCallEnabled: Integer read Get_VideoCallEnabled write Set_VideoCallEnabled;
    property LocalTonesEnabled: Integer read Get_LocalTonesEnabled write Set_LocalTonesEnabled;
    property CallInviteTimeout: Integer read Get_CallInviteTimeout write Set_CallInviteTimeout;
    property EncryptedCallEnabled: Integer read Get_EncryptedCallEnabled write Set_EncryptedCallEnabled;
    property MixerFilePlayerEnabled: Integer read Get_MixerFilePlayerEnabled write Set_MixerFilePlayerEnabled;
    property RegRealm: WideString read Get_RegRealm write Set_RegRealm;
    property KeepAliveTimeSIP: Integer read Get_KeepAliveTimeSIP write Set_KeepAliveTimeSIP;
    property KeepAliveTimeRTP: Integer read Get_KeepAliveTimeRTP write Set_KeepAliveTimeRTP;
    property ICEEnabled: Integer read Get_ICEEnabled write Set_ICEEnabled;
    property DtmfAsSipInfoEnabled: Integer read Get_DtmfAsSipInfoEnabled write Set_DtmfAsSipInfoEnabled;
    property RingToneFile: WideString read Get_RingToneFile write Set_RingToneFile;
    property LogPath: WideString read Get_LogPath write Set_LogPath;
    property VideoFrameWidth: Integer read Get_VideoFrameWidth write Set_VideoFrameWidth;
    property VideoFrameHeight: Integer read Get_VideoFrameHeight write Set_VideoFrameHeight;
    property SDPInRingingMsgEnabled: Integer read Get_SDPInRingingMsgEnabled write Set_SDPInRingingMsgEnabled;
    property SignallingTransport: Integer read Get_SignallingTransport write Set_SignallingTransport;
    property LoopbackNetworkInterfaceEnabled: Integer read Get_LoopbackNetworkInterfaceEnabled write Set_LoopbackNetworkInterfaceEnabled;
    property FixedTransportInterfaceEnabled: Integer read Get_FixedTransportInterfaceEnabled write Set_FixedTransportInterfaceEnabled;
    property ComfortNoiseOnMutedMicEnabled: Integer read Get_ComfortNoiseOnMutedMicEnabled write Set_ComfortNoiseOnMutedMicEnabled;
    property ProvisionalMode: Integer read Get_ProvisionalMode write Set_ProvisionalMode;
    property SendRingingMsgEnabled: Integer read Get_SendRingingMsgEnabled write Set_SendRingingMsgEnabled;
    property TonesTypesToDetect: Integer read Get_TonesTypesToDetect write Set_TonesTypesToDetect;
    property AudioQosDscpVal: Integer read Get_AudioQosDscpVal write Set_AudioQosDscpVal;
    property VideoQosDscpVal: Integer read Get_VideoQosDscpVal write Set_VideoQosDscpVal;
    property AudioSSRCVal: Integer read Get_AudioSSRCVal write Set_AudioSSRCVal;
    property VideoSSRCVal: Integer read Get_VideoSSRCVal write Set_VideoSSRCVal;
    property TonesBaudRate: Double read Get_TonesBaudRate write Set_TonesBaudRate;
    property OverrideRtpDest: WideString read Get_OverrideRtpDest write Set_OverrideRtpDest;
    property AECDelayMs: Integer read Get_AECDelayMs write Set_AECDelayMs;
    property DmpCreateEnabled: Integer read Get_DmpCreateEnabled write Set_DmpCreateEnabled;
    property VideoAutoSendEnabled: Integer read Get_VideoAutoSendEnabled write Set_VideoAutoSendEnabled;
    property ProxyForceForAllRequests: Integer read Get_ProxyForceForAllRequests write Set_ProxyForceForAllRequests;
    property IntenalVolumeImplEnabled: WordBool read Get_IntenalVolumeImplEnabled write Set_IntenalVolumeImplEnabled;
    property AppendExtToRecFileNameEnabled: WordBool read Get_AppendExtToRecFileNameEnabled write Set_AppendExtToRecFileNameEnabled;
    property SubscriptionExpire: Integer read Get_SubscriptionExpire write Set_SubscriptionExpire;
    property TlsPrivKeyPass: WideString read Get_TlsPrivKeyPass write Set_TlsPrivKeyPass;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCConfigProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCConfig
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCConfigProperties = class(TPersistent)
  private
    FServer:    TCConfig;
    function    GetDefaultInterface: IConfig;
    constructor Create(AServer: TCConfig);
  protected
    procedure Set_StunServer(const StunAddress: WideString);
    function Get_StunServer: WideString;
    procedure Set_ListenPort(Port: Integer);
    function Get_ListenPort: Integer;
    procedure Set_RtpStartPort(Port: Integer);
    function Get_RtpStartPort: Integer;
    procedure Set_ActivePlaybackDevice(const DeviceName: WideString);
    function Get_ActivePlaybackDevice: WideString;
    function Get_PlaybackDeviceCount: Integer;
    function Get_PlaybackDevice(Index: Integer): WideString;
    procedure Set_ActiveRecordDevice(const DeviceName: WideString);
    function Get_ActiveRecordDevice: WideString;
    function Get_RecordDeviceCount: Integer;
    function Get_RecordDevice(Index: Integer): WideString;
    procedure Set_MinJitterDelay(Delay: Integer);
    function Get_MinJitterDelay: Integer;
    procedure Set_MaxJitterDelay(Delay: Integer);
    function Get_MaxJitterDelay: Integer;
    procedure Set_SoundBufferDepth(Depth: Integer);
    function Get_SoundBufferDepth: Integer;
    procedure Set_EchoCancelationEnabled(Enabled: Integer);
    function Get_EchoCancelationEnabled: Integer;
    procedure Set_SilenceDetectionEnabled(Enabled: Integer);
    function Get_SilenceDetectionEnabled: Integer;
    procedure Set_AutoGainControlEnabled(Enabled: Integer);
    function Get_AutoGainControlEnabled: Integer;
    procedure Set_NoiseReductionEnabled(Enabled: Integer);
    function Get_NoiseReductionEnabled: Integer;
    procedure Set_UserAgent(const AgentName: WideString);
    function Get_UserAgent: WideString;
    procedure Set_CallerId(const Id: WideString);
    function Get_CallerId: WideString;
    procedure Set_RegDomain(const Domain: WideString);
    function Get_RegDomain: WideString;
    procedure Set_RegUser(const User: WideString);
    function Get_RegUser: WideString;
    procedure Set_RegPass(const Pass: WideString);
    function Get_RegPass: WideString;
    procedure Set_RegAuthId(const AuthId: WideString);
    function Get_RegAuthId: WideString;
    procedure Set_RegExpire(Expire: Integer);
    function Get_RegExpire: Integer;
    procedure Set_ProxyDomain(const Domain: WideString);
    function Get_ProxyDomain: WideString;
    procedure Set_ProxyUser(const User: WideString);
    function Get_ProxyUser: WideString;
    procedure Set_ProxyPass(const Pass: WideString);
    function Get_ProxyPass: WideString;
    procedure Set_LicenseUserId(const UserId: WideString);
    function Get_LicenseUserId: WideString;
    procedure Set_LicenseKey(const Key: WideString);
    function Get_LicenseKey: WideString;
    function Get_CodecCount: Integer;
    function Get_CodecName(Index: Integer): WideString;
    function Get_CodecSelected(Index: Integer): Integer;
    procedure Set_SamplesPerSecond(Samples: Integer);
    function Get_SamplesPerSecond: Integer;
    procedure Set_ActiveNetworkInterface(const DeviceName: WideString);
    function Get_ActiveNetworkInterface: WideString;
    function Get_NetworkInterfaceCount: Integer;
    function Get_NetworkInterface(Index: Integer): WideString;
    procedure Set_DialToneEnabled(Enabled: Integer);
    function Get_DialToneEnabled: Integer;
    procedure Set_VolumeUpdateSubscribed(Enabled: Integer);
    function Get_VolumeUpdateSubscribed: Integer;
    procedure Set_LogLevel(level: LogLevelType);
    function Get_LogLevel: LogLevelType;
    procedure Set_AdditionalDnsServer(const dnsServerIPAddress: WideString);
    function Get_AdditionalDnsServer: WideString;
    procedure Set_AdditionalSDPContent(const sdpContent: WideString);
    function Get_AdditionalSDPContent: WideString;
    procedure Set_AutoAnswerEnabled(Enabled: Integer);
    function Get_AutoAnswerEnabled: Integer;
    procedure Set_MP3RecordingEnabled(Enabled: Integer);
    function Get_MP3RecordingEnabled: Integer;
    procedure Set_LocalAudioEnabled(Enabled: Integer);
    function Get_LocalAudioEnabled: Integer;
    procedure Set_LocalVideoWindow(hVideoWindow: LONG_PTR);
    function Get_LocalVideoWindow: LONG_PTR;
    procedure Set_RemoteVideoWindow(hVideoWindow: LONG_PTR);
    function Get_RemoteVideoWindow: LONG_PTR;
    procedure Set_RingToneEnabled(Enabled: Integer);
    function Get_RingToneEnabled: Integer;
    procedure Set_ActiveVideoDevice(const DeviceName: WideString);
    function Get_ActiveVideoDevice: WideString;
    function Get_VideoDeviceCount: Integer;
    function Get_VideoDevice(Index: Integer): WideString;
    procedure Set_VideoCallEnabled(Enabled: Integer);
    function Get_VideoCallEnabled: Integer;
    procedure Set_LocalTonesEnabled(Enabled: Integer);
    function Get_LocalTonesEnabled: Integer;
    procedure Set_CallInviteTimeout(sec: Integer);
    function Get_CallInviteTimeout: Integer;
    procedure Set_EncryptedCallEnabled(Enabled: Integer);
    function Get_EncryptedCallEnabled: Integer;
    procedure Set_MixerFilePlayerEnabled(Enabled: Integer);
    function Get_MixerFilePlayerEnabled: Integer;
    procedure Set_RegRealm(const Domain: WideString);
    function Get_RegRealm: WideString;
    procedure Set_KeepAliveTimeSIP(seconds: Integer);
    function Get_KeepAliveTimeSIP: Integer;
    procedure Set_KeepAliveTimeRTP(seconds: Integer);
    function Get_KeepAliveTimeRTP: Integer;
    procedure Set_ICEEnabled(Enabled: Integer);
    function Get_ICEEnabled: Integer;
    procedure Set_DtmfAsSipInfoEnabled(Enabled: Integer);
    function Get_DtmfAsSipInfoEnabled: Integer;
    procedure Set_RingToneFile(const wavFile: WideString);
    function Get_RingToneFile: WideString;
    procedure Set_LogPath(const logFilePath: WideString);
    function Get_LogPath: WideString;
    procedure Set_VideoFrameWidth(Width: Integer);
    function Get_VideoFrameWidth: Integer;
    procedure Set_VideoFrameHeight(Height: Integer);
    function Get_VideoFrameHeight: Integer;
    procedure Set_SDPInRingingMsgEnabled(Enabled: Integer);
    function Get_SDPInRingingMsgEnabled: Integer;
    procedure Set_SignallingTransport(transp: Integer);
    function Get_SignallingTransport: Integer;
    procedure Set_LoopbackNetworkInterfaceEnabled(Enabled: Integer);
    function Get_LoopbackNetworkInterfaceEnabled: Integer;
    procedure Set_FixedTransportInterfaceEnabled(Enabled: Integer);
    function Get_FixedTransportInterfaceEnabled: Integer;
    procedure Set_ComfortNoiseOnMutedMicEnabled(Enabled: Integer);
    function Get_ComfortNoiseOnMutedMicEnabled: Integer;
    procedure Set_ProvisionalMode(mode: Integer);
    function Get_ProvisionalMode: Integer;
    procedure Set_SendRingingMsgEnabled(Enabled: Integer);
    function Get_SendRingingMsgEnabled: Integer;
    procedure Set_TonesTypesToDetect(types: Integer);
    function Get_TonesTypesToDetect: Integer;
    function Get_ExSipAccountStr(ExAccountIdx: Integer): WideString;
    procedure Set_AudioQosDscpVal(val: Integer);
    function Get_AudioQosDscpVal: Integer;
    procedure Set_VideoQosDscpVal(val: Integer);
    function Get_VideoQosDscpVal: Integer;
    procedure Set_AudioSSRCVal(val: Integer);
    function Get_AudioSSRCVal: Integer;
    procedure Set_VideoSSRCVal(val: Integer);
    function Get_VideoSSRCVal: Integer;
    procedure Set_TonesBaudRate(rate: Double);
    function Get_TonesBaudRate: Double;
    procedure Set_OverrideRtpDest(const dest: WideString);
    function Get_OverrideRtpDest: WideString;
    procedure Set_AECDelayMs(ms: Integer);
    function Get_AECDelayMs: Integer;
    procedure Set_DmpCreateEnabled(Enabled: Integer);
    function Get_DmpCreateEnabled: Integer;
    procedure Set_VideoAutoSendEnabled(Enabled: Integer);
    function Get_VideoAutoSendEnabled: Integer;
    procedure Set_ProxyForceForAllRequests(Enabled: Integer);
    function Get_ProxyForceForAllRequests: Integer;
    procedure Set_IntenalVolumeImplEnabled(Enabled: WordBool);
    function Get_IntenalVolumeImplEnabled: WordBool;
    procedure Set_AppendExtToRecFileNameEnabled(Enabled: WordBool);
    function Get_AppendExtToRecFileNameEnabled: WordBool;
    procedure Set_SubscriptionExpire(Expire: Integer);
    function Get_SubscriptionExpire: Integer;
    procedure Set_TlsPrivKeyPass(const Pass: WideString);
    function Get_TlsPrivKeyPass: WideString;
  public
    property DefaultInterface: IConfig read GetDefaultInterface;
  published
    property StunServer: WideString read Get_StunServer write Set_StunServer;
    property ListenPort: Integer read Get_ListenPort write Set_ListenPort;
    property RtpStartPort: Integer read Get_RtpStartPort write Set_RtpStartPort;
    property ActivePlaybackDevice: WideString read Get_ActivePlaybackDevice write Set_ActivePlaybackDevice;
    property ActiveRecordDevice: WideString read Get_ActiveRecordDevice write Set_ActiveRecordDevice;
    property MinJitterDelay: Integer read Get_MinJitterDelay write Set_MinJitterDelay;
    property MaxJitterDelay: Integer read Get_MaxJitterDelay write Set_MaxJitterDelay;
    property SoundBufferDepth: Integer read Get_SoundBufferDepth write Set_SoundBufferDepth;
    property EchoCancelationEnabled: Integer read Get_EchoCancelationEnabled write Set_EchoCancelationEnabled;
    property SilenceDetectionEnabled: Integer read Get_SilenceDetectionEnabled write Set_SilenceDetectionEnabled;
    property AutoGainControlEnabled: Integer read Get_AutoGainControlEnabled write Set_AutoGainControlEnabled;
    property NoiseReductionEnabled: Integer read Get_NoiseReductionEnabled write Set_NoiseReductionEnabled;
    property UserAgent: WideString read Get_UserAgent write Set_UserAgent;
    property CallerId: WideString read Get_CallerId write Set_CallerId;
    property RegDomain: WideString read Get_RegDomain write Set_RegDomain;
    property RegUser: WideString read Get_RegUser write Set_RegUser;
    property RegPass: WideString read Get_RegPass write Set_RegPass;
    property RegAuthId: WideString read Get_RegAuthId write Set_RegAuthId;
    property RegExpire: Integer read Get_RegExpire write Set_RegExpire;
    property ProxyDomain: WideString read Get_ProxyDomain write Set_ProxyDomain;
    property ProxyUser: WideString read Get_ProxyUser write Set_ProxyUser;
    property ProxyPass: WideString read Get_ProxyPass write Set_ProxyPass;
    property LicenseUserId: WideString read Get_LicenseUserId write Set_LicenseUserId;
    property LicenseKey: WideString read Get_LicenseKey write Set_LicenseKey;
    property SamplesPerSecond: Integer read Get_SamplesPerSecond write Set_SamplesPerSecond;
    property ActiveNetworkInterface: WideString read Get_ActiveNetworkInterface write Set_ActiveNetworkInterface;
    property DialToneEnabled: Integer read Get_DialToneEnabled write Set_DialToneEnabled;
    property VolumeUpdateSubscribed: Integer read Get_VolumeUpdateSubscribed write Set_VolumeUpdateSubscribed;
    property LogLevel: LogLevelType read Get_LogLevel write Set_LogLevel;
    property AdditionalDnsServer: WideString read Get_AdditionalDnsServer write Set_AdditionalDnsServer;
    property AdditionalSDPContent: WideString read Get_AdditionalSDPContent write Set_AdditionalSDPContent;
    property AutoAnswerEnabled: Integer read Get_AutoAnswerEnabled write Set_AutoAnswerEnabled;
    property MP3RecordingEnabled: Integer read Get_MP3RecordingEnabled write Set_MP3RecordingEnabled;
    property LocalAudioEnabled: Integer read Get_LocalAudioEnabled write Set_LocalAudioEnabled;
    property LocalVideoWindow: LONG_PTR read Get_LocalVideoWindow write Set_LocalVideoWindow;
    property RemoteVideoWindow: LONG_PTR read Get_RemoteVideoWindow write Set_RemoteVideoWindow;
    property RingToneEnabled: Integer read Get_RingToneEnabled write Set_RingToneEnabled;
    property ActiveVideoDevice: WideString read Get_ActiveVideoDevice write Set_ActiveVideoDevice;
    property VideoCallEnabled: Integer read Get_VideoCallEnabled write Set_VideoCallEnabled;
    property LocalTonesEnabled: Integer read Get_LocalTonesEnabled write Set_LocalTonesEnabled;
    property CallInviteTimeout: Integer read Get_CallInviteTimeout write Set_CallInviteTimeout;
    property EncryptedCallEnabled: Integer read Get_EncryptedCallEnabled write Set_EncryptedCallEnabled;
    property MixerFilePlayerEnabled: Integer read Get_MixerFilePlayerEnabled write Set_MixerFilePlayerEnabled;
    property RegRealm: WideString read Get_RegRealm write Set_RegRealm;
    property KeepAliveTimeSIP: Integer read Get_KeepAliveTimeSIP write Set_KeepAliveTimeSIP;
    property KeepAliveTimeRTP: Integer read Get_KeepAliveTimeRTP write Set_KeepAliveTimeRTP;
    property ICEEnabled: Integer read Get_ICEEnabled write Set_ICEEnabled;
    property DtmfAsSipInfoEnabled: Integer read Get_DtmfAsSipInfoEnabled write Set_DtmfAsSipInfoEnabled;
    property RingToneFile: WideString read Get_RingToneFile write Set_RingToneFile;
    property LogPath: WideString read Get_LogPath write Set_LogPath;
    property VideoFrameWidth: Integer read Get_VideoFrameWidth write Set_VideoFrameWidth;
    property VideoFrameHeight: Integer read Get_VideoFrameHeight write Set_VideoFrameHeight;
    property SDPInRingingMsgEnabled: Integer read Get_SDPInRingingMsgEnabled write Set_SDPInRingingMsgEnabled;
    property SignallingTransport: Integer read Get_SignallingTransport write Set_SignallingTransport;
    property LoopbackNetworkInterfaceEnabled: Integer read Get_LoopbackNetworkInterfaceEnabled write Set_LoopbackNetworkInterfaceEnabled;
    property FixedTransportInterfaceEnabled: Integer read Get_FixedTransportInterfaceEnabled write Set_FixedTransportInterfaceEnabled;
    property ComfortNoiseOnMutedMicEnabled: Integer read Get_ComfortNoiseOnMutedMicEnabled write Set_ComfortNoiseOnMutedMicEnabled;
    property ProvisionalMode: Integer read Get_ProvisionalMode write Set_ProvisionalMode;
    property SendRingingMsgEnabled: Integer read Get_SendRingingMsgEnabled write Set_SendRingingMsgEnabled;
    property TonesTypesToDetect: Integer read Get_TonesTypesToDetect write Set_TonesTypesToDetect;
    property AudioQosDscpVal: Integer read Get_AudioQosDscpVal write Set_AudioQosDscpVal;
    property VideoQosDscpVal: Integer read Get_VideoQosDscpVal write Set_VideoQosDscpVal;
    property AudioSSRCVal: Integer read Get_AudioSSRCVal write Set_AudioSSRCVal;
    property VideoSSRCVal: Integer read Get_VideoSSRCVal write Set_VideoSSRCVal;
    property TonesBaudRate: Double read Get_TonesBaudRate write Set_TonesBaudRate;
    property OverrideRtpDest: WideString read Get_OverrideRtpDest write Set_OverrideRtpDest;
    property AECDelayMs: Integer read Get_AECDelayMs write Set_AECDelayMs;
    property DmpCreateEnabled: Integer read Get_DmpCreateEnabled write Set_DmpCreateEnabled;
    property VideoAutoSendEnabled: Integer read Get_VideoAutoSendEnabled write Set_VideoAutoSendEnabled;
    property ProxyForceForAllRequests: Integer read Get_ProxyForceForAllRequests write Set_ProxyForceForAllRequests;
    property IntenalVolumeImplEnabled: WordBool read Get_IntenalVolumeImplEnabled write Set_IntenalVolumeImplEnabled;
    property AppendExtToRecFileNameEnabled: WordBool read Get_AppendExtToRecFileNameEnabled write Set_AppendExtToRecFileNameEnabled;
    property SubscriptionExpire: Integer read Get_SubscriptionExpire write Set_SubscriptionExpire;
    property TlsPrivKeyPass: WideString read Get_TlsPrivKeyPass write Set_TlsPrivKeyPass;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCSubscriptions provides a Create and CreateRemote method to          
// create instances of the default interface ISubscriptions exposed by              
// the CoClass CSubscriptions. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCSubscriptions = class
    class function Create: ISubscriptions;
    class function CreateRemote(const MachineName: string): ISubscriptions;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCSubscriptions
// Help String      : Subscriptions Class
// Default Interface: ISubscriptions
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCSubscriptionsProperties= class;
{$ENDIF}
  TCSubscriptions = class(TOleServer)
  private
    FIntf: ISubscriptions;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCSubscriptionsProperties;
    function GetServerProperties: TCSubscriptionsProperties;
{$ENDIF}
    function GetDefaultInterface: ISubscriptions;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISubscriptions);
    procedure Disconnect; override;
    function SubscribeBLF(const sipUri: WideString): Integer;
    function SubscribePresence(const sipUri: WideString): Integer;
    procedure UnSubscribeBLF(subscriptionId: Integer);
    procedure UnSubscribePresence(subscriptionId: Integer);
    function SubscribeMessageSummary: Integer;
    procedure UnSubscribeMessageSummary(subscriptionId: Integer);
    procedure Notify;
    procedure NotifyBLF;
    procedure NotifyPresence(open: Integer; const status: WideString);
    procedure Accept;
    procedure Reject;
    function SubscribeCustomEvent(const event: WideString; const mimeSubType: WideString; 
                                  const sipUri: WideString): Integer;
    procedure UnSubscribeCustomEvent(subscriptionId: Integer);
    property DefaultInterface: ISubscriptions read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCSubscriptionsProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCSubscriptions
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCSubscriptionsProperties = class(TPersistent)
  private
    FServer:    TCSubscriptions;
    function    GetDefaultInterface: ISubscriptions;
    constructor Create(AServer: TCSubscriptions);
  protected
  public
    property DefaultInterface: ISubscriptions read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCAbtoPhone provides a Create and CreateRemote method to          
// create instances of the default interface IAbtoPhone exposed by              
// the CoClass CAbtoPhone. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCAbtoPhone = class
    class function Create: IAbtoPhone;
    class function CreateRemote(const MachineName: string): IAbtoPhone;
  end;

  TCAbtoPhoneOnInitialized = procedure(ASender: TObject; const Msg: WideString) of object;
  TCAbtoPhoneOnLineSwiched = procedure(ASender: TObject; LineId: Integer) of object;
  TCAbtoPhoneOnEstablishedConnection = procedure(ASender: TObject; const AddrFrom: WideString; 
                                                                   const AddrTo: WideString; 
                                                                   ConnectionId: Integer; 
                                                                   LineId: Integer) of object;
  TCAbtoPhoneOnClearedConnection = procedure(ASender: TObject; ConnectionId: Integer; 
                                                               LineId: Integer) of object;
  TCAbtoPhoneOnIncomingCall = procedure(ASender: TObject; const AddrFrom: WideString; 
                                                          LineId: Integer) of object;
  TCAbtoPhoneOnEstablishedCall = procedure(ASender: TObject; const Msg: WideString; LineId: Integer) of object;
  TCAbtoPhoneOnClearedCall = procedure(ASender: TObject; const Msg: WideString; status: Integer; 
                                                         LineId: Integer) of object;
  TCAbtoPhoneOnVolumeUpdated = procedure(ASender: TObject; IsMicrophone: Integer; level: Integer) of object;
  TCAbtoPhoneOnRegistered = procedure(ASender: TObject; const Msg: WideString) of object;
  TCAbtoPhoneOnUnRegistered = procedure(ASender: TObject; const Msg: WideString) of object;
  TCAbtoPhoneOnPlayFinished = procedure(ASender: TObject; const Msg: WideString) of object;
  TCAbtoPhoneOnToneReceived = procedure(ASender: TObject; Tone: Integer; ConnectionId: Integer; 
                                                          LineId: Integer) of object;
  TCAbtoPhoneOnTextMessageReceived = procedure(ASender: TObject; const address: WideString; 
                                                                 const message: WideString) of object;
  TCAbtoPhoneOnPhoneNotify = procedure(ASender: TObject; const Msg: WideString) of object;
  TCAbtoPhoneOnRemoteAlerting = procedure(ASender: TObject; ConnectionId: Integer; 
                                                            responseCode: Integer; 
                                                            const reasonMsg: WideString) of object;
  TCAbtoPhoneOnHoldCall = procedure(ASender: TObject; LineId: Integer; isHeld: Integer) of object;
  TCAbtoPhoneOnTextMessageSentStatus = procedure(ASender: TObject; const address: WideString; 
                                                                   const reason: WideString; 
                                                                   bSuccess: Integer) of object;
  TCAbtoPhoneOnRecordFinished = procedure(ASender: TObject; const Msg: WideString) of object;
  TCAbtoPhoneOnSubscribeStatus = procedure(ASender: TObject; subscriptionId: Integer; 
                                                             statusCode: Integer; 
                                                             const statusMsg: WideString) of object;
  TCAbtoPhoneOnUnSubscribeStatus = procedure(ASender: TObject; subscriptionId: Integer; 
                                                               statusCode: Integer; 
                                                               const statusMsg: WideString) of object;
  TCAbtoPhoneOnSubscriptionRequest = procedure(ASender: TObject; const fromUri: WideString; 
                                                                 const eventStr: WideString) of object;
  TCAbtoPhoneOnSubscriptionNotify = procedure(ASender: TObject; subscriptionId: Integer; 
                                                                const StateStr: WideString; 
                                                                const NotifyStr: WideString) of object;
  TCAbtoPhoneOnDetectedAnswerTime = procedure(ASender: TObject; TimeSpanMs: Integer; 
                                                                ConnectionId: Integer) of object;
  TCAbtoPhoneOnBaudotToneReceived = procedure(ASender: TObject; Tone: Integer; 
                                                                ConnectionId: Integer; 
                                                                LineId: Integer) of object;
  TCAbtoPhoneOnSubscriptionTerminated = procedure(ASender: TObject; const fromUri: WideString) of object;
  TCAbtoPhoneOnToneDetected = procedure(ASender: TObject; tType: ToneType; 
                                                          const ToneStr: WideString; 
                                                          ConnectionId: Integer; LineId: Integer) of object;
  TCAbtoPhoneOnReceivedSipNotifyMsg = procedure(ASender: TObject; const SipNotifyMsgStr: WideString) of object;
  TCAbtoPhoneOnPlayFinished2 = procedure(ASender: TObject; const Msg: WideString; LineId: Integer) of object;
  TCAbtoPhoneOnRemoteAlerting2 = procedure(ASender: TObject; ConnectionId: Integer; 
                                                             LineId: Integer; 
                                                             responseCode: Integer; 
                                                             const reasonMsg: WideString) of object;
  TCAbtoPhoneOnReceivedRequestInfo = procedure(ASender: TObject; ConnectionId: Integer; 
                                                                 LineId: Integer; 
                                                                 const contentType: WideString; 
                                                                 const body: WideString) of object;
  TCAbtoPhoneOnBaudotFinished = procedure(ASender: TObject; const Msg: WideString; LineId: Integer) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCAbtoPhone
// Help String      : AbtoPhone Class
// Default Interface: IAbtoPhone
// Def. Intf. DISP? : No
// Event   Interface: _IAbtoPhoneEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCAbtoPhoneProperties= class;
{$ENDIF}
  TCAbtoPhone = class(TOleServer)
  private
    FOnInitialized: TCAbtoPhoneOnInitialized;
    FOnLineSwiched: TCAbtoPhoneOnLineSwiched;
    FOnEstablishedConnection: TCAbtoPhoneOnEstablishedConnection;
    FOnClearedConnection: TCAbtoPhoneOnClearedConnection;
    FOnIncomingCall: TCAbtoPhoneOnIncomingCall;
    FOnEstablishedCall: TCAbtoPhoneOnEstablishedCall;
    FOnClearedCall: TCAbtoPhoneOnClearedCall;
    FOnVolumeUpdated: TCAbtoPhoneOnVolumeUpdated;
    FOnRegistered: TCAbtoPhoneOnRegistered;
    FOnUnRegistered: TCAbtoPhoneOnUnRegistered;
    FOnPlayFinished: TCAbtoPhoneOnPlayFinished;
    FOnToneReceived: TCAbtoPhoneOnToneReceived;
    FOnTextMessageReceived: TCAbtoPhoneOnTextMessageReceived;
    FOnPhoneNotify: TCAbtoPhoneOnPhoneNotify;
    FOnRemoteAlerting: TCAbtoPhoneOnRemoteAlerting;
    FOnHoldCall: TCAbtoPhoneOnHoldCall;
    FOnTextMessageSentStatus: TCAbtoPhoneOnTextMessageSentStatus;
    FOnRecordFinished: TCAbtoPhoneOnRecordFinished;
    FOnSubscribeStatus: TCAbtoPhoneOnSubscribeStatus;
    FOnUnSubscribeStatus: TCAbtoPhoneOnUnSubscribeStatus;
    FOnSubscriptionRequest: TCAbtoPhoneOnSubscriptionRequest;
    FOnSubscriptionNotify: TCAbtoPhoneOnSubscriptionNotify;
    FOnDetectedAnswerTime: TCAbtoPhoneOnDetectedAnswerTime;
    FOnBaudotToneReceived: TCAbtoPhoneOnBaudotToneReceived;
    FOnSubscriptionTerminated: TCAbtoPhoneOnSubscriptionTerminated;
    FOnToneDetected: TCAbtoPhoneOnToneDetected;
    FOnReceivedSipNotifyMsg: TCAbtoPhoneOnReceivedSipNotifyMsg;
    FOnPlayFinished2: TCAbtoPhoneOnPlayFinished2;
    FOnRemoteAlerting2: TCAbtoPhoneOnRemoteAlerting2;
    FOnReceivedRequestInfo: TCAbtoPhoneOnReceivedRequestInfo;
    FOnBaudotFinished: TCAbtoPhoneOnBaudotFinished;
    FIntf: IAbtoPhone;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCAbtoPhoneProperties;
    function GetServerProperties: TCAbtoPhoneProperties;
{$ENDIF}
    function GetDefaultInterface: IAbtoPhone;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Config: IConfig;
    procedure Set_PlaybackVolume(level: Integer);
    function Get_PlaybackVolume: Integer;
    procedure Set_PlaybackMuted(Muted: Integer);
    function Get_PlaybackMuted: Integer;
    procedure Set_RecordVolume(level: Integer);
    function Get_RecordVolume: Integer;
    procedure Set_RecordMuted(Muted: Integer);
    function Get_RecordMuted: Integer;
    function Get_Subscriptions: ISubscriptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAbtoPhone);
    procedure Disconnect; override;
    procedure Initialize;
    procedure InitializeEx(sendEventsFromSameThread: Integer);
    procedure SetCurrentLine(LineId: Integer);
    procedure StartCall(const Destination: WideString);
    procedure HangUp(ConnectionId: Integer);
    procedure HangUpLastCall;
    procedure AnswerCall;
    procedure RejectCall;
    procedure TransferCall(const Destination: WideString);
    procedure AttendedTransferCall(LineId: Integer);
    procedure HoldRetrieveCurrentCall;
    procedure JoinToCurrentCall(LineId: Integer);
    function PlayFile(const FilePath: WideString): Integer;
    procedure StopPlayback;
    procedure StartRecording(const FilePath: WideString);
    procedure StopRecording;
    procedure SendTextMessage(const address: WideString; const message: WideString; 
                              bSendUnicode: Integer);
    procedure SendTone(const Tone: WideString);
    procedure AppendWav(const DestinationFilename: WideString; const SourceFilename: WideString);
    function RetrieveExternalAddress: WideString;
    procedure ApplyConfig;
    procedure CancelConfig;
    procedure SetConnectionContribution(ConnectionId: Integer; inputGain: Integer; 
                                        outputGain: Integer);
    procedure SetConnectionContributionRelated(ConnectionIdInput: Integer; 
                                               ConnectionIdOutput: Integer; inputGain: Integer; 
                                               outputGain: Integer);
    procedure SetConnectionContributionRelatedLocal(ConnectionIdInput: Integer; inputGain: Integer; 
                                                    outputGain: Integer);
    function IsLineOccupied(LineId: Integer): Integer;
    procedure TransferConnection(ConnectionId: Integer; const Destination: WideString);
    function SDKPath: WideString;
    procedure PlayBuffer(bufferPtr: Int64; size: Integer; rate: Integer);
    procedure StartRecordingBuffer(bufferPtr: Int64; size: Integer);
    function RetrieveVersion: WideString;
    function GetSIPHeaderValue(const Header: WideString): WideString;
    procedure SetSIPHeaderValue(const Header: WideString; const HeaderVal: WideString);
    procedure StartRecordingConnection(ConnectionId: Integer; const FilePath: WideString);
    procedure StopRecordingConnection(ConnectionId: Integer);
    function GetSIPBodyMultiPartMimeText(PartIdx: Integer): WideString;
    procedure SendToneEx(Tone: Integer; Duration: Integer; bSendAudio_InBand: Integer; 
                         bSend_RFC4733_OutOfBand: Integer; bSend_SIP_INFO: Integer);
    procedure HoldRetrieveCall(LineId: Integer);
    function GetSIPHeaderValueLine(const Header: WideString; LineId: Integer): WideString;
    procedure SendBaudotTone(BaudotTone: Integer);
    function DnsSrvLookup(const sipSrvName: WideString): Integer;
    procedure DnsSrvGetDetails(receivedRecordIndex: Integer; out hostName: WideString; 
                               out srcIP: WideString; out Port: Integer; out priority: Integer; 
                               out weight: Integer);
    function PlayFileLine(const FilePath: WideString; LineId: Integer): Integer;
    procedure SetPlayingFileContribution(gain: Integer);
    procedure StartVoiceEnergyDetectionPeriod(timeOutMs: Integer; minEnergyValue: Integer; 
                                              maxEnergyValue: Integer; ConnectionId: Integer);
    procedure StopPlaybackLine(LineId: Integer);
    procedure SyncDevicesList;
    procedure RestartAudioSubsystem;
    procedure StartSendingNoise(Tone1AmpPermille: Integer; Tone2AmpPermille: Integer; 
                                IntervalMs: Integer; FrequencyHz: Integer);
    function HasSIPBodyVideoMedia(LineId: Integer): Integer;
    procedure MoveConnectionToLine(LineId: Integer; ConnectionId: Integer);
    procedure StartRecordingConnectionBuffer(ConnectionId: Integer; bufferPtr: Int64; size: Integer);
    procedure BindToAudioDevices;
    procedure AttendedTransferCallLine(fromLineId: Integer; toLineId: Integer);
    procedure SendBaudotString(const BaudotString: WideString);
    procedure RestartAudioSubsystemEx(const PrimaryPlaybackDvc: WideString; 
                                      const SecPlaybackDvc: WideString; 
                                      const PrimaryRecordDvc: WideString; 
                                      const SecRecordDvc: WideString);
    function GetSIPHeaderValueLineArr(const Header: WideString; LineId: Integer): OleVariant;
    procedure MuteLocalVideo(bMute: Integer);
    function StartCall2(const Destination: WideString): Integer;
    function StartCallEx(const Destination: WideString; const FromDisplName: WideString): Integer;
    procedure UpdateCall(ConnectionId: Integer; const FromDisplName: WideString;
                         bSendInvite: WordBool);
    procedure SendRequestInfo(ConnectionId: Integer; const contentType: WideString;
                              const Msg: WideString);
    function StartCallExLine(LineId: Integer; const Destination: WideString;
                             const FromDisplName: WideString): Integer;
    procedure MakeDumpFile;
    procedure AnswerCallLine(LineId: Integer);
    procedure RejectCallLine(LineId: Integer);
    function GetSIPMessageLine(LineId: Integer): WideString;
    procedure AssignVideoWindow(ConnectionId: Integer; hVideoWindow: LONG_PTR);
    function StartCall3(const Destination: WideString; const FromUserName: WideString): Integer;
    procedure SendBaudotTone2(BaudotTone: Integer; gain: Integer);
    procedure SendBaudotString2(const BaudotString: WideString; gain: Integer);
    procedure SendRequestMWINotify(const Destination: WideString; const body: WideString);
    function StartCall4(const Destination: WideString; transp: TransportType): Integer;
    property DefaultInterface: IAbtoPhone read GetDefaultInterface;
    property Config: IConfig read Get_Config;
    property Subscriptions: ISubscriptions read Get_Subscriptions;
    property PlaybackVolume: Integer read Get_PlaybackVolume write Set_PlaybackVolume;
    property PlaybackMuted: Integer read Get_PlaybackMuted write Set_PlaybackMuted;
    property RecordVolume: Integer read Get_RecordVolume write Set_RecordVolume;
    property RecordMuted: Integer read Get_RecordMuted write Set_RecordMuted;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCAbtoPhoneProperties read GetServerProperties;
{$ENDIF}
    property OnInitialized: TCAbtoPhoneOnInitialized read FOnInitialized write FOnInitialized;
    property OnLineSwiched: TCAbtoPhoneOnLineSwiched read FOnLineSwiched write FOnLineSwiched;
    property OnEstablishedConnection: TCAbtoPhoneOnEstablishedConnection read FOnEstablishedConnection write FOnEstablishedConnection;
    property OnClearedConnection: TCAbtoPhoneOnClearedConnection read FOnClearedConnection write FOnClearedConnection;
    property OnIncomingCall: TCAbtoPhoneOnIncomingCall read FOnIncomingCall write FOnIncomingCall;
    property OnEstablishedCall: TCAbtoPhoneOnEstablishedCall read FOnEstablishedCall write FOnEstablishedCall;
    property OnClearedCall: TCAbtoPhoneOnClearedCall read FOnClearedCall write FOnClearedCall;
    property OnVolumeUpdated: TCAbtoPhoneOnVolumeUpdated read FOnVolumeUpdated write FOnVolumeUpdated;
    property OnRegistered: TCAbtoPhoneOnRegistered read FOnRegistered write FOnRegistered;
    property OnUnRegistered: TCAbtoPhoneOnUnRegistered read FOnUnRegistered write FOnUnRegistered;
    property OnPlayFinished: TCAbtoPhoneOnPlayFinished read FOnPlayFinished write FOnPlayFinished;
    property OnToneReceived: TCAbtoPhoneOnToneReceived read FOnToneReceived write FOnToneReceived;
    property OnTextMessageReceived: TCAbtoPhoneOnTextMessageReceived read FOnTextMessageReceived write FOnTextMessageReceived;
    property OnPhoneNotify: TCAbtoPhoneOnPhoneNotify read FOnPhoneNotify write FOnPhoneNotify;
    property OnRemoteAlerting: TCAbtoPhoneOnRemoteAlerting read FOnRemoteAlerting write FOnRemoteAlerting;
    property OnHoldCall: TCAbtoPhoneOnHoldCall read FOnHoldCall write FOnHoldCall;
    property OnTextMessageSentStatus: TCAbtoPhoneOnTextMessageSentStatus read FOnTextMessageSentStatus write FOnTextMessageSentStatus;
    property OnRecordFinished: TCAbtoPhoneOnRecordFinished read FOnRecordFinished write FOnRecordFinished;
    property OnSubscribeStatus: TCAbtoPhoneOnSubscribeStatus read FOnSubscribeStatus write FOnSubscribeStatus;
    property OnUnSubscribeStatus: TCAbtoPhoneOnUnSubscribeStatus read FOnUnSubscribeStatus write FOnUnSubscribeStatus;
    property OnSubscriptionRequest: TCAbtoPhoneOnSubscriptionRequest read FOnSubscriptionRequest write FOnSubscriptionRequest;
    property OnSubscriptionNotify: TCAbtoPhoneOnSubscriptionNotify read FOnSubscriptionNotify write FOnSubscriptionNotify;
    property OnDetectedAnswerTime: TCAbtoPhoneOnDetectedAnswerTime read FOnDetectedAnswerTime write FOnDetectedAnswerTime;
    property OnBaudotToneReceived: TCAbtoPhoneOnBaudotToneReceived read FOnBaudotToneReceived write FOnBaudotToneReceived;
    property OnSubscriptionTerminated: TCAbtoPhoneOnSubscriptionTerminated read FOnSubscriptionTerminated write FOnSubscriptionTerminated;
    property OnToneDetected: TCAbtoPhoneOnToneDetected read FOnToneDetected write FOnToneDetected;
    property OnReceivedSipNotifyMsg: TCAbtoPhoneOnReceivedSipNotifyMsg read FOnReceivedSipNotifyMsg write FOnReceivedSipNotifyMsg;
    property OnPlayFinished2: TCAbtoPhoneOnPlayFinished2 read FOnPlayFinished2 write FOnPlayFinished2;
    property OnRemoteAlerting2: TCAbtoPhoneOnRemoteAlerting2 read FOnRemoteAlerting2 write FOnRemoteAlerting2;
    property OnReceivedRequestInfo: TCAbtoPhoneOnReceivedRequestInfo read FOnReceivedRequestInfo write FOnReceivedRequestInfo;
    property OnBaudotFinished: TCAbtoPhoneOnBaudotFinished read FOnBaudotFinished write FOnBaudotFinished;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCAbtoPhone
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCAbtoPhoneProperties = class(TPersistent)
  private
    FServer:    TCAbtoPhone;
    function    GetDefaultInterface: IAbtoPhone;
    constructor Create(AServer: TCAbtoPhone);
  protected
    function Get_Config: IConfig;
    procedure Set_PlaybackVolume(level: Integer);
    function Get_PlaybackVolume: Integer;
    procedure Set_PlaybackMuted(Muted: Integer);
    function Get_PlaybackMuted: Integer;
    procedure Set_RecordVolume(level: Integer);
    function Get_RecordVolume: Integer;
    procedure Set_RecordMuted(Muted: Integer);
    function Get_RecordMuted: Integer;
    function Get_Subscriptions: ISubscriptions;
  public
    property DefaultInterface: IAbtoPhone read GetDefaultInterface;
  published
    property PlaybackVolume: Integer read Get_PlaybackVolume write Set_PlaybackVolume;
    property PlaybackMuted: Integer read Get_PlaybackMuted write Set_PlaybackMuted;
    property RecordVolume: Integer read Get_RecordVolume write Set_RecordVolume;
    property RecordMuted: Integer read Get_RecordMuted write Set_RecordMuted;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoCConfig.Create: IConfig;
begin
  Result := CreateComObject(CLASS_CConfig) as IConfig;
end;

class function CoCConfig.CreateRemote(const MachineName: string): IConfig;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CConfig) as IConfig;
end;

procedure TCConfig.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1C80CD16-C949-44AE-91A5-73854630B78A}';
    IntfIID:   '{61E86A3E-6ED9-4B8E-88E0-DF9BEA33F54D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCConfig.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IConfig;
  end;
end;

procedure TCConfig.ConnectTo(svrIntf: IConfig);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCConfig.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCConfig.GetDefaultInterface: IConfig;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TCConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCConfigProperties.Create(Self);
{$ENDIF}
end;

destructor TCConfig.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCConfig.GetServerProperties: TCConfigProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TCConfig.Set_StunServer(const StunAddress: WideString);
  { Warning: The property StunServer has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.StunServer := StunAddress;
end;

function TCConfig.Get_StunServer: WideString;
begin
    Result := DefaultInterface.StunServer;
end;

procedure TCConfig.Set_ListenPort(Port: Integer);
begin
  DefaultInterface.Set_ListenPort(Port);
end;

function TCConfig.Get_ListenPort: Integer;
begin
    Result := DefaultInterface.ListenPort;
end;

procedure TCConfig.Set_RtpStartPort(Port: Integer);
begin
  DefaultInterface.Set_RtpStartPort(Port);
end;

function TCConfig.Get_RtpStartPort: Integer;
begin
    Result := DefaultInterface.RtpStartPort;
end;

procedure TCConfig.Set_ActivePlaybackDevice(const DeviceName: WideString);
  { Warning: The property ActivePlaybackDevice has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActivePlaybackDevice := DeviceName;
end;

function TCConfig.Get_ActivePlaybackDevice: WideString;
begin
    Result := DefaultInterface.ActivePlaybackDevice;
end;

function TCConfig.Get_PlaybackDeviceCount: Integer;
begin
    Result := DefaultInterface.PlaybackDeviceCount;
end;

function TCConfig.Get_PlaybackDevice(Index: Integer): WideString;
begin
    Result := DefaultInterface.PlaybackDevice[Index];
end;

procedure TCConfig.Set_ActiveRecordDevice(const DeviceName: WideString);
  { Warning: The property ActiveRecordDevice has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActiveRecordDevice := DeviceName;
end;

function TCConfig.Get_ActiveRecordDevice: WideString;
begin
    Result := DefaultInterface.ActiveRecordDevice;
end;

function TCConfig.Get_RecordDeviceCount: Integer;
begin
    Result := DefaultInterface.RecordDeviceCount;
end;

function TCConfig.Get_RecordDevice(Index: Integer): WideString;
begin
    Result := DefaultInterface.RecordDevice[Index];
end;

procedure TCConfig.Set_MinJitterDelay(Delay: Integer);
begin
  DefaultInterface.Set_MinJitterDelay(Delay);
end;

function TCConfig.Get_MinJitterDelay: Integer;
begin
    Result := DefaultInterface.MinJitterDelay;
end;

procedure TCConfig.Set_MaxJitterDelay(Delay: Integer);
begin
  DefaultInterface.Set_MaxJitterDelay(Delay);
end;

function TCConfig.Get_MaxJitterDelay: Integer;
begin
    Result := DefaultInterface.MaxJitterDelay;
end;

procedure TCConfig.Set_SoundBufferDepth(Depth: Integer);
begin
  DefaultInterface.Set_SoundBufferDepth(Depth);
end;

function TCConfig.Get_SoundBufferDepth: Integer;
begin
    Result := DefaultInterface.SoundBufferDepth;
end;

procedure TCConfig.Set_EchoCancelationEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_EchoCancelationEnabled(Enabled);
end;

function TCConfig.Get_EchoCancelationEnabled: Integer;
begin
    Result := DefaultInterface.EchoCancelationEnabled;
end;

procedure TCConfig.Set_SilenceDetectionEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_SilenceDetectionEnabled(Enabled);
end;

function TCConfig.Get_SilenceDetectionEnabled: Integer;
begin
    Result := DefaultInterface.SilenceDetectionEnabled;
end;

procedure TCConfig.Set_AutoGainControlEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_AutoGainControlEnabled(Enabled);
end;

function TCConfig.Get_AutoGainControlEnabled: Integer;
begin
    Result := DefaultInterface.AutoGainControlEnabled;
end;

procedure TCConfig.Set_NoiseReductionEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_NoiseReductionEnabled(Enabled);
end;

function TCConfig.Get_NoiseReductionEnabled: Integer;
begin
    Result := DefaultInterface.NoiseReductionEnabled;
end;

procedure TCConfig.Set_UserAgent(const AgentName: WideString);
  { Warning: The property UserAgent has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.UserAgent := AgentName;
end;

function TCConfig.Get_UserAgent: WideString;
begin
    Result := DefaultInterface.UserAgent;
end;

procedure TCConfig.Set_CallerId(const Id: WideString);
  { Warning: The property CallerId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.CallerId := Id;
end;

function TCConfig.Get_CallerId: WideString;
begin
    Result := DefaultInterface.CallerId;
end;

procedure TCConfig.Set_RegDomain(const Domain: WideString);
  { Warning: The property RegDomain has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegDomain := Domain;
end;

function TCConfig.Get_RegDomain: WideString;
begin
    Result := DefaultInterface.RegDomain;
end;

procedure TCConfig.Set_RegUser(const User: WideString);
  { Warning: The property RegUser has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegUser := User;
end;

function TCConfig.Get_RegUser: WideString;
begin
    Result := DefaultInterface.RegUser;
end;

procedure TCConfig.Set_RegPass(const Pass: WideString);
  { Warning: The property RegPass has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegPass := Pass;
end;

function TCConfig.Get_RegPass: WideString;
begin
    Result := DefaultInterface.RegPass;
end;

procedure TCConfig.Set_RegAuthId(const AuthId: WideString);
  { Warning: The property RegAuthId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegAuthId := AuthId;
end;

function TCConfig.Get_RegAuthId: WideString;
begin
    Result := DefaultInterface.RegAuthId;
end;

procedure TCConfig.Set_RegExpire(Expire: Integer);
begin
  DefaultInterface.Set_RegExpire(Expire);
end;

function TCConfig.Get_RegExpire: Integer;
begin
    Result := DefaultInterface.RegExpire;
end;

procedure TCConfig.Set_ProxyDomain(const Domain: WideString);
  { Warning: The property ProxyDomain has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProxyDomain := Domain;
end;

function TCConfig.Get_ProxyDomain: WideString;
begin
    Result := DefaultInterface.ProxyDomain;
end;

procedure TCConfig.Set_ProxyUser(const User: WideString);
  { Warning: The property ProxyUser has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProxyUser := User;
end;

function TCConfig.Get_ProxyUser: WideString;
begin
    Result := DefaultInterface.ProxyUser;
end;

procedure TCConfig.Set_ProxyPass(const Pass: WideString);
  { Warning: The property ProxyPass has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProxyPass := Pass;
end;

function TCConfig.Get_ProxyPass: WideString;
begin
    Result := DefaultInterface.ProxyPass;
end;

procedure TCConfig.Set_LicenseUserId(const UserId: WideString);
  { Warning: The property LicenseUserId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LicenseUserId := UserId;
end;

function TCConfig.Get_LicenseUserId: WideString;
begin
    Result := DefaultInterface.LicenseUserId;
end;

procedure TCConfig.Set_LicenseKey(const Key: WideString);
  { Warning: The property LicenseKey has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LicenseKey := Key;
end;

function TCConfig.Get_LicenseKey: WideString;
begin
    Result := DefaultInterface.LicenseKey;
end;

function TCConfig.Get_CodecCount: Integer;
begin
    Result := DefaultInterface.CodecCount;
end;

function TCConfig.Get_CodecName(Index: Integer): WideString;
begin
    Result := DefaultInterface.CodecName[Index];
end;

function TCConfig.Get_CodecSelected(Index: Integer): Integer;
begin
    Result := DefaultInterface.CodecSelected[Index];
end;

procedure TCConfig.Set_SamplesPerSecond(Samples: Integer);
begin
  DefaultInterface.Set_SamplesPerSecond(Samples);
end;

function TCConfig.Get_SamplesPerSecond: Integer;
begin
    Result := DefaultInterface.SamplesPerSecond;
end;

procedure TCConfig.Set_ActiveNetworkInterface(const DeviceName: WideString);
  { Warning: The property ActiveNetworkInterface has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActiveNetworkInterface := DeviceName;
end;

function TCConfig.Get_ActiveNetworkInterface: WideString;
begin
    Result := DefaultInterface.ActiveNetworkInterface;
end;

function TCConfig.Get_NetworkInterfaceCount: Integer;
begin
    Result := DefaultInterface.NetworkInterfaceCount;
end;

function TCConfig.Get_NetworkInterface(Index: Integer): WideString;
begin
    Result := DefaultInterface.NetworkInterface[Index];
end;

procedure TCConfig.Set_DialToneEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_DialToneEnabled(Enabled);
end;

function TCConfig.Get_DialToneEnabled: Integer;
begin
    Result := DefaultInterface.DialToneEnabled;
end;

procedure TCConfig.Set_VolumeUpdateSubscribed(Enabled: Integer);
begin
  DefaultInterface.Set_VolumeUpdateSubscribed(Enabled);
end;

function TCConfig.Get_VolumeUpdateSubscribed: Integer;
begin
    Result := DefaultInterface.VolumeUpdateSubscribed;
end;

procedure TCConfig.Set_LogLevel(level: LogLevelType);
begin
  DefaultInterface.Set_LogLevel(level);
end;

function TCConfig.Get_LogLevel: LogLevelType;
begin
    Result := DefaultInterface.LogLevel;
end;

procedure TCConfig.Set_AdditionalDnsServer(const dnsServerIPAddress: WideString);
  { Warning: The property AdditionalDnsServer has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AdditionalDnsServer := dnsServerIPAddress;
end;

function TCConfig.Get_AdditionalDnsServer: WideString;
begin
    Result := DefaultInterface.AdditionalDnsServer;
end;

procedure TCConfig.Set_AdditionalSDPContent(const sdpContent: WideString);
  { Warning: The property AdditionalSDPContent has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AdditionalSDPContent := sdpContent;
end;

function TCConfig.Get_AdditionalSDPContent: WideString;
begin
    Result := DefaultInterface.AdditionalSDPContent;
end;

procedure TCConfig.Set_AutoAnswerEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_AutoAnswerEnabled(Enabled);
end;

function TCConfig.Get_AutoAnswerEnabled: Integer;
begin
    Result := DefaultInterface.AutoAnswerEnabled;
end;

procedure TCConfig.Set_MP3RecordingEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_MP3RecordingEnabled(Enabled);
end;

function TCConfig.Get_MP3RecordingEnabled: Integer;
begin
    Result := DefaultInterface.MP3RecordingEnabled;
end;

procedure TCConfig.Set_LocalAudioEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_LocalAudioEnabled(Enabled);
end;

function TCConfig.Get_LocalAudioEnabled: Integer;
begin
    Result := DefaultInterface.LocalAudioEnabled;
end;

procedure TCConfig.Set_LocalVideoWindow(hVideoWindow: LONG_PTR);
begin
  DefaultInterface.Set_LocalVideoWindow(hVideoWindow);
end;

function TCConfig.Get_LocalVideoWindow: LONG_PTR;
begin
    Result := DefaultInterface.LocalVideoWindow;
end;

procedure TCConfig.Set_RemoteVideoWindow(hVideoWindow: LONG_PTR);
begin
  DefaultInterface.Set_RemoteVideoWindow(hVideoWindow);
end;

function TCConfig.Get_RemoteVideoWindow: LONG_PTR;
begin
    Result := DefaultInterface.RemoteVideoWindow;
end;

procedure TCConfig.Set_RingToneEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_RingToneEnabled(Enabled);
end;

function TCConfig.Get_RingToneEnabled: Integer;
begin
    Result := DefaultInterface.RingToneEnabled;
end;

procedure TCConfig.Set_ActiveVideoDevice(const DeviceName: WideString);
  { Warning: The property ActiveVideoDevice has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActiveVideoDevice := DeviceName;
end;

function TCConfig.Get_ActiveVideoDevice: WideString;
begin
    Result := DefaultInterface.ActiveVideoDevice;
end;

function TCConfig.Get_VideoDeviceCount: Integer;
begin
    Result := DefaultInterface.VideoDeviceCount;
end;

function TCConfig.Get_VideoDevice(Index: Integer): WideString;
begin
    Result := DefaultInterface.VideoDevice[Index];
end;

procedure TCConfig.Set_VideoCallEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_VideoCallEnabled(Enabled);
end;

function TCConfig.Get_VideoCallEnabled: Integer;
begin
    Result := DefaultInterface.VideoCallEnabled;
end;

procedure TCConfig.Set_LocalTonesEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_LocalTonesEnabled(Enabled);
end;

function TCConfig.Get_LocalTonesEnabled: Integer;
begin
    Result := DefaultInterface.LocalTonesEnabled;
end;

procedure TCConfig.Set_CallInviteTimeout(sec: Integer);
begin
  DefaultInterface.Set_CallInviteTimeout(sec);
end;

function TCConfig.Get_CallInviteTimeout: Integer;
begin
    Result := DefaultInterface.CallInviteTimeout;
end;

procedure TCConfig.Set_EncryptedCallEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_EncryptedCallEnabled(Enabled);
end;

function TCConfig.Get_EncryptedCallEnabled: Integer;
begin
    Result := DefaultInterface.EncryptedCallEnabled;
end;

procedure TCConfig.Set_MixerFilePlayerEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_MixerFilePlayerEnabled(Enabled);
end;

function TCConfig.Get_MixerFilePlayerEnabled: Integer;
begin
    Result := DefaultInterface.MixerFilePlayerEnabled;
end;

procedure TCConfig.Set_RegRealm(const Domain: WideString);
  { Warning: The property RegRealm has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegRealm := Domain;
end;

function TCConfig.Get_RegRealm: WideString;
begin
    Result := DefaultInterface.RegRealm;
end;

procedure TCConfig.Set_KeepAliveTimeSIP(seconds: Integer);
begin
  DefaultInterface.Set_KeepAliveTimeSIP(seconds);
end;

function TCConfig.Get_KeepAliveTimeSIP: Integer;
begin
    Result := DefaultInterface.KeepAliveTimeSIP;
end;

procedure TCConfig.Set_KeepAliveTimeRTP(seconds: Integer);
begin
  DefaultInterface.Set_KeepAliveTimeRTP(seconds);
end;

function TCConfig.Get_KeepAliveTimeRTP: Integer;
begin
    Result := DefaultInterface.KeepAliveTimeRTP;
end;

procedure TCConfig.Set_ICEEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_ICEEnabled(Enabled);
end;

function TCConfig.Get_ICEEnabled: Integer;
begin
    Result := DefaultInterface.ICEEnabled;
end;

procedure TCConfig.Set_DtmfAsSipInfoEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_DtmfAsSipInfoEnabled(Enabled);
end;

function TCConfig.Get_DtmfAsSipInfoEnabled: Integer;
begin
    Result := DefaultInterface.DtmfAsSipInfoEnabled;
end;

procedure TCConfig.Set_RingToneFile(const wavFile: WideString);
  { Warning: The property RingToneFile has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RingToneFile := wavFile;
end;

function TCConfig.Get_RingToneFile: WideString;
begin
    Result := DefaultInterface.RingToneFile;
end;

procedure TCConfig.Set_LogPath(const logFilePath: WideString);
  { Warning: The property LogPath has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LogPath := logFilePath;
end;

function TCConfig.Get_LogPath: WideString;
begin
    Result := DefaultInterface.LogPath;
end;

procedure TCConfig.Set_VideoFrameWidth(Width: Integer);
begin
  DefaultInterface.Set_VideoFrameWidth(Width);
end;

function TCConfig.Get_VideoFrameWidth: Integer;
begin
    Result := DefaultInterface.VideoFrameWidth;
end;

procedure TCConfig.Set_VideoFrameHeight(Height: Integer);
begin
  DefaultInterface.Set_VideoFrameHeight(Height);
end;

function TCConfig.Get_VideoFrameHeight: Integer;
begin
    Result := DefaultInterface.VideoFrameHeight;
end;

procedure TCConfig.Set_SDPInRingingMsgEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_SDPInRingingMsgEnabled(Enabled);
end;

function TCConfig.Get_SDPInRingingMsgEnabled: Integer;
begin
    Result := DefaultInterface.SDPInRingingMsgEnabled;
end;

procedure TCConfig.Set_SignallingTransport(transp: Integer);
begin
  DefaultInterface.Set_SignallingTransport(transp);
end;

function TCConfig.Get_SignallingTransport: Integer;
begin
    Result := DefaultInterface.SignallingTransport;
end;

procedure TCConfig.Set_LoopbackNetworkInterfaceEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_LoopbackNetworkInterfaceEnabled(Enabled);
end;

function TCConfig.Get_LoopbackNetworkInterfaceEnabled: Integer;
begin
    Result := DefaultInterface.LoopbackNetworkInterfaceEnabled;
end;

procedure TCConfig.Set_FixedTransportInterfaceEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_FixedTransportInterfaceEnabled(Enabled);
end;

function TCConfig.Get_FixedTransportInterfaceEnabled: Integer;
begin
    Result := DefaultInterface.FixedTransportInterfaceEnabled;
end;

procedure TCConfig.Set_ComfortNoiseOnMutedMicEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_ComfortNoiseOnMutedMicEnabled(Enabled);
end;

function TCConfig.Get_ComfortNoiseOnMutedMicEnabled: Integer;
begin
    Result := DefaultInterface.ComfortNoiseOnMutedMicEnabled;
end;

procedure TCConfig.Set_ProvisionalMode(mode: Integer);
begin
  DefaultInterface.Set_ProvisionalMode(mode);
end;

function TCConfig.Get_ProvisionalMode: Integer;
begin
    Result := DefaultInterface.ProvisionalMode;
end;

procedure TCConfig.Set_SendRingingMsgEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_SendRingingMsgEnabled(Enabled);
end;

function TCConfig.Get_SendRingingMsgEnabled: Integer;
begin
    Result := DefaultInterface.SendRingingMsgEnabled;
end;

procedure TCConfig.Set_TonesTypesToDetect(types: Integer);
begin
  DefaultInterface.Set_TonesTypesToDetect(types);
end;

function TCConfig.Get_TonesTypesToDetect: Integer;
begin
    Result := DefaultInterface.TonesTypesToDetect;
end;

function TCConfig.Get_ExSipAccountStr(ExAccountIdx: Integer): WideString;
begin
    Result := DefaultInterface.ExSipAccountStr[ExAccountIdx];
end;

procedure TCConfig.Set_AudioQosDscpVal(val: Integer);
begin
  DefaultInterface.Set_AudioQosDscpVal(val);
end;

function TCConfig.Get_AudioQosDscpVal: Integer;
begin
    Result := DefaultInterface.AudioQosDscpVal;
end;

procedure TCConfig.Set_VideoQosDscpVal(val: Integer);
begin
  DefaultInterface.Set_VideoQosDscpVal(val);
end;

function TCConfig.Get_VideoQosDscpVal: Integer;
begin
    Result := DefaultInterface.VideoQosDscpVal;
end;

procedure TCConfig.Set_AudioSSRCVal(val: Integer);
begin
  DefaultInterface.Set_AudioSSRCVal(val);
end;

function TCConfig.Get_AudioSSRCVal: Integer;
begin
    Result := DefaultInterface.AudioSSRCVal;
end;

procedure TCConfig.Set_VideoSSRCVal(val: Integer);
begin
  DefaultInterface.Set_VideoSSRCVal(val);
end;

function TCConfig.Get_VideoSSRCVal: Integer;
begin
    Result := DefaultInterface.VideoSSRCVal;
end;

procedure TCConfig.Set_TonesBaudRate(rate: Double);
begin
  DefaultInterface.Set_TonesBaudRate(rate);
end;

function TCConfig.Get_TonesBaudRate: Double;
begin
    Result := DefaultInterface.TonesBaudRate;
end;

procedure TCConfig.Set_OverrideRtpDest(const dest: WideString);
  { Warning: The property OverrideRtpDest has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.OverrideRtpDest := dest;
end;

function TCConfig.Get_OverrideRtpDest: WideString;
begin
    Result := DefaultInterface.OverrideRtpDest;
end;

procedure TCConfig.Set_AECDelayMs(ms: Integer);
begin
  DefaultInterface.Set_AECDelayMs(ms);
end;

function TCConfig.Get_AECDelayMs: Integer;
begin
    Result := DefaultInterface.AECDelayMs;
end;

procedure TCConfig.Set_DmpCreateEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_DmpCreateEnabled(Enabled);
end;

function TCConfig.Get_DmpCreateEnabled: Integer;
begin
    Result := DefaultInterface.DmpCreateEnabled;
end;

procedure TCConfig.Set_VideoAutoSendEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_VideoAutoSendEnabled(Enabled);
end;

function TCConfig.Get_VideoAutoSendEnabled: Integer;
begin
    Result := DefaultInterface.VideoAutoSendEnabled;
end;

procedure TCConfig.Set_ProxyForceForAllRequests(Enabled: Integer);
begin
  DefaultInterface.Set_ProxyForceForAllRequests(Enabled);
end;

function TCConfig.Get_ProxyForceForAllRequests: Integer;
begin
    Result := DefaultInterface.ProxyForceForAllRequests;
end;

procedure TCConfig.Set_IntenalVolumeImplEnabled(Enabled: WordBool);
begin
  DefaultInterface.Set_IntenalVolumeImplEnabled(Enabled);
end;

function TCConfig.Get_IntenalVolumeImplEnabled: WordBool;
begin
    Result := DefaultInterface.IntenalVolumeImplEnabled;
end;

procedure TCConfig.Set_AppendExtToRecFileNameEnabled(Enabled: WordBool);
begin
  DefaultInterface.Set_AppendExtToRecFileNameEnabled(Enabled);
end;

function TCConfig.Get_AppendExtToRecFileNameEnabled: WordBool;
begin
    Result := DefaultInterface.AppendExtToRecFileNameEnabled;
end;

procedure TCConfig.Set_SubscriptionExpire(Expire: Integer);
begin
  DefaultInterface.Set_SubscriptionExpire(Expire);
end;

function TCConfig.Get_SubscriptionExpire: Integer;
begin
    Result := DefaultInterface.SubscriptionExpire;
end;

procedure TCConfig.Set_TlsPrivKeyPass(const Pass: WideString);
  { Warning: The property TlsPrivKeyPass has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.TlsPrivKeyPass := Pass;
end;

function TCConfig.Get_TlsPrivKeyPass: WideString;
begin
    Result := DefaultInterface.TlsPrivKeyPass;
end;

procedure TCConfig.SetCodecOrder(const CodecsListAsStr: WideString; SelectedCount: Integer);
begin
  DefaultInterface.SetCodecOrder(CodecsListAsStr, SelectedCount);
end;

function TCConfig.Load(const fileName: WideString): Integer;
begin
  Result := DefaultInterface.Load(fileName);
end;

procedure TCConfig.Store(const fileName: WideString);
begin
  DefaultInterface.Store(fileName);
end;

function TCConfig.ExSipAccount_Count: Integer;
begin
  Result := DefaultInterface.ExSipAccount_Count;
end;

procedure TCConfig.ExSipAccount_Get(ExAccountIdx: Integer; out Domain: WideString; 
                                    out User: WideString; out Pass: WideString; 
                                    out AuthId: WideString; out DisplName: WideString; 
                                    out Expire: Integer; out bEnable: Integer);
begin
  DefaultInterface.ExSipAccount_Get(ExAccountIdx, Domain, User, Pass, AuthId, DisplName, Expire, 
                                    bEnable);
end;

procedure TCConfig.ExSipAccount_Add(const Domain: WideString; const User: WideString; 
                                    const Pass: WideString; const AuthId: WideString; 
                                    const DisplName: WideString; Expire: Integer; bEnable: Integer; 
                                    bDefault: Integer);
begin
  DefaultInterface.ExSipAccount_Add(Domain, User, Pass, AuthId, DisplName, Expire, bEnable, bDefault);
end;

procedure TCConfig.ExSipAccount_ResetAll;
begin
  DefaultInterface.ExSipAccount_ResetAll;
end;

function TCConfig.ExSipAccount_GetDefaultIdx: Integer;
begin
  Result := DefaultInterface.ExSipAccount_GetDefaultIdx;
end;

procedure TCConfig.ExSipAccount_SetDefaultIdx(ExAccountIdx: Integer);
begin
  DefaultInterface.ExSipAccount_SetDefaultIdx(ExAccountIdx);
end;

function TCConfig.LoadFromStr(const str: WideString): Integer;
begin
  Result := DefaultInterface.LoadFromStr(str);
end;

function TCConfig.StoreAsStr: WideString;
begin
  Result := DefaultInterface.StoreAsStr;
end;

procedure TCConfig.ExSipAccount_Set(ExAccountIdx: Integer; const Domain: WideString; 
                                    const User: WideString; const Pass: WideString; 
                                    const AuthId: WideString; const DisplName: WideString; 
                                    Expire: Integer; bEnable: Integer);
begin
  DefaultInterface.ExSipAccount_Set(ExAccountIdx, Domain, User, Pass, AuthId, DisplName, Expire, 
                                    bEnable);
end;

procedure TCConfig.RemoteVideoWindow_Get(wndIdx: Integer; var hVideoWnd: LONG_PTR);
begin
  DefaultInterface.RemoteVideoWindow_Get(wndIdx, hVideoWnd);
end;

procedure TCConfig.RemoteVideoWindow_Set(wndIdx: Integer; hVideoWnd: LONG_PTR);
begin
  DefaultInterface.RemoteVideoWindow_Set(wndIdx, hVideoWnd);
end;

procedure TCConfig.RemoteVideoWindow_Add(hVideoWnd: LONG_PTR);
begin
  DefaultInterface.RemoteVideoWindow_Add(hVideoWnd);
end;

procedure TCConfig.RemoteVideoWindow_ResetAll;
begin
  DefaultInterface.RemoteVideoWindow_ResetAll;
end;

procedure TCConfig.RemoteVideoWindow_Count(var pVal: Integer);
begin
  DefaultInterface.RemoteVideoWindow_Count(pVal);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCConfigProperties.Create(AServer: TCConfig);
begin
  inherited Create;
  FServer := AServer;
end;

function TCConfigProperties.GetDefaultInterface: IConfig;
begin
  Result := FServer.DefaultInterface;
end;

procedure TCConfigProperties.Set_StunServer(const StunAddress: WideString);
  { Warning: The property StunServer has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.StunServer := StunAddress;
end;

function TCConfigProperties.Get_StunServer: WideString;
begin
    Result := DefaultInterface.StunServer;
end;

procedure TCConfigProperties.Set_ListenPort(Port: Integer);
begin
  DefaultInterface.Set_ListenPort(Port);
end;

function TCConfigProperties.Get_ListenPort: Integer;
begin
    Result := DefaultInterface.ListenPort;
end;

procedure TCConfigProperties.Set_RtpStartPort(Port: Integer);
begin
  DefaultInterface.Set_RtpStartPort(Port);
end;

function TCConfigProperties.Get_RtpStartPort: Integer;
begin
    Result := DefaultInterface.RtpStartPort;
end;

procedure TCConfigProperties.Set_ActivePlaybackDevice(const DeviceName: WideString);
  { Warning: The property ActivePlaybackDevice has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActivePlaybackDevice := DeviceName;
end;

function TCConfigProperties.Get_ActivePlaybackDevice: WideString;
begin
    Result := DefaultInterface.ActivePlaybackDevice;
end;

function TCConfigProperties.Get_PlaybackDeviceCount: Integer;
begin
    Result := DefaultInterface.PlaybackDeviceCount;
end;

function TCConfigProperties.Get_PlaybackDevice(Index: Integer): WideString;
begin
    Result := DefaultInterface.PlaybackDevice[Index];
end;

procedure TCConfigProperties.Set_ActiveRecordDevice(const DeviceName: WideString);
  { Warning: The property ActiveRecordDevice has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActiveRecordDevice := DeviceName;
end;

function TCConfigProperties.Get_ActiveRecordDevice: WideString;
begin
    Result := DefaultInterface.ActiveRecordDevice;
end;

function TCConfigProperties.Get_RecordDeviceCount: Integer;
begin
    Result := DefaultInterface.RecordDeviceCount;
end;

function TCConfigProperties.Get_RecordDevice(Index: Integer): WideString;
begin
    Result := DefaultInterface.RecordDevice[Index];
end;

procedure TCConfigProperties.Set_MinJitterDelay(Delay: Integer);
begin
  DefaultInterface.Set_MinJitterDelay(Delay);
end;

function TCConfigProperties.Get_MinJitterDelay: Integer;
begin
    Result := DefaultInterface.MinJitterDelay;
end;

procedure TCConfigProperties.Set_MaxJitterDelay(Delay: Integer);
begin
  DefaultInterface.Set_MaxJitterDelay(Delay);
end;

function TCConfigProperties.Get_MaxJitterDelay: Integer;
begin
    Result := DefaultInterface.MaxJitterDelay;
end;

procedure TCConfigProperties.Set_SoundBufferDepth(Depth: Integer);
begin
  DefaultInterface.Set_SoundBufferDepth(Depth);
end;

function TCConfigProperties.Get_SoundBufferDepth: Integer;
begin
    Result := DefaultInterface.SoundBufferDepth;
end;

procedure TCConfigProperties.Set_EchoCancelationEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_EchoCancelationEnabled(Enabled);
end;

function TCConfigProperties.Get_EchoCancelationEnabled: Integer;
begin
    Result := DefaultInterface.EchoCancelationEnabled;
end;

procedure TCConfigProperties.Set_SilenceDetectionEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_SilenceDetectionEnabled(Enabled);
end;

function TCConfigProperties.Get_SilenceDetectionEnabled: Integer;
begin
    Result := DefaultInterface.SilenceDetectionEnabled;
end;

procedure TCConfigProperties.Set_AutoGainControlEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_AutoGainControlEnabled(Enabled);
end;

function TCConfigProperties.Get_AutoGainControlEnabled: Integer;
begin
    Result := DefaultInterface.AutoGainControlEnabled;
end;

procedure TCConfigProperties.Set_NoiseReductionEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_NoiseReductionEnabled(Enabled);
end;

function TCConfigProperties.Get_NoiseReductionEnabled: Integer;
begin
    Result := DefaultInterface.NoiseReductionEnabled;
end;

procedure TCConfigProperties.Set_UserAgent(const AgentName: WideString);
  { Warning: The property UserAgent has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.UserAgent := AgentName;
end;

function TCConfigProperties.Get_UserAgent: WideString;
begin
    Result := DefaultInterface.UserAgent;
end;

procedure TCConfigProperties.Set_CallerId(const Id: WideString);
  { Warning: The property CallerId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.CallerId := Id;
end;

function TCConfigProperties.Get_CallerId: WideString;
begin
    Result := DefaultInterface.CallerId;
end;

procedure TCConfigProperties.Set_RegDomain(const Domain: WideString);
  { Warning: The property RegDomain has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegDomain := Domain;
end;

function TCConfigProperties.Get_RegDomain: WideString;
begin
    Result := DefaultInterface.RegDomain;
end;

procedure TCConfigProperties.Set_RegUser(const User: WideString);
  { Warning: The property RegUser has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegUser := User;
end;

function TCConfigProperties.Get_RegUser: WideString;
begin
    Result := DefaultInterface.RegUser;
end;

procedure TCConfigProperties.Set_RegPass(const Pass: WideString);
  { Warning: The property RegPass has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegPass := Pass;
end;

function TCConfigProperties.Get_RegPass: WideString;
begin
    Result := DefaultInterface.RegPass;
end;

procedure TCConfigProperties.Set_RegAuthId(const AuthId: WideString);
  { Warning: The property RegAuthId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegAuthId := AuthId;
end;

function TCConfigProperties.Get_RegAuthId: WideString;
begin
    Result := DefaultInterface.RegAuthId;
end;

procedure TCConfigProperties.Set_RegExpire(Expire: Integer);
begin
  DefaultInterface.Set_RegExpire(Expire);
end;

function TCConfigProperties.Get_RegExpire: Integer;
begin
    Result := DefaultInterface.RegExpire;
end;

procedure TCConfigProperties.Set_ProxyDomain(const Domain: WideString);
  { Warning: The property ProxyDomain has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProxyDomain := Domain;
end;

function TCConfigProperties.Get_ProxyDomain: WideString;
begin
    Result := DefaultInterface.ProxyDomain;
end;

procedure TCConfigProperties.Set_ProxyUser(const User: WideString);
  { Warning: The property ProxyUser has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProxyUser := User;
end;

function TCConfigProperties.Get_ProxyUser: WideString;
begin
    Result := DefaultInterface.ProxyUser;
end;

procedure TCConfigProperties.Set_ProxyPass(const Pass: WideString);
  { Warning: The property ProxyPass has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProxyPass := Pass;
end;

function TCConfigProperties.Get_ProxyPass: WideString;
begin
    Result := DefaultInterface.ProxyPass;
end;

procedure TCConfigProperties.Set_LicenseUserId(const UserId: WideString);
  { Warning: The property LicenseUserId has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LicenseUserId := UserId;
end;

function TCConfigProperties.Get_LicenseUserId: WideString;
begin
    Result := DefaultInterface.LicenseUserId;
end;

procedure TCConfigProperties.Set_LicenseKey(const Key: WideString);
  { Warning: The property LicenseKey has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LicenseKey := Key;
end;

function TCConfigProperties.Get_LicenseKey: WideString;
begin
    Result := DefaultInterface.LicenseKey;
end;

function TCConfigProperties.Get_CodecCount: Integer;
begin
    Result := DefaultInterface.CodecCount;
end;

function TCConfigProperties.Get_CodecName(Index: Integer): WideString;
begin
    Result := DefaultInterface.CodecName[Index];
end;

function TCConfigProperties.Get_CodecSelected(Index: Integer): Integer;
begin
    Result := DefaultInterface.CodecSelected[Index];
end;

procedure TCConfigProperties.Set_SamplesPerSecond(Samples: Integer);
begin
  DefaultInterface.Set_SamplesPerSecond(Samples);
end;

function TCConfigProperties.Get_SamplesPerSecond: Integer;
begin
    Result := DefaultInterface.SamplesPerSecond;
end;

procedure TCConfigProperties.Set_ActiveNetworkInterface(const DeviceName: WideString);
  { Warning: The property ActiveNetworkInterface has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActiveNetworkInterface := DeviceName;
end;

function TCConfigProperties.Get_ActiveNetworkInterface: WideString;
begin
    Result := DefaultInterface.ActiveNetworkInterface;
end;

function TCConfigProperties.Get_NetworkInterfaceCount: Integer;
begin
    Result := DefaultInterface.NetworkInterfaceCount;
end;

function TCConfigProperties.Get_NetworkInterface(Index: Integer): WideString;
begin
    Result := DefaultInterface.NetworkInterface[Index];
end;

procedure TCConfigProperties.Set_DialToneEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_DialToneEnabled(Enabled);
end;

function TCConfigProperties.Get_DialToneEnabled: Integer;
begin
    Result := DefaultInterface.DialToneEnabled;
end;

procedure TCConfigProperties.Set_VolumeUpdateSubscribed(Enabled: Integer);
begin
  DefaultInterface.Set_VolumeUpdateSubscribed(Enabled);
end;

function TCConfigProperties.Get_VolumeUpdateSubscribed: Integer;
begin
    Result := DefaultInterface.VolumeUpdateSubscribed;
end;

procedure TCConfigProperties.Set_LogLevel(level: LogLevelType);
begin
  DefaultInterface.Set_LogLevel(level);
end;

function TCConfigProperties.Get_LogLevel: LogLevelType;
begin
    Result := DefaultInterface.LogLevel;
end;

procedure TCConfigProperties.Set_AdditionalDnsServer(const dnsServerIPAddress: WideString);
  { Warning: The property AdditionalDnsServer has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AdditionalDnsServer := dnsServerIPAddress;
end;

function TCConfigProperties.Get_AdditionalDnsServer: WideString;
begin
    Result := DefaultInterface.AdditionalDnsServer;
end;

procedure TCConfigProperties.Set_AdditionalSDPContent(const sdpContent: WideString);
  { Warning: The property AdditionalSDPContent has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AdditionalSDPContent := sdpContent;
end;

function TCConfigProperties.Get_AdditionalSDPContent: WideString;
begin
    Result := DefaultInterface.AdditionalSDPContent;
end;

procedure TCConfigProperties.Set_AutoAnswerEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_AutoAnswerEnabled(Enabled);
end;

function TCConfigProperties.Get_AutoAnswerEnabled: Integer;
begin
    Result := DefaultInterface.AutoAnswerEnabled;
end;

procedure TCConfigProperties.Set_MP3RecordingEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_MP3RecordingEnabled(Enabled);
end;

function TCConfigProperties.Get_MP3RecordingEnabled: Integer;
begin
    Result := DefaultInterface.MP3RecordingEnabled;
end;

procedure TCConfigProperties.Set_LocalAudioEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_LocalAudioEnabled(Enabled);
end;

function TCConfigProperties.Get_LocalAudioEnabled: Integer;
begin
    Result := DefaultInterface.LocalAudioEnabled;
end;

procedure TCConfigProperties.Set_LocalVideoWindow(hVideoWindow: LONG_PTR);
begin
  DefaultInterface.Set_LocalVideoWindow(hVideoWindow);
end;

function TCConfigProperties.Get_LocalVideoWindow: LONG_PTR;
begin
    Result := DefaultInterface.LocalVideoWindow;
end;

procedure TCConfigProperties.Set_RemoteVideoWindow(hVideoWindow: LONG_PTR);
begin
  DefaultInterface.Set_RemoteVideoWindow(hVideoWindow);
end;

function TCConfigProperties.Get_RemoteVideoWindow: LONG_PTR;
begin
    Result := DefaultInterface.RemoteVideoWindow;
end;

procedure TCConfigProperties.Set_RingToneEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_RingToneEnabled(Enabled);
end;

function TCConfigProperties.Get_RingToneEnabled: Integer;
begin
    Result := DefaultInterface.RingToneEnabled;
end;

procedure TCConfigProperties.Set_ActiveVideoDevice(const DeviceName: WideString);
  { Warning: The property ActiveVideoDevice has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ActiveVideoDevice := DeviceName;
end;

function TCConfigProperties.Get_ActiveVideoDevice: WideString;
begin
    Result := DefaultInterface.ActiveVideoDevice;
end;

function TCConfigProperties.Get_VideoDeviceCount: Integer;
begin
    Result := DefaultInterface.VideoDeviceCount;
end;

function TCConfigProperties.Get_VideoDevice(Index: Integer): WideString;
begin
    Result := DefaultInterface.VideoDevice[Index];
end;

procedure TCConfigProperties.Set_VideoCallEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_VideoCallEnabled(Enabled);
end;

function TCConfigProperties.Get_VideoCallEnabled: Integer;
begin
    Result := DefaultInterface.VideoCallEnabled;
end;

procedure TCConfigProperties.Set_LocalTonesEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_LocalTonesEnabled(Enabled);
end;

function TCConfigProperties.Get_LocalTonesEnabled: Integer;
begin
    Result := DefaultInterface.LocalTonesEnabled;
end;

procedure TCConfigProperties.Set_CallInviteTimeout(sec: Integer);
begin
  DefaultInterface.Set_CallInviteTimeout(sec);
end;

function TCConfigProperties.Get_CallInviteTimeout: Integer;
begin
    Result := DefaultInterface.CallInviteTimeout;
end;

procedure TCConfigProperties.Set_EncryptedCallEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_EncryptedCallEnabled(Enabled);
end;

function TCConfigProperties.Get_EncryptedCallEnabled: Integer;
begin
    Result := DefaultInterface.EncryptedCallEnabled;
end;

procedure TCConfigProperties.Set_MixerFilePlayerEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_MixerFilePlayerEnabled(Enabled);
end;

function TCConfigProperties.Get_MixerFilePlayerEnabled: Integer;
begin
    Result := DefaultInterface.MixerFilePlayerEnabled;
end;

procedure TCConfigProperties.Set_RegRealm(const Domain: WideString);
  { Warning: The property RegRealm has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RegRealm := Domain;
end;

function TCConfigProperties.Get_RegRealm: WideString;
begin
    Result := DefaultInterface.RegRealm;
end;

procedure TCConfigProperties.Set_KeepAliveTimeSIP(seconds: Integer);
begin
  DefaultInterface.Set_KeepAliveTimeSIP(seconds);
end;

function TCConfigProperties.Get_KeepAliveTimeSIP: Integer;
begin
    Result := DefaultInterface.KeepAliveTimeSIP;
end;

procedure TCConfigProperties.Set_KeepAliveTimeRTP(seconds: Integer);
begin
  DefaultInterface.Set_KeepAliveTimeRTP(seconds);
end;

function TCConfigProperties.Get_KeepAliveTimeRTP: Integer;
begin
    Result := DefaultInterface.KeepAliveTimeRTP;
end;

procedure TCConfigProperties.Set_ICEEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_ICEEnabled(Enabled);
end;

function TCConfigProperties.Get_ICEEnabled: Integer;
begin
    Result := DefaultInterface.ICEEnabled;
end;

procedure TCConfigProperties.Set_DtmfAsSipInfoEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_DtmfAsSipInfoEnabled(Enabled);
end;

function TCConfigProperties.Get_DtmfAsSipInfoEnabled: Integer;
begin
    Result := DefaultInterface.DtmfAsSipInfoEnabled;
end;

procedure TCConfigProperties.Set_RingToneFile(const wavFile: WideString);
  { Warning: The property RingToneFile has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RingToneFile := wavFile;
end;

function TCConfigProperties.Get_RingToneFile: WideString;
begin
    Result := DefaultInterface.RingToneFile;
end;

procedure TCConfigProperties.Set_LogPath(const logFilePath: WideString);
  { Warning: The property LogPath has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LogPath := logFilePath;
end;

function TCConfigProperties.Get_LogPath: WideString;
begin
    Result := DefaultInterface.LogPath;
end;

procedure TCConfigProperties.Set_VideoFrameWidth(Width: Integer);
begin
  DefaultInterface.Set_VideoFrameWidth(Width);
end;

function TCConfigProperties.Get_VideoFrameWidth: Integer;
begin
    Result := DefaultInterface.VideoFrameWidth;
end;

procedure TCConfigProperties.Set_VideoFrameHeight(Height: Integer);
begin
  DefaultInterface.Set_VideoFrameHeight(Height);
end;

function TCConfigProperties.Get_VideoFrameHeight: Integer;
begin
    Result := DefaultInterface.VideoFrameHeight;
end;

procedure TCConfigProperties.Set_SDPInRingingMsgEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_SDPInRingingMsgEnabled(Enabled);
end;

function TCConfigProperties.Get_SDPInRingingMsgEnabled: Integer;
begin
    Result := DefaultInterface.SDPInRingingMsgEnabled;
end;

procedure TCConfigProperties.Set_SignallingTransport(transp: Integer);
begin
  DefaultInterface.Set_SignallingTransport(transp);
end;

function TCConfigProperties.Get_SignallingTransport: Integer;
begin
    Result := DefaultInterface.SignallingTransport;
end;

procedure TCConfigProperties.Set_LoopbackNetworkInterfaceEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_LoopbackNetworkInterfaceEnabled(Enabled);
end;

function TCConfigProperties.Get_LoopbackNetworkInterfaceEnabled: Integer;
begin
    Result := DefaultInterface.LoopbackNetworkInterfaceEnabled;
end;

procedure TCConfigProperties.Set_FixedTransportInterfaceEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_FixedTransportInterfaceEnabled(Enabled);
end;

function TCConfigProperties.Get_FixedTransportInterfaceEnabled: Integer;
begin
    Result := DefaultInterface.FixedTransportInterfaceEnabled;
end;

procedure TCConfigProperties.Set_ComfortNoiseOnMutedMicEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_ComfortNoiseOnMutedMicEnabled(Enabled);
end;

function TCConfigProperties.Get_ComfortNoiseOnMutedMicEnabled: Integer;
begin
    Result := DefaultInterface.ComfortNoiseOnMutedMicEnabled;
end;

procedure TCConfigProperties.Set_ProvisionalMode(mode: Integer);
begin
  DefaultInterface.Set_ProvisionalMode(mode);
end;

function TCConfigProperties.Get_ProvisionalMode: Integer;
begin
    Result := DefaultInterface.ProvisionalMode;
end;

procedure TCConfigProperties.Set_SendRingingMsgEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_SendRingingMsgEnabled(Enabled);
end;

function TCConfigProperties.Get_SendRingingMsgEnabled: Integer;
begin
    Result := DefaultInterface.SendRingingMsgEnabled;
end;

procedure TCConfigProperties.Set_TonesTypesToDetect(types: Integer);
begin
  DefaultInterface.Set_TonesTypesToDetect(types);
end;

function TCConfigProperties.Get_TonesTypesToDetect: Integer;
begin
    Result := DefaultInterface.TonesTypesToDetect;
end;

function TCConfigProperties.Get_ExSipAccountStr(ExAccountIdx: Integer): WideString;
begin
    Result := DefaultInterface.ExSipAccountStr[ExAccountIdx];
end;

procedure TCConfigProperties.Set_AudioQosDscpVal(val: Integer);
begin
  DefaultInterface.Set_AudioQosDscpVal(val);
end;

function TCConfigProperties.Get_AudioQosDscpVal: Integer;
begin
    Result := DefaultInterface.AudioQosDscpVal;
end;

procedure TCConfigProperties.Set_VideoQosDscpVal(val: Integer);
begin
  DefaultInterface.Set_VideoQosDscpVal(val);
end;

function TCConfigProperties.Get_VideoQosDscpVal: Integer;
begin
    Result := DefaultInterface.VideoQosDscpVal;
end;

procedure TCConfigProperties.Set_AudioSSRCVal(val: Integer);
begin
  DefaultInterface.Set_AudioSSRCVal(val);
end;

function TCConfigProperties.Get_AudioSSRCVal: Integer;
begin
    Result := DefaultInterface.AudioSSRCVal;
end;

procedure TCConfigProperties.Set_VideoSSRCVal(val: Integer);
begin
  DefaultInterface.Set_VideoSSRCVal(val);
end;

function TCConfigProperties.Get_VideoSSRCVal: Integer;
begin
    Result := DefaultInterface.VideoSSRCVal;
end;

procedure TCConfigProperties.Set_TonesBaudRate(rate: Double);
begin
  DefaultInterface.Set_TonesBaudRate(rate);
end;

function TCConfigProperties.Get_TonesBaudRate: Double;
begin
    Result := DefaultInterface.TonesBaudRate;
end;

procedure TCConfigProperties.Set_OverrideRtpDest(const dest: WideString);
  { Warning: The property OverrideRtpDest has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.OverrideRtpDest := dest;
end;

function TCConfigProperties.Get_OverrideRtpDest: WideString;
begin
    Result := DefaultInterface.OverrideRtpDest;
end;

procedure TCConfigProperties.Set_AECDelayMs(ms: Integer);
begin
  DefaultInterface.Set_AECDelayMs(ms);
end;

function TCConfigProperties.Get_AECDelayMs: Integer;
begin
    Result := DefaultInterface.AECDelayMs;
end;

procedure TCConfigProperties.Set_DmpCreateEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_DmpCreateEnabled(Enabled);
end;

function TCConfigProperties.Get_DmpCreateEnabled: Integer;
begin
    Result := DefaultInterface.DmpCreateEnabled;
end;

procedure TCConfigProperties.Set_VideoAutoSendEnabled(Enabled: Integer);
begin
  DefaultInterface.Set_VideoAutoSendEnabled(Enabled);
end;

function TCConfigProperties.Get_VideoAutoSendEnabled: Integer;
begin
    Result := DefaultInterface.VideoAutoSendEnabled;
end;

procedure TCConfigProperties.Set_ProxyForceForAllRequests(Enabled: Integer);
begin
  DefaultInterface.Set_ProxyForceForAllRequests(Enabled);
end;

function TCConfigProperties.Get_ProxyForceForAllRequests: Integer;
begin
    Result := DefaultInterface.ProxyForceForAllRequests;
end;

procedure TCConfigProperties.Set_IntenalVolumeImplEnabled(Enabled: WordBool);
begin
  DefaultInterface.Set_IntenalVolumeImplEnabled(Enabled);
end;

function TCConfigProperties.Get_IntenalVolumeImplEnabled: WordBool;
begin
    Result := DefaultInterface.IntenalVolumeImplEnabled;
end;

procedure TCConfigProperties.Set_AppendExtToRecFileNameEnabled(Enabled: WordBool);
begin
  DefaultInterface.Set_AppendExtToRecFileNameEnabled(Enabled);
end;

function TCConfigProperties.Get_AppendExtToRecFileNameEnabled: WordBool;
begin
    Result := DefaultInterface.AppendExtToRecFileNameEnabled;
end;

procedure TCConfigProperties.Set_SubscriptionExpire(Expire: Integer);
begin
  DefaultInterface.Set_SubscriptionExpire(Expire);
end;

function TCConfigProperties.Get_SubscriptionExpire: Integer;
begin
    Result := DefaultInterface.SubscriptionExpire;
end;

procedure TCConfigProperties.Set_TlsPrivKeyPass(const Pass: WideString);
  { Warning: The property TlsPrivKeyPass has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.TlsPrivKeyPass := Pass;
end;

function TCConfigProperties.Get_TlsPrivKeyPass: WideString;
begin
    Result := DefaultInterface.TlsPrivKeyPass;
end;

{$ENDIF}

class function CoCSubscriptions.Create: ISubscriptions;
begin
  Result := CreateComObject(CLASS_CSubscriptions) as ISubscriptions;
end;

class function CoCSubscriptions.CreateRemote(const MachineName: string): ISubscriptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CSubscriptions) as ISubscriptions;
end;

procedure TCSubscriptions.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{B2B9E376-45C6-4623-8CF9-B0FDEDCFC21B}';
    IntfIID:   '{D7CB76AD-3559-4FF4-8313-41CCA1A6ED19}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCSubscriptions.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ISubscriptions;
  end;
end;

procedure TCSubscriptions.ConnectTo(svrIntf: ISubscriptions);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCSubscriptions.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCSubscriptions.GetDefaultInterface: ISubscriptions;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TCSubscriptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCSubscriptionsProperties.Create(Self);
{$ENDIF}
end;

destructor TCSubscriptions.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCSubscriptions.GetServerProperties: TCSubscriptionsProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TCSubscriptions.SubscribeBLF(const sipUri: WideString): Integer;
begin
  Result := DefaultInterface.SubscribeBLF(sipUri);
end;

function TCSubscriptions.SubscribePresence(const sipUri: WideString): Integer;
begin
  Result := DefaultInterface.SubscribePresence(sipUri);
end;

procedure TCSubscriptions.UnSubscribeBLF(subscriptionId: Integer);
begin
  DefaultInterface.UnSubscribeBLF(subscriptionId);
end;

procedure TCSubscriptions.UnSubscribePresence(subscriptionId: Integer);
begin
  DefaultInterface.UnSubscribePresence(subscriptionId);
end;

function TCSubscriptions.SubscribeMessageSummary: Integer;
begin
  Result := DefaultInterface.SubscribeMessageSummary;
end;

procedure TCSubscriptions.UnSubscribeMessageSummary(subscriptionId: Integer);
begin
  DefaultInterface.UnSubscribeMessageSummary(subscriptionId);
end;

procedure TCSubscriptions.Notify;
begin
  DefaultInterface.Notify;
end;

procedure TCSubscriptions.NotifyBLF;
begin
  DefaultInterface.NotifyBLF;
end;

procedure TCSubscriptions.NotifyPresence(open: Integer; const status: WideString);
begin
  DefaultInterface.NotifyPresence(open, status);
end;

procedure TCSubscriptions.Accept;
begin
  DefaultInterface.Accept;
end;

procedure TCSubscriptions.Reject;
begin
  DefaultInterface.Reject;
end;

function TCSubscriptions.SubscribeCustomEvent(const event: WideString; 
                                              const mimeSubType: WideString; 
                                              const sipUri: WideString): Integer;
begin
  Result := DefaultInterface.SubscribeCustomEvent(event, mimeSubType, sipUri);
end;

procedure TCSubscriptions.UnSubscribeCustomEvent(subscriptionId: Integer);
begin
  DefaultInterface.UnSubscribeCustomEvent(subscriptionId);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCSubscriptionsProperties.Create(AServer: TCSubscriptions);
begin
  inherited Create;
  FServer := AServer;
end;

function TCSubscriptionsProperties.GetDefaultInterface: ISubscriptions;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoCAbtoPhone.Create: IAbtoPhone;
begin
  Result := CreateComObject(CLASS_CAbtoPhone) as IAbtoPhone;
end;

class function CoCAbtoPhone.CreateRemote(const MachineName: string): IAbtoPhone;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CAbtoPhone) as IAbtoPhone;
end;

procedure TCAbtoPhone.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{9BCEE7C8-3FE1-49FA-94D5-FC92DB4301F1}';
    IntfIID:   '{F9EE5EB0-F289-45FA-836E-6F381A306FC5}';
    EventIID:  '{4EBC3861-0D3F-48A3-8322-E45E74DBDEF5}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCAbtoPhone.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IAbtoPhone;
  end;
end;

procedure TCAbtoPhone.ConnectTo(svrIntf: IAbtoPhone);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TCAbtoPhone.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TCAbtoPhone.GetDefaultInterface: IAbtoPhone;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TCAbtoPhone.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCAbtoPhoneProperties.Create(Self);
{$ENDIF}
end;

destructor TCAbtoPhone.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCAbtoPhone.GetServerProperties: TCAbtoPhoneProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TCAbtoPhone.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnInitialized) then
         FOnInitialized(Self, Params[0] {const WideString});
    2: if Assigned(FOnLineSwiched) then
         FOnLineSwiched(Self, Params[0] {Integer});
    3: if Assigned(FOnEstablishedConnection) then
         FOnEstablishedConnection(Self,
                                  Params[0] {const WideString},
                                  Params[1] {const WideString},
                                  Params[2] {Integer},
                                  Params[3] {Integer});
    4: if Assigned(FOnClearedConnection) then
         FOnClearedConnection(Self,
                              Params[0] {Integer},
                              Params[1] {Integer});
    5: if Assigned(FOnIncomingCall) then
         FOnIncomingCall(Self,
                         Params[0] {const WideString},
                         Params[1] {Integer});
    6: if Assigned(FOnEstablishedCall) then
         FOnEstablishedCall(Self,
                            Params[0] {const WideString},
                            Params[1] {Integer});
    7: if Assigned(FOnClearedCall) then
         FOnClearedCall(Self,
                        Params[0] {const WideString},
                        Params[1] {Integer},
                        Params[2] {Integer});
    8: if Assigned(FOnVolumeUpdated) then
         FOnVolumeUpdated(Self,
                          Params[0] {Integer},
                          Params[1] {Integer});
    9: if Assigned(FOnRegistered) then
         FOnRegistered(Self, Params[0] {const WideString});
    10: if Assigned(FOnUnRegistered) then
         FOnUnRegistered(Self, Params[0] {const WideString});
    11: if Assigned(FOnPlayFinished) then
         FOnPlayFinished(Self, Params[0] {const WideString});
    12: if Assigned(FOnToneReceived) then
         FOnToneReceived(Self,
                         Params[0] {Integer},
                         Params[1] {Integer},
                         Params[2] {Integer});
    13: if Assigned(FOnTextMessageReceived) then
         FOnTextMessageReceived(Self,
                                Params[0] {const WideString},
                                Params[1] {const WideString});
    14: if Assigned(FOnPhoneNotify) then
         FOnPhoneNotify(Self, Params[0] {const WideString});
    15: if Assigned(FOnRemoteAlerting) then
         FOnRemoteAlerting(Self,
                           Params[0] {Integer},
                           Params[1] {Integer},
                           Params[2] {const WideString});
    16: if Assigned(FOnHoldCall) then
         FOnHoldCall(Self,
                     Params[0] {Integer},
                     Params[1] {Integer});
    17: if Assigned(FOnTextMessageSentStatus) then
         FOnTextMessageSentStatus(Self,
                                  Params[0] {const WideString},
                                  Params[1] {const WideString},
                                  Params[2] {Integer});
    18: if Assigned(FOnRecordFinished) then
         FOnRecordFinished(Self, Params[0] {const WideString});
    19: if Assigned(FOnSubscribeStatus) then
         FOnSubscribeStatus(Self,
                            Params[0] {Integer},
                            Params[1] {Integer},
                            Params[2] {const WideString});
    20: if Assigned(FOnUnSubscribeStatus) then
         FOnUnSubscribeStatus(Self,
                              Params[0] {Integer},
                              Params[1] {Integer},
                              Params[2] {const WideString});
    21: if Assigned(FOnSubscriptionRequest) then
         FOnSubscriptionRequest(Self,
                                Params[0] {const WideString},
                                Params[1] {const WideString});
    22: if Assigned(FOnSubscriptionNotify) then
         FOnSubscriptionNotify(Self,
                               Params[0] {Integer},
                               Params[1] {const WideString},
                               Params[2] {const WideString});
    23: if Assigned(FOnDetectedAnswerTime) then
         FOnDetectedAnswerTime(Self,
                               Params[0] {Integer},
                               Params[1] {Integer});
    24: if Assigned(FOnBaudotToneReceived) then
         FOnBaudotToneReceived(Self,
                               Params[0] {Integer},
                               Params[1] {Integer},
                               Params[2] {Integer});
    25: if Assigned(FOnSubscriptionTerminated) then
         FOnSubscriptionTerminated(Self, Params[0] {const WideString});
    26: if Assigned(FOnToneDetected) then
         FOnToneDetected(Self,
                         Params[0] {ToneType},
                         Params[1] {const WideString},
                         Params[2] {Integer},
                         Params[3] {Integer});
    27: if Assigned(FOnReceivedSipNotifyMsg) then
         FOnReceivedSipNotifyMsg(Self, Params[0] {const WideString});
    28: if Assigned(FOnPlayFinished2) then
         FOnPlayFinished2(Self,
                          Params[0] {const WideString},
                          Params[1] {Integer});
    29: if Assigned(FOnRemoteAlerting2) then
         FOnRemoteAlerting2(Self,
                            Params[0] {Integer},
                            Params[1] {Integer},
                            Params[2] {Integer},
                            Params[3] {const WideString});
    30: if Assigned(FOnReceivedRequestInfo) then
         FOnReceivedRequestInfo(Self,
                                Params[0] {Integer},
                                Params[1] {Integer},
                                Params[2] {const WideString},
                                Params[3] {const WideString});
    31: if Assigned(FOnBaudotFinished) then
         FOnBaudotFinished(Self,
                           Params[0] {const WideString},
                           Params[1] {Integer});
  end; {case DispID}
end;

function TCAbtoPhone.Get_Config: IConfig;
begin
    Result := DefaultInterface.Config;
end;

procedure TCAbtoPhone.Set_PlaybackVolume(level: Integer);
begin
  DefaultInterface.Set_PlaybackVolume(level);
end;

function TCAbtoPhone.Get_PlaybackVolume: Integer;
begin
    Result := DefaultInterface.PlaybackVolume;
end;

procedure TCAbtoPhone.Set_PlaybackMuted(Muted: Integer);
begin
  DefaultInterface.Set_PlaybackMuted(Muted);
end;

function TCAbtoPhone.Get_PlaybackMuted: Integer;
begin
    Result := DefaultInterface.PlaybackMuted;
end;

procedure TCAbtoPhone.Set_RecordVolume(level: Integer);
begin
  DefaultInterface.Set_RecordVolume(level);
end;

function TCAbtoPhone.Get_RecordVolume: Integer;
begin
    Result := DefaultInterface.RecordVolume;
end;

procedure TCAbtoPhone.Set_RecordMuted(Muted: Integer);
begin
  DefaultInterface.Set_RecordMuted(Muted);
end;

function TCAbtoPhone.Get_RecordMuted: Integer;
begin
    Result := DefaultInterface.RecordMuted;
end;

function TCAbtoPhone.Get_Subscriptions: ISubscriptions;
begin
    Result := DefaultInterface.Subscriptions;
end;

procedure TCAbtoPhone.Initialize;
begin
  DefaultInterface.Initialize;
end;

procedure TCAbtoPhone.InitializeEx(sendEventsFromSameThread: Integer);
begin
  DefaultInterface.InitializeEx(sendEventsFromSameThread);
end;

procedure TCAbtoPhone.SetCurrentLine(LineId: Integer);
begin
  DefaultInterface.SetCurrentLine(LineId);
end;

procedure TCAbtoPhone.StartCall(const Destination: WideString);
begin
  DefaultInterface.StartCall(Destination);
end;

procedure TCAbtoPhone.HangUp(ConnectionId: Integer);
begin
  DefaultInterface.HangUp(ConnectionId);
end;

procedure TCAbtoPhone.HangUpLastCall;
begin
  DefaultInterface.HangUpLastCall;
end;

procedure TCAbtoPhone.AnswerCall;
begin
  DefaultInterface.AnswerCall;
end;

procedure TCAbtoPhone.RejectCall;
begin
  DefaultInterface.RejectCall;
end;

procedure TCAbtoPhone.TransferCall(const Destination: WideString);
begin
  DefaultInterface.TransferCall(Destination);
end;

procedure TCAbtoPhone.AttendedTransferCall(LineId: Integer);
begin
  DefaultInterface.AttendedTransferCall(LineId);
end;

procedure TCAbtoPhone.HoldRetrieveCurrentCall;
begin
  DefaultInterface.HoldRetrieveCurrentCall;
end;

procedure TCAbtoPhone.JoinToCurrentCall(LineId: Integer);
begin
  DefaultInterface.JoinToCurrentCall(LineId);
end;

function TCAbtoPhone.PlayFile(const FilePath: WideString): Integer;
begin
  Result := DefaultInterface.PlayFile(FilePath);
end;

procedure TCAbtoPhone.StopPlayback;
begin
  DefaultInterface.StopPlayback;
end;

procedure TCAbtoPhone.StartRecording(const FilePath: WideString);
begin
  DefaultInterface.StartRecording(FilePath);
end;

procedure TCAbtoPhone.StopRecording;
begin
  DefaultInterface.StopRecording;
end;

procedure TCAbtoPhone.SendTextMessage(const address: WideString; const message: WideString; 
                                      bSendUnicode: Integer);
begin
  DefaultInterface.SendTextMessage(address, message, bSendUnicode);
end;

procedure TCAbtoPhone.SendTone(const Tone: WideString);
begin
  DefaultInterface.SendTone(Tone);
end;

procedure TCAbtoPhone.AppendWav(const DestinationFilename: WideString; 
                                const SourceFilename: WideString);
begin
  DefaultInterface.AppendWav(DestinationFilename, SourceFilename);
end;

function TCAbtoPhone.RetrieveExternalAddress: WideString;
begin
  Result := DefaultInterface.RetrieveExternalAddress;
end;

procedure TCAbtoPhone.ApplyConfig;
begin
  DefaultInterface.ApplyConfig;
end;

procedure TCAbtoPhone.CancelConfig;
begin
  DefaultInterface.CancelConfig;
end;

procedure TCAbtoPhone.SetConnectionContribution(ConnectionId: Integer; inputGain: Integer; 
                                                outputGain: Integer);
begin
  DefaultInterface.SetConnectionContribution(ConnectionId, inputGain, outputGain);
end;

procedure TCAbtoPhone.SetConnectionContributionRelated(ConnectionIdInput: Integer; 
                                                       ConnectionIdOutput: Integer; 
                                                       inputGain: Integer; outputGain: Integer);
begin
  DefaultInterface.SetConnectionContributionRelated(ConnectionIdInput, ConnectionIdOutput, 
                                                    inputGain, outputGain);
end;

procedure TCAbtoPhone.SetConnectionContributionRelatedLocal(ConnectionIdInput: Integer; 
                                                            inputGain: Integer; outputGain: Integer);
begin
  DefaultInterface.SetConnectionContributionRelatedLocal(ConnectionIdInput, inputGain, outputGain);
end;

function TCAbtoPhone.IsLineOccupied(LineId: Integer): Integer;
begin
  Result := DefaultInterface.IsLineOccupied(LineId);
end;

procedure TCAbtoPhone.TransferConnection(ConnectionId: Integer; const Destination: WideString);
begin
  DefaultInterface.TransferConnection(ConnectionId, Destination);
end;

function TCAbtoPhone.SDKPath: WideString;
begin
  Result := DefaultInterface.SDKPath;
end;

procedure TCAbtoPhone.PlayBuffer(bufferPtr: Int64; size: Integer; rate: Integer);
begin
  DefaultInterface.PlayBuffer(bufferPtr, size, rate);
end;

procedure TCAbtoPhone.StartRecordingBuffer(bufferPtr: Int64; size: Integer);
begin
  DefaultInterface.StartRecordingBuffer(bufferPtr, size);
end;

function TCAbtoPhone.RetrieveVersion: WideString;
begin
  Result := DefaultInterface.RetrieveVersion;
end;

function TCAbtoPhone.GetSIPHeaderValue(const Header: WideString): WideString;
begin
  Result := DefaultInterface.GetSIPHeaderValue(Header);
end;

procedure TCAbtoPhone.SetSIPHeaderValue(const Header: WideString; const HeaderVal: WideString);
begin
  DefaultInterface.SetSIPHeaderValue(Header, HeaderVal);
end;

procedure TCAbtoPhone.StartRecordingConnection(ConnectionId: Integer; const FilePath: WideString);
begin
  DefaultInterface.StartRecordingConnection(ConnectionId, FilePath);
end;

procedure TCAbtoPhone.StopRecordingConnection(ConnectionId: Integer);
begin
  DefaultInterface.StopRecordingConnection(ConnectionId);
end;

function TCAbtoPhone.GetSIPBodyMultiPartMimeText(PartIdx: Integer): WideString;
begin
  Result := DefaultInterface.GetSIPBodyMultiPartMimeText(PartIdx);
end;

procedure TCAbtoPhone.SendToneEx(Tone: Integer; Duration: Integer; bSendAudio_InBand: Integer; 
                                 bSend_RFC4733_OutOfBand: Integer; bSend_SIP_INFO: Integer);
begin
  DefaultInterface.SendToneEx(Tone, Duration, bSendAudio_InBand, bSend_RFC4733_OutOfBand, 
                              bSend_SIP_INFO);
end;

procedure TCAbtoPhone.HoldRetrieveCall(LineId: Integer);
begin
  DefaultInterface.HoldRetrieveCall(LineId);
end;

function TCAbtoPhone.GetSIPHeaderValueLine(const Header: WideString; LineId: Integer): WideString;
begin
  Result := DefaultInterface.GetSIPHeaderValueLine(Header, LineId);
end;

procedure TCAbtoPhone.SendBaudotTone(BaudotTone: Integer);
begin
  DefaultInterface.SendBaudotTone(BaudotTone);
end;

function TCAbtoPhone.DnsSrvLookup(const sipSrvName: WideString): Integer;
begin
  Result := DefaultInterface.DnsSrvLookup(sipSrvName);
end;

procedure TCAbtoPhone.DnsSrvGetDetails(receivedRecordIndex: Integer; out hostName: WideString; 
                                       out srcIP: WideString; out Port: Integer; 
                                       out priority: Integer; out weight: Integer);
begin
  DefaultInterface.DnsSrvGetDetails(receivedRecordIndex, hostName, srcIP, Port, priority, weight);
end;

function TCAbtoPhone.PlayFileLine(const FilePath: WideString; LineId: Integer): Integer;
begin
  Result := DefaultInterface.PlayFileLine(FilePath, LineId);
end;

procedure TCAbtoPhone.SetPlayingFileContribution(gain: Integer);
begin
  DefaultInterface.SetPlayingFileContribution(gain);
end;

procedure TCAbtoPhone.StartVoiceEnergyDetectionPeriod(timeOutMs: Integer; minEnergyValue: Integer; 
                                                      maxEnergyValue: Integer; ConnectionId: Integer);
begin
  DefaultInterface.StartVoiceEnergyDetectionPeriod(timeOutMs, minEnergyValue, maxEnergyValue, 
                                                   ConnectionId);
end;

procedure TCAbtoPhone.StopPlaybackLine(LineId: Integer);
begin
  DefaultInterface.StopPlaybackLine(LineId);
end;

procedure TCAbtoPhone.SyncDevicesList;
begin
  DefaultInterface.SyncDevicesList;
end;

procedure TCAbtoPhone.RestartAudioSubsystem;
begin
  DefaultInterface.RestartAudioSubsystem;
end;

procedure TCAbtoPhone.StartSendingNoise(Tone1AmpPermille: Integer; Tone2AmpPermille: Integer; 
                                        IntervalMs: Integer; FrequencyHz: Integer);
begin
  DefaultInterface.StartSendingNoise(Tone1AmpPermille, Tone2AmpPermille, IntervalMs, FrequencyHz);
end;

function TCAbtoPhone.HasSIPBodyVideoMedia(LineId: Integer): Integer;
begin
  Result := DefaultInterface.HasSIPBodyVideoMedia(LineId);
end;

procedure TCAbtoPhone.MoveConnectionToLine(LineId: Integer; ConnectionId: Integer);
begin
  DefaultInterface.MoveConnectionToLine(LineId, ConnectionId);
end;

procedure TCAbtoPhone.StartRecordingConnectionBuffer(ConnectionId: Integer; bufferPtr: Int64; 
                                                     size: Integer);
begin
  DefaultInterface.StartRecordingConnectionBuffer(ConnectionId, bufferPtr, size);
end;

procedure TCAbtoPhone.BindToAudioDevices;
begin
  DefaultInterface.BindToAudioDevices;
end;

procedure TCAbtoPhone.AttendedTransferCallLine(fromLineId: Integer; toLineId: Integer);
begin
  DefaultInterface.AttendedTransferCallLine(fromLineId, toLineId);
end;

procedure TCAbtoPhone.SendBaudotString(const BaudotString: WideString);
begin
  DefaultInterface.SendBaudotString(BaudotString);
end;

procedure TCAbtoPhone.RestartAudioSubsystemEx(const PrimaryPlaybackDvc: WideString; 
                                              const SecPlaybackDvc: WideString; 
                                              const PrimaryRecordDvc: WideString; 
                                              const SecRecordDvc: WideString);
begin
  DefaultInterface.RestartAudioSubsystemEx(PrimaryPlaybackDvc, SecPlaybackDvc, PrimaryRecordDvc, 
                                           SecRecordDvc);
end;

function TCAbtoPhone.GetSIPHeaderValueLineArr(const Header: WideString; LineId: Integer): OleVariant;
begin
  Result := DefaultInterface.GetSIPHeaderValueLineArr(Header, LineId);
end;

procedure TCAbtoPhone.MuteLocalVideo(bMute: Integer);
begin
  DefaultInterface.MuteLocalVideo(bMute);
end;

function TCAbtoPhone.StartCall2(const Destination: WideString): Integer;
begin
  Result := DefaultInterface.StartCall2(Destination);
end;

function TCAbtoPhone.StartCallEx(const Destination: WideString; const FromDisplName: WideString): Integer;
begin
  Result := DefaultInterface.StartCallEx(Destination, FromDisplName);
end;

procedure TCAbtoPhone.UpdateCall(ConnectionId: Integer; const FromDisplName: WideString; 
                                 bSendInvite: WordBool);
begin
  DefaultInterface.UpdateCall(ConnectionId, FromDisplName, bSendInvite);
end;

procedure TCAbtoPhone.SendRequestInfo(ConnectionId: Integer; const contentType: WideString; 
                                      const Msg: WideString);
begin
  DefaultInterface.SendRequestInfo(ConnectionId, contentType, Msg);
end;

function TCAbtoPhone.StartCallExLine(LineId: Integer; const Destination: WideString; 
                                     const FromDisplName: WideString): Integer;
begin
  Result := DefaultInterface.StartCallExLine(LineId, Destination, FromDisplName);
end;

procedure TCAbtoPhone.MakeDumpFile;
begin
  DefaultInterface.MakeDumpFile;
end;

procedure TCAbtoPhone.AnswerCallLine(LineId: Integer);
begin
  DefaultInterface.AnswerCallLine(LineId);
end;

procedure TCAbtoPhone.RejectCallLine(LineId: Integer);
begin
  DefaultInterface.RejectCallLine(LineId);
end;

function TCAbtoPhone.GetSIPMessageLine(LineId: Integer): WideString;
begin
  Result := DefaultInterface.GetSIPMessageLine(LineId);
end;

procedure TCAbtoPhone.AssignVideoWindow(ConnectionId: Integer; hVideoWindow: LONG_PTR);
begin
  DefaultInterface.AssignVideoWindow(ConnectionId, hVideoWindow);
end;

function TCAbtoPhone.StartCall3(const Destination: WideString; const FromUserName: WideString): Integer;
begin
  Result := DefaultInterface.StartCall3(Destination, FromUserName);
end;

procedure TCAbtoPhone.SendBaudotTone2(BaudotTone: Integer; gain: Integer);
begin
  DefaultInterface.SendBaudotTone2(BaudotTone, gain);
end;

procedure TCAbtoPhone.SendBaudotString2(const BaudotString: WideString; gain: Integer);
begin
  DefaultInterface.SendBaudotString2(BaudotString, gain);
end;

procedure TCAbtoPhone.SendRequestMWINotify(const Destination: WideString; const body: WideString);
begin
  DefaultInterface.SendRequestMWINotify(Destination, body);
end;

function TCAbtoPhone.StartCall4(const Destination: WideString; transp: TransportType): Integer;
begin
  Result := DefaultInterface.StartCall4(Destination, transp);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCAbtoPhoneProperties.Create(AServer: TCAbtoPhone);
begin
  inherited Create;
  FServer := AServer;
end;

function TCAbtoPhoneProperties.GetDefaultInterface: IAbtoPhone;
begin
  Result := FServer.DefaultInterface;
end;

function TCAbtoPhoneProperties.Get_Config: IConfig;
begin
    Result := DefaultInterface.Config;
end;

procedure TCAbtoPhoneProperties.Set_PlaybackVolume(level: Integer);
begin
  DefaultInterface.Set_PlaybackVolume(level);
end;

function TCAbtoPhoneProperties.Get_PlaybackVolume: Integer;
begin
    Result := DefaultInterface.PlaybackVolume;
end;

procedure TCAbtoPhoneProperties.Set_PlaybackMuted(Muted: Integer);
begin
  DefaultInterface.Set_PlaybackMuted(Muted);
end;

function TCAbtoPhoneProperties.Get_PlaybackMuted: Integer;
begin
    Result := DefaultInterface.PlaybackMuted;
end;

procedure TCAbtoPhoneProperties.Set_RecordVolume(level: Integer);
begin
  DefaultInterface.Set_RecordVolume(level);
end;

function TCAbtoPhoneProperties.Get_RecordVolume: Integer;
begin
    Result := DefaultInterface.RecordVolume;
end;

procedure TCAbtoPhoneProperties.Set_RecordMuted(Muted: Integer);
begin
  DefaultInterface.Set_RecordMuted(Muted);
end;

function TCAbtoPhoneProperties.Get_RecordMuted: Integer;
begin
    Result := DefaultInterface.RecordMuted;
end;

function TCAbtoPhoneProperties.Get_Subscriptions: ISubscriptions;
begin
    Result := DefaultInterface.Subscriptions;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TCConfig, TCSubscriptions, TCAbtoPhone]);
end;

end.

