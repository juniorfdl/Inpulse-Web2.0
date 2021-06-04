unit ufuncoes;

interface

uses dialogs, SysUtils, classes, adodb, WinSock, IniFiles;

procedure doSaveLog(msg: string);
function ExecSql(xsql: string; Tipo: Integer = 0): TADOQuery;
function GetIP: string;
function GetDiscaFone(AFone, ACidade, ADESC_FONE: string): string;
function vazio(texto: string): Boolean;
function iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
function FoneNovoDigito(Area, Fone, DESC_FONE: string): string;
function GetError(msg: String):PAnsiChar;


implementation

//uses uServiceInpulse;

function GetIP: string;
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  Name: string;
  MyFile: TIniFile;
begin

  {MyFile := TIniFile.Create(ExtractFilePath(log) + 'Cfg.ini');
  try
    Result := MyFile.ReadString('cfg', 'IP_LOCAL', '');
  finally
    MyFile.Free;
  end;

  if Result <> '' then exit;}

  WSAStartup(2, WSAData);
  SetLength(Name, 255);
  Gethostname(PChar(Name), 255);
  SetLength(Name, StrLen(PChar(Name)));
  HostEnt := gethostbyname(PChar(Name));
  with HostEnt^ do
  begin
    Result := Format('%d.%d.%d.%d',
      [Byte(h_addr^[0]), Byte(h_addr^[1]),
      Byte(h_addr^[2]), Byte(h_addr^[3])]);
  end;
  WSACleanup;
end;

function ExecSql(xsql: string; Tipo: Integer = 0): TADOQuery;
begin
  {try
    //addLog('sql: ' + xsql);
    Result := TADOQuery.Create(nil);
    Result.Connection := Service1.CONECT;
    Result.SQL.Text := xsql;
    if tipo = 0 then
      Result.Open
    else
      Result.ExecSQL;
  except
    on e: exception do
      doSaveLog('Erro sql: ' + xsql + ' - ' + e.Message);
  end;}
end;

function GetError(msg: String):PAnsiChar;
begin
  Result := Pchar(msg);
end;

procedure doSaveLog(msg: string);
var
  Lista: TStringList;
begin
  {Lista := TStringList.Create;
  try
    if FileExists(log) then
      lista.LoadFromFile(log);

    lista.Add(msg + ' : ' + TimeToStr(Now));
    lista.SaveToFile(log);
  finally
    Lista.Free;
  end;}
end;

function GetDiscaFone(AFone, ACidade, ADESC_FONE: string): string;
{var
  varPrefixo: string;
  varFone: string;
  Prefixo: string;
  Operadora: string;
  ExistsCidade: Boolean;}
begin

