unit Server.Models.Cadastros.ConfigMail;
interface

uses
  System.Classes,
  DB,
  System.SysUtils,
  Generics.Collections,
  /// orm
  dbcbr.mapping.attributes,
  dbcbr.types.mapping,
  ormbr.types.lazy,
  ormbr.types.nullable,
  dbcbr.mapping.register, Server.Models.Base.TabelaBase;

type
  TAnexo = class
  private
    fNOME: String;
    fOPERADOR: String;
    fFILEBASE64: string;
  published
    property NOME: String read fNOME write fNOME;
    property OPERADOR: String read fOPERADOR write fOPERADOR;
    property FILEBASE64: String read fFILEBASE64 write fFILEBASE64;
  end;

  [Entity]
  [Table('CONFIG_MAIL','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TConfigMail = class(TTabelaBase)
  private
    fDESCRICAO: String;
    fCONFIRMACAOLEITURA: String;
    fCOPIA: String;
    fCOPIAOCULTA: String;
    fASSUNTO: String;
    fTEXTO: String;
    fAUTENTICA: String;
    fPORT: Integer;
    fHOST: String;
    fUSUARIO: String;
    fPASS: String;
    fSSL: String;
    fEMAIL_EXIBE: String;
    fOPERADOR_NAME: String;
    fNOME_EXIBE: String;
    fPara: String;
    fPRIORIDADE: String;
    fTLS: String;
    fDataBase: String;
    fOPERADOR: String;
    fANEXOS: TObjectList<TAnexo>;
    function Getid: Integer;
    procedure Setid(const Value: Integer);
    procedure GetDESCRICAO(const Value: String);
    procedure GetASSUNTO(const Value: String);
    procedure GetTEXTO(const Value: String);
    procedure GetEMAIL_EXIBE(const Value: String);

    procedure GetNOME_EXIBE(const Value: String);  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read Getid write Setid;

    [Column('DESCRICAO', ftString, 50)]
    [Dictionary('DESCRICAO','Mensagem de validação','','','',taLeftJustify)]
    property DESCRICAO: String read fDESCRICAO write GetDESCRICAO;

    [Column('CONFIRMACAOLEITURA', ftString, 3)]
    property CONFIRMACAOLEITURA: String read fCONFIRMACAOLEITURA write fCONFIRMACAOLEITURA;

    [Column('COPIA', ftString, 60)]
    property COPIA: String read fCOPIA write fCOPIA;

    [Column('COPIAOCULTA', ftString, 60)]
    property COPIAOCULTA: String read fCOPIAOCULTA write fCOPIAOCULTA;

    [Column('ASSUNTO', ftString, 60)]
    property ASSUNTO: String read fASSUNTO write GetASSUNTO;

    [Column('TEXTO', ftString, 255)]
    property TEXTO: String read fTEXTO write GetTEXTO;

    [Column('AUTENTICA', ftString, 3)]
    property AUTENTICA: String read fAUTENTICA write fAUTENTICA;

    [Column('PORT', ftInteger)]
    property PORT: Integer read fPORT write fPORT;

    [Column('HOST', ftString, 20)]
    property HOST: String read fHOST write fHOST;

    [Column('USUARIO', ftString)]
    property USUARIO: String read fUSUARIO write fUSUARIO;

    [Column('PASS', ftString)]
    property PASS: String read fPASS write fPASS;

    [Column('SSL', ftString)]
    property SSL: String read fSSL write fSSL;

    [Column('EMAIL_EXIBE', ftString)]
    property EMAIL_EXIBE: String read fEMAIL_EXIBE write GetEMAIL_EXIBE;

    [Column('NOME_EXIBE', ftString)]
    property NOME_EXIBE: String read fNOME_EXIBE write GetNOME_EXIBE;

    [Column('TLS', ftString)]
    property TLS: String read fTLS write fTLS;

    [CalcField('OPERADOR_NAME', ftString)]
    property OPERADOR_NAME: String read fOPERADOR_NAME write fOPERADOR_NAME;

    [CalcField('Para', ftString)]
    property Para: String read fPara write fPara;

    [CalcField('PRIORIDADE', ftString)]
    property PRIORIDADE: String read fPRIORIDADE write fPRIORIDADE;

    [CalcField('DataBase', ftString)]
    property DataBase: String read fDataBase write fDataBase;

    [CalcField('OPERADOR', ftString)]
    property OPERADOR: String read fOPERADOR write fOPERADOR;

    property ANEXOS: TObjectList<TAnexo> read fANEXOS write fANEXOS;

  end;

implementation


{ TConfigMail }

uses Infotec.Utils;

constructor TConfigMail.create;
begin
  ANEXOS:= TObjectList<TAnexo>.Create;
end;

destructor TConfigMail.destroy;
begin
  inherited;
  ANEXOS.Free;
end;

procedure TConfigMail.GetASSUNTO(const Value: String);
begin
  fASSUNTO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

procedure TConfigMail.GetDESCRICAO(const Value: String);
begin
  fDESCRICAO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

procedure TConfigMail.GetEMAIL_EXIBE(const Value: String);
begin
  fEMAIL_EXIBE := TInfotecUtils.RemoverEspasDuplas(Value);
end;

function TConfigMail.Getid: Integer;
begin
  Result := fid;
end;

procedure TConfigMail.GetNOME_EXIBE(const Value: String);
begin
  fNOME_EXIBE := TInfotecUtils.RemoverEspasDuplas(Value);
end;

procedure TConfigMail.GetTEXTO(const Value: String);
begin
  fTEXTO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

procedure TConfigMail.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TConfigMail);

end.

