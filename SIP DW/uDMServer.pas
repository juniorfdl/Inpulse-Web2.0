unit uDMServer;

interface

uses
  System.SysUtils, System.Classes, uDWDataModule, uDWAbout, uRESTDWServerEvents,
  uDWJSONObject, uDWConstsData, uDWJSONTools, System.JSON, uRESTDWPoolerDB,
  Inpulse.SIP.Models.Resgistrar, ormbr.rest.Json, uRotinasSIPAntigo, Forms, ActiveX;

type
  TDMServer = class(TServerMethodDataModule)
    DWServerEvents1: TDWServerEvents;
    procedure DWServerEvents1EventsregistrarReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsstateReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsLigarReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsDesligarReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsTransferirReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWServerEvents1EventsEnviarDTMFReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure ServerMethodDataModuleCreate(Sender: TObject);
  private
    procedure addLog(Erro: string; Arquivo: string = '');
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMServer: TDMServer;

implementation

uses uServer;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMServer.DWServerEvents1EventsDesligarReplyEvent(
  var Params: TDWParams; var Result: string);
var
  vJsonStr: String;
  vobj: TModelLigar;
begin

  if Params.ItemsString['set'].AsString = '' then
    raise Exception.Create('Parametro Set não informado!');

  try
    TRotinasSIPAntigo.New(fServer.DLLProg).Desligar;
    vobj := TModelLigar.Create;
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := vJsonStr;
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

procedure TDMServer.DWServerEvents1EventsEnviarDTMFReplyEvent(
  var Params: TDWParams; var Result: string);
var
  vobj: TModelLigar;
  vJsonStr: String;
begin
  if Params.ItemsString['set'].AsString = '' then
    raise Exception.Create('Parametro Set não informado!');

  try
    vobj := TORMBrJson.JsonToObject<TModelLigar>(Params.ItemsString['set'].AsString);
    TRotinasSIPAntigo.New(fServer.DLLProg).EnviarDTMF(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := vJsonStr;
  except
    on E: Exception do
      addLog(E.Message);
  end;

end;

procedure TDMServer.DWServerEvents1EventsLigarReplyEvent(var Params: TDWParams;
  var Result: string);
var
  vobj: TModelLigar;
  vJsonStr: String;
begin
  if Params.ItemsString['set'].AsString = '' then
    raise Exception.Create('Parametro Set não informado!');

  try
    vobj := TORMBrJson.JsonToObject<TModelLigar>(Params.ItemsString['set'].AsString);
    TRotinasSIPAntigo.New(fServer.DLLProg).Ligar(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := vJsonStr;
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

procedure TDMServer.DWServerEvents1EventsregistrarReplyEvent(
  var Params: TDWParams; var Result: string);
var
  vobj: TRegistrar;
  vJsonStr: String;
  JObj: TJSONObject;
begin
  if Params.ItemsString['set'].AsString = '' then
    raise Exception.Create('Parametro Set não informado!');

  try
    vobj := TORMBrJson.JsonToObject<TRegistrar>(Params.ItemsString['set'].AsString);
    TRotinasSIPAntigo.New(fServer.DLLProg).Registrar(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := vJsonStr;
  except
    on E: Exception do
      addLog(E.Message);
  end;

end;

procedure TDMServer.DWServerEvents1EventsstateReplyEvent(var Params: TDWParams;
  var Result: string);
var
  vobj: TModelState;
  vJsonStr: String;
  JObj: TJSONObject;
begin
  if Params.ItemsString['set'].AsString = '' then
    raise Exception.Create('Parametro Set não informado!');

  try
    vobj := TORMBrJson.JsonToObject<TModelState>(Params.ItemsString['set'].AsString);
    vJsonStr :=TRotinasSIPAntigo.New(fServer.DLLProg).GetState;
    vobj.StateDescricao := vJsonStr;
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := vJsonStr;
  except
    on E: Exception do
      addLog(E.Message);
  end;

end;

procedure TDMServer.DWServerEvents1EventsTransferirReplyEvent(
  var Params: TDWParams; var Result: string);
var
  vobj: TModelLigar;
  vJsonStr: String;
begin

  if Params.ItemsString['set'].AsString = '' then
    raise Exception.Create('Parametro Set não informado!');

  try
    vobj := TORMBrJson.JsonToObject<TModelLigar>(Params.ItemsString['set'].AsString);
    TRotinasSIPAntigo.New(fServer.DLLProg).Transferir(vobj);
    vJsonStr := TORMBrJson.ObjectToJsonString(vobj);
    Result := vJsonStr;
  except
    on E: Exception do
      addLog(E.Message);
  end;
end;

procedure TDMServer.ServerMethodDataModuleCreate(Sender: TObject);
begin
  CoInitialize(nil);
end;

procedure TDMServer.addLog(Erro: string; Arquivo: string = '');
var
  CaminhoPrograma: String;
begin
  try
    CaminhoPrograma := ExtractFilePath(Application.ExeName);
    with TStringList.Create do
      try
        if Arquivo = '' then
          Arquivo := 'LogErro_' + FormatDateTime('yyyymmdd', now) + '.txt';

        Arquivo := CaminhoPrograma + Arquivo;

        if FileExists(Arquivo) then
          LoadFromFile(Arquivo);

        Add(#13 + DateTimeToStr(now) + #13 + Erro);

        SaveToFile(Arquivo);
      finally
        Free;
      end;
  except
  end;
end;


end.