{  if Length(AFone) <= 6 then
  begin
    Result := AFone;
    exit;
  end;

  if Copy(AFone, 1, 1) = '0' then
    AFone := Copy(AFone, 2, 20);

  with ExecSql(' select DDD_LOCAL, OPERADORA_LOCAL from parametros limit 1 ') do
  try
    Prefixo := FieldByName('DDD_LOCAL').AsString;
    Operadora := FieldByName('OPERADORA_LOCAL').AsString;
  finally
    Free;
  end;

  varPrefixo := Copy(AFone, 1, 2);
  varFone := Copy(AFone, 3, 10);

  with ExecSql(' SELECT a.CODIGO FROM cidades a inner join cidades_ddd b on b.cidade = a.CODIGO where a.NOME = ' + QuotedStr(ACidade)) do
  try
    ExistsCidade := not IsEmpty;
  finally
    Free;
  end;

  if (varPrefixo = Prefixo) and not (ExistsCidade) then
  begin
    if not vazio(ACidade) and (varPrefixo = Prefixo) then
    begin
      with ExecSql('SELECT USAR FROM ddds_diferentes WHERE DDD = ' + QuotedStr(Prefixo) + ' AND CIDADE = ' + QuotedStr(ACidade)) do
      try
        varFone := iif(Fields[0].AsString = 'SIM', Operadora, '') +
          iif(Fields[0].AsString = 'SIM', Prefixo, '') + FoneNovoDigito(varPrefixo, varFone, ADESC_FONE) + varFone;
      finally
        Free;
      end;
    end
    else
    begin
      VarFone := FoneNovoDigito(varPrefixo, varFone, ADESC_FONE) + varFone; //Nova Lei SP
    end;
    Result := VarFone;
  end
  else
  begin
    if not vazio(ACidade) and (varPrefixo = Prefixo) then
    begin
      with ExecSql('SELECT USAR FROM ddds_diferentes WHERE DDD = ' + QuotedStr(Prefixo) + ' AND CIDADE = ' + QuotedStr(ACidade)) do
      try
        Result := Operadora + iif(Fields[0].AsString = 'SIM', varPrefixo, '') +
        FoneNovoDigito(varPrefixo, varFone, ADESC_FONE) + varFone //Nova Lei SP
      finally
        Free;
      end;
    end
    else
    begin
      Result := Operadora + varPrefixo + FoneNovoDigito(varPrefixo, varFone, ADESC_FONE) + varFone //Nova Lei SP
    end;
  end;

  if (varPrefixo = Prefixo) and (LowerCase(MetodoDiscagem) = LowerCase('weon')) then
  begin // tira o zero a esquerda
    if (copy(Result, 1, 1) = '0') then
      Result := copy(Result, 2, 100);
  end;

  if LowerCase(MetodoDiscagem) <> LowerCase('weon') then
  begin
    if (Length(Result) in [8, 9]) and (copy(Result, 1, 1) <> '0') then
      Result := iif(ExtInt, CodFonia, '0') + Result;
  end;

 }

end;

function vazio(texto: string): Boolean;
begin
  Result := (Length(trim(texto)) = 0);
end;

function iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
begin
  if Condicao then
    Result := Verdadeiro
  else
    Result := Falso;
end;

function FoneNovoDigito(Area, Fone, DESC_FONE: string): string;
var
  DoisDigitos, QuatroDigitos: Integer;
begin
  Result := '';

      //if AnsiIndexStr(Area, ['11', '12', '13', '14', '15', '16', '17', '18', '19']) >= 0 then
  with ExecSql('SELECT DIGITO FROM fone_digito WHERE DDD = ' + QuotedStr(Area)) do
  try
    DoisDigitos := StrToInt(Copy(Fone, 1, 2));
    QuatroDigitos := StrToInt(Copy(Fone, 1, 4));
    if DoisDigitos in [62, 67, 71, 72, 73, 74, 75, 76, 80, 81, 82, 83, 84,
      85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 96, 97, 98, 99] then
    begin
      Open;
      Result := Fields[0].AsString;
    end
    else
    begin
      case QuatroDigitos of
        7900..7949, 5472..5474, 5769..5786, 6057..6060, 6182..6199, 6370..6419,
          6470..6499, 6840..6866, 6900..6913, 7087..7099, 5252..5267, 5400..5419,
          5700..5768, 6011..6056, 6086..6167, 6500..6569, 6651..6699, 6800..6826,
          6867..6899, 6932..6999, 7971..7999, 5399, 6168..6181, 6300..6339,
          6570..6650, 6914..6931, 7052..7086, 7968..7970, 5116..5170, 5200..5211,
          5214..5251, 5268..5299, 5329..5398, 5420..5471, 5475..5499, 5787..5799,
          5942..5969, 5980..5999, 6061..6085, 6340..6369, 6420..6469, 6827..6839,
          7011..7051, 7950..7967:
          begin
            Open;
            Result := Fields[0].AsString;
          end;
      end;
    end;

    if (UpperCase(DESC_FONE) = 'CELULAR') and (Result = '') then
    begin
      Open;
      Result := Fields[0].AsString;
    end;

    Close;
  finally
    Free;
  end;
end;


end.

