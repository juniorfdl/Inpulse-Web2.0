unit uServerContainer;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSServer,
  Datasnap.DSCommonServer,
  Datasnap.DSSession,
  IPPeerServer,
  IPPeerAPI,
  Datasnap.DSAuth,
  System.Generics.Collections, uInterfaceSIP, uRotinasSIP, Forms,
  uRotinasSIPAntigo, IniFiles;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DSServer1Disconnect(DSConnectEventObject: TDSConnectEventObject);
  private
    { Private declarations }
    FSessionID: TDSSession;
    class var FSession: TDictionary<string, TObject>;
    class var RotinasSIP:ISip;
    function ExecutaNovoSIP: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDictionary: TDictionary<string, TObject>;
    class function GetObjSIP: String;
    class function Ligar(const pObj: TObject): String;
    class function Transferir(const pObj: TObject): String;
    class function EnviarDTMF(const pObj: TObject): String;
    class function Desligar(): String;
    class function Registrar(const pObj: TObject): String;
    class function GetState(const pObj: TObject): String;
  end;

function DSServer: TDSServer;

implementation

{$R *.dfm}

uses
  uServerModule;

var
  FModule: TComponent;
  FDSServer: TDSServer;

function DSServer: TDSServer;
begin
  Result := FDSServer;

end;

class function TServerContainer1.EnviarDTMF(const pObj: TObject): String;
begin
  Result := RotinasSIP.EnviarDTMF(pObj);
end;

function TServerContainer1.ExecutaNovoSIP:Boolean;
var
  vConfIni:TIniFile;
  vArquivo:String;
begin
  result := false;
  vArquivo := ExtractFilePath(Application.ExeName) + 'cfg.ini';
  if FileExists(vArquivo) then
  begin
    vConfIni:= TIniFile.Create(vArquivo);
    try
      result := LowerCase(vConfIni.ReadString('cfg', 'NOVOSIP', 'NAO')) = 'sim';
    finally
      vConfIni.Destroy;
    end;
  end;
end;

constructor TServerContainer1.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServer1;

  if not Assigned(RotinasSIP) then
  begin
    if ExecutaNovoSIP then
      RotinasSIP := TRotinasSIP.Create
    else
      RotinasSIP := TRotinasSIPAntigo.Create;
  end;
end;

procedure TServerContainer1.DataModuleCreate(Sender: TObject);
begin
  FSession := TDictionary<string, TObject>.Create;
end;

procedure TServerContainer1.DataModuleDestroy(Sender: TObject);
begin
  FSession.Clear;
  FSession.Free;
end;

class function TServerContainer1.Desligar: String;
begin
  Result := RotinasSIP.Desligar();
end;

destructor TServerContainer1.Destroy;
begin
  inherited;
  FDSServer := nil;
end;

procedure TServerContainer1.DSServer1Disconnect(
  DSConnectEventObject: TDSConnectEventObject);
begin
  FSessionID := TDSSessionManager.GetThreadSession;
end;

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uServerModule.TGetSIP;
end;

class function TServerContainer1.GetDictionary: TDictionary<string, TObject>;
begin
  Result := FSession;
end;

class function TServerContainer1.GetObjSIP: String;
begin
  Result := DSServer.Name;
end;

class function TServerContainer1.GetState(const pObj: TObject): String;
begin
  Result := RotinasSIP.GetState;
end;

class function TServerContainer1.Ligar(const pObj: TObject): String;
begin
  Result := RotinasSIP.Ligar(pObj);
end;

class function TServerContainer1.Registrar(const pObj: TObject): String;
begin
  Result := RotinasSIP.Registrar(pObj);
end;

class function TServerContainer1.Transferir(const pObj: TObject): String;
begin
  Result := RotinasSIP.Transferir(pObj);
end;

initialization
  FModule := TServerContainer1.Create(nil);
finalization
  FModule.Free;

end.

