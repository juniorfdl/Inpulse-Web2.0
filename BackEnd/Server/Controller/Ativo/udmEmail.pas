unit udmEmail;

interface

uses
  System.SysUtils, System.Classes, Server.Models.Cadastros.ConfigMail,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP,
  IdBaseComponent, IdMessage, IdText, IniFiles, IdAttachmentFile;

type
  TdmEmail = class(TDataModule)
    IdMessage: TIdMessage;
    IdSMTP: TIdSMTP;
    OpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  private
    function AlteraQuebraLinha(vTexto: string): String;
    function iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
    { Private declarations }
  public
    { Public declarations }
    procedure EnviarEmail(const AValue: TConfigMail);
  end;

var
  dmEmail: TdmEmail;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Server.Functions.Diversas;

{$R *.dfm}

{ TdmEmail }

function TdmEmail.iif(Condicao: Boolean; Verdadeiro, Falso: Variant): Variant;
begin
  if Condicao then
    Result := Verdadeiro
  else
    Result := Falso;
end;

function TdmEmail.AlteraQuebraLinha(vTexto : string) : String;
var
  i :Integer;
begin
  result := vTexto;

  i := 1;
  while i <= length(result) do
  begin
    if result[i] in [#$D, #$A] then
      result := copy(result, 1, i -1) +
                iif((result[i] = #$D) or (copy(result, i -3, 3) <> 'br>'), '<br>', '') +
                iif((result[i] = #$D) or (copy(result, i -2, 2) <> 'p>'), '<p>', '') +
                copy(result, i + 1, length(result) - i)
    else
      inc(i);
  end;
end;

procedure TdmEmail.EnviarEmail(const AValue: TConfigMail);
var
  fobj: TConfigMail;
  MBody, MPreview, vCaminhoAnexo:String;
  vAnexo: TAnexo;
begin
  fobj := AValue;
  try
    if fobj.AUTENTICA = 'SIM' then
      IdSMTP.AuthType := satDefault;

    IdSMTP.Port := fobj.PORT;
    IdSMTP.Host := fobj.HOST;
    IdSMTP.Username := fobj.USUARIO;
    IdSMTP.Password := fobj.PASS;

   //SSL
    if fobj.SSL = 'SIM' then
    begin
      IdSMTP.IOHandler := OpenSSL;
      IdSMTP.UseTLS := utUseExplicitTLS;
      IdSMTP.ConnectTimeout := 30000;
      IdSMTP.ReadTimeout := 30000;

      OpenSSL.SSLOptions.Method := sslvTLSv1;
      OpenSSL.SSLOptions.Mode := sslmClient;
      OpenSSL.Port := IdSMTP.Port; // atribui a porta ao manipulador (igual a do cliente FTP)
      OpenSSL.Destination := IdSMTP.Host + ':' + IntToStr(IdSMTP.Port); // indica o destino da conexão (pop.gmail.com:465)
      OpenSSL.Host := IdSMTP.Host; // atribui o host (pop.gmail.com)
    end
    else
    begin
      IdSMTP.IOHandler := nil
    end;

    IdMessage.From.Address := fobj.EMAIL_EXIBE;
    if fobj.OPERADOR_NAME <> '' then
      IdMessage.From.Name := fobj.NOME_EXIBE + ' - ' + fobj.OPERADOR_NAME
    else
      IdMessage.From.Name := fobj.NOME_EXIBE;

    IdMessage.Recipients.EMailAddresses := fobj.Para;
    IdMessage.CCList.EMailAddresses := fobj.COPIA;
    IdMessage.BccList.EMailAddresses := fobj.COPIAOCULTA;

    if (fobj.PRIORIDADE = 'Alta') then
      IdMessage.Priority := mpHigh
    else
    if (fobj.PRIORIDADE = 'Normal') then
      IdMessage.Priority := mpNormal
    else
    if (fobj.PRIORIDADE = 'Baixa') then
      IdMessage.Priority := mpLow;

    MBody := fobj.TEXTO;

    with IdMessage do
    begin
      Subject := fobj.ASSUNTO;
      ContentType := 'multipart/mixed';
      ContentDisposition := 'inline';
      Encoding := meMIME;
      Body.Text := fobj.TEXTO;
    end;

    MBody := '<html> <style> * {font-family: Garamond;}</style><body>' + fobj.TEXTO + '</body></html>';

    MBody := AlteraQuebraLinha(MBody);

    MPreview := MBody;

    MPreview := StringReplace(MPreview, #13, '<br/>', [rfReplaceAll, rfIgnoreCase]);

    with TIdText.Create(IdMessage.MessageParts) do
    begin
      ContentType := 'text/html';
      Body.Add(MPreview);
      Body.Clear;
      Body.Add(MBody);
    end;

    for vAnexo in AValue.ANEXOS do
    begin
      vCaminhoAnexo := TFunctionsDiversos.GetFolderTemp + 'Anexos';
      CreateDir(vCaminhoAnexo);
      vCaminhoAnexo := vCaminhoAnexo + '\Operador'+vAnexo.OPERADOR;
      CreateDir(vCaminhoAnexo);
      vCaminhoAnexo := vCaminhoAnexo + '\' + vAnexo.NOME;

      TFunctionsDiversos.SalvarBase64(vAnexo.FILEBASE64, vCaminhoAnexo);

      if fileExists(vCaminhoAnexo) then
      with TIDAttachmentFile.Create(IdMessage.MessageParts, TFilename(vCaminhoAnexo)) do
      begin
        //Headers.Add('Content-ID: <' + ImgName + '>');
        //ExtraHeaders.Values['Content-ID:'] :='c:\promo\image001.jpg';
      end;
    end;

    IdMessage.Body.Text := StringReplace(IdMessage.Body.Text, #13, '<br/>', [rfReplaceAll]);

    if fobj.TLS = 'SIM' then
    begin
      OpenSSL.SSLOptions.Method := sslvTLSv1;
      OpenSSL.SSLOptions.Mode := sslmClient;
      IdSMTP.IOHandler := OpenSSL;
      IdSMTP.UseTLS := utUseExplicitTLS;
    end;

    IdSMTP.Connect;

    if fobj.TLS = 'SIM' then
      IdSMTP.Authenticate;

    IdSMTP.Send(IdMessage);
    IdSMTP.Disconnect;

  finally
  end;
end;

end.
