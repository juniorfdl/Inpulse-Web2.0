unit Server.Functions.Diversas;

interface

uses //Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.Classes;

type
  TFunctionsDiversos = class
  public
    class function SomenteNumeros(const pDados: String): String;
    class procedure ShowMessageDesenv(msg: string);
    class procedure addLog(Erro: string; Arquivo: string = '');
    class function GetFolderTemp: string;
    class procedure SalvarBase64(const psfileBase64, psfilename: string);
  end;

implementation

uses System.NetEncoding, Infotec.Ativo.Utils;

{ TFunctionsDiversos }

class procedure TFunctionsDiversos.addLog(Erro, Arquivo: string);
begin
 if TUtils.GetLog.IsEmpty then
   Exit;

  Writeln(DateTimeToStr(Now) + ' - ' + Erro);

  {try
      with TStringList.Create do
        try
          if Arquivo = '' then
            Arquivo := 'LogErro_' + FormatDateTime('yyyymmdd', now) + '.txt';

          Arquivo := ExtractFilePath(Application.ExeName) + Arquivo;

          if FileExists(Arquivo) then
            LoadFromFile(Arquivo);

          Add(#13 + DateTimeToStr(now) + #13 + Erro);

          SaveToFile(Arquivo);

        finally
          Free;
        end;
  except
  end; }
end;

class procedure TFunctionsDiversos.ShowMessageDesenv(msg: string);
begin
  if TUtils.GetLog.IsEmpty then
   Exit;

  Writeln(DateTimeToStr(Now) + ' - ' + msg);

  {if FileExists(ExtractFilePath(Application.ExeName) + 'log.txt') then
    TFunctionsDiversos.addLog(msg);

  if FileExists(ExtractFilePath(Application.ExeName) + 'desenvolvimento.cfg') then
    raise Exception.Create(msg);}
end;

class function TFunctionsDiversos.SomenteNumeros(const pDados: String): String;
var
  I: Integer;
  T: string;
begin
  if pDados = '' then
    Exit;

  try
    T := '';
    for I := Length(pDados) downto 1 do
      if (pDados[I] in ['0' .. '9']) then
        T := pDados[I] + T;
  except

  end;

  Result := T;
end;

class function TFunctionsDiversos.GetFolderTemp: string;
begin
end;

class procedure TFunctionsDiversos.SalvarBase64(const psfileBase64, psfilename: string);
var
  vJsonStr:String;
  lInStream : TStringStream;
  lOutStream : TMemoryStream;
begin
  lInStream := TStringStream.Create(psfileBase64);
  lOutStream := TMemoryStream.Create;
  try
    lInStream.Position := 0;
    TNetEncoding.Base64.Decode(lInStream, lOutStream);
    lOutStream.Position := 0;
    lOutStream.SaveToFile(psfilename);
  finally
    FreeAndNil(lInStream);
    FreeAndNil(lOutStream);
  end;
end;

end.


