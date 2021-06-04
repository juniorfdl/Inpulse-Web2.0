unit uServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDWAbout, uRESTDWBase, Winapi.ShellAPI,
  uDMServer, Vcl.ExtCtrls, Vcl.AppEvnts, IdContext, IdCustomHTTPServer, ActiveX;

type
  TfServer = class(TForm)
    EditPort: TEdit;
    ButtonOpenBrowser: TButton;
    RESTServicePooler1: TRESTServicePooler;
    ApplicationEvents1: TApplicationEvents;
    TrayIcon1: TTrayIcon;
    ButtonStop: TButton;
    ButtonStart: TButton;
    Timer1: TTimer;
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
    procedure LoadAccountInfo;
    procedure Minimizar;
    procedure StartServer;

    { Private declarations }
  public
    { Public declarations }
    DLLProg:Cardinal;
  end;

var
  fServer: TfServer;

implementation

{$R *.dfm}

procedure TfServer.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not RESTServicePooler1.Active;
  ButtonStop.Enabled := RESTServicePooler1.Active;
  EditPort.Enabled := not RESTServicePooler1.Active;
end;

procedure TfServer.ButtonStartClick(Sender: TObject);
begin
  StartServer;
  Minimizar;
end;

procedure TfServer.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TfServer.ButtonStopClick(Sender: TObject);
begin
  RESTServicePooler1.Active := False;
end;

procedure TfServer.FormCreate(Sender: TObject);
begin
  DLLProg := 0;
  //CoInitialize(nil);
end;

procedure TfServer.FormDestroy(Sender: TObject);
begin
  if DLLProg > 0 then
    FreeLibrary(DLLProg);
end;

procedure TfServer.FormShow(Sender: TObject);
begin
 StartServer;
end;

procedure TfServer.LoadAccountInfo;
begin
  if DLLProg > 0 then exit;

  DLLProg := 0;
  try
    DLLProg := LoadLibrary(Pchar('DllSipAntigo.dll'));
  except
    on E: Exception do
      raise Exception.Create(e.Message);
  end;
end;


procedure TfServer.Timer1Timer(Sender: TObject);
begin
  Minimizar;
  Timer1.Enabled := False;
end;

procedure TfServer.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfServer.Minimizar;
begin
  Self.Hide();
  Self.WindowState := wsMinimized;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TfServer.StartServer;
begin
  LoadAccountInfo;
  RESTServicePooler1.ServerMethodClass:= TDMServer;
  RESTServicePooler1.ServicePort := StrToIntDef(EditPort.Text, 1234);
  RESTServicePooler1.Active := True;
end;

end.
