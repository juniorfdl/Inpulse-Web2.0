object fServer: TfServer
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Server SIP'
  ClientHeight = 136
  ClientWidth = 227
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EditPort: TEdit
    Left = 24
    Top = 43
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '4321'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 80
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 1
    OnClick = ButtonOpenBrowserClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = ButtonStopClick
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 3
    OnClick = ButtonStartClick
  end
  object RESTServicePooler1: TRESTServicePooler
    Active = False
    CORS = True
    ServicePort = 8082
    ProxyOptions.Port = 8888
    ServerParams.HasAuthentication = False
    ServerParams.UserName = 'testserver'
    ServerParams.Password = 'testserver'
    SSLMethod = sslvSSLv2
    SSLVersions = []
    Encoding = esUtf8
    ServerContext = 'restdataware'
    RootPath = '/'
    SSLVerifyMode = []
    SSLVerifyDepth = 0
    ForceWelcomeAccess = False
    Left = 164
    Top = 25
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 96
    Top = 40
  end
  object TrayIcon1: TTrayIcon
    Hint = 'Servidor Pedido'
    BalloonTitle = 'Servidor Pedido'
    OnDblClick = TrayIcon1DblClick
    Left = 88
    Top = 72
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 184
    Top = 72
  end
end
