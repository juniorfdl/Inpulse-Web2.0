unit Server.Base.Connection;

interface

uses
    /// ORMBr Conexão database
    dbebr.factory.interfaces,
    dbebr.factory.firedac,

//    ormbr.types.database,
    FireDAC.Stan.Intf,
    FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
    FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
    FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, Data.DB,
    //FireDAC.VCLUI.Wait
    FireDAC.Comp.Client, ormbr.dml.generator.Mysql,
    System.SysUtils;

type
  TFactoryFireDACHelper = class(TFactoryFireDAC)
    function ExecuteSQL(const ASQL: string): IDBResultSet; override;
  end;

  TBaseConnection = class
  private
    FConnection: TFactoryFireDACHelper;
    FFDConnection: TFDConnection;
    function GetConnection: TFactoryFireDACHelper;
  public
    CodFonia:String;
    property Connection: TFactoryFireDACHelper read GetConnection write FConnection;
    constructor create(pDataBase: String);
    destructor Destroy;
  end;

implementation

{ TBaseConnection }

uses Infotec.Ativo.Utils;

constructor TBaseConnection.create(pDataBase: String);
//var
 // DriverLink: TFDPhysMySQLDriverLink;
begin
  if FConnection = nil then
  begin
    {if (FileExists(ExtractFilePath(Application.ExeName) + 'cfg.ini')) then
    begin
      try
        vIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'cfg.ini');
        FFDConnection:= TFDConnection.Create(nil);
        FFDConnection.Params.Add('Server='+vIni.ReadString('BANCO', 'Server','127.0.0.1'));
        FFDConnection.Params.Add('Port='+vIni.ReadString('BANCO', 'Port','3306'));
        FFDConnection.Params.Add('Database='+vIni.ReadString('BANCO', 'Database','CRM_SGR'));
        FFDConnection.Params.Add('User_name='+vIni.ReadString('BANCO', 'User_name','root'));
        FFDConnection.Params.Add('Password='+vIni.ReadString('BANCO', 'Password','infotec'));
        FFDConnection.Params.Add('DriverID='+vIni.ReadString('BANCO', 'DriverID','MySQL'));

        CodFonia := LowerCase(vIni.ReadString('cfg', 'CodFonia', ''));
      finally
        FreeAndNil(vIni);
      end;
    end
    else begin
      if pDataBase = '' then
        pDataBase := 'CRM_SGR';

      FFDConnection:= TFDConnection.Create(nil);
      FFDConnection.Params.Add('Server=127.0.0.1');
      FFDConnection.Params.Add('Port=3306');
      FFDConnection.Params.Add('Database='+pDataBase);
      FFDConnection.Params.Add('User_name=root');
      FFDConnection.Params.Add('Password=infotec');
      FFDConnection.Params.Add('DriverID=MySQL');
    end; }
    CodFonia := '0';
    FFDConnection := TFDConnection.Create(nil);
    FFDConnection.LoginPrompt := False;
    FFDConnection.Open(TUtils.GetCaminhoBase);
//    FFDConnection.Params.Text := ;
    FConnection := TFactoryFireDACHelper.Create(FFDConnection, dnMySQL);
  end;
 // DriverLink := TFDPhysMySQLDriverLink.create(nil);
//  DriverLink.VendorLib := 'C:\SGR_WEB\libmySQL.dll';

  if not FConnection.IsConnected then
    FConnection.Connect;
end;

destructor TBaseConnection.Destroy;
begin
  FConnection.Disconnect;
  FConnection.Free;
  FFDConnection.Free;
end;

function TBaseConnection.GetConnection: TFactoryFireDACHelper;
begin
  Result := FConnection;
end;

{ TFactoryFireDACHelper }

function TFactoryFireDACHelper.ExecuteSQL(const ASQL: string): IDBResultSet;
begin
  Result := inherited;

  {$IFDEF DEBUG}
    Writeln(ASQL);
  {$ENDIF}
end;

end.
