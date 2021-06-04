unit Server.Models.Cadastros.Clientes;

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
  dbcbr.mapping.register,
  Server.Models.Base.TabelaBase,
  Server.Models.Ativo.DadosLigacao, Server.Models.Cadastros.Contatos,
  Server.Models.Cadastros.FonesCampanha,
  REST.Json.Types;

type
  [Entity]
  [Table('CLIENTES','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TClientes = class(TTabelaBase)
  private
    fCPF_CNPJ: String;
    FFANTASIA: String;
    fPESSOA: String;
    fAtivo: String;
    FRAZAO: String;
    fIE_RG: String;
    fCOD_ERP: Integer;
    fDataBase: String;
    //fid: Integer;
    fOPERADOR: Integer;
    fDadosLigacao: TDadosLigacao;
    fContatos: TObjectList<TContatos>;
    fOBS_OPERADOR: String;
    fOBS_ADMIN: String;
    fDATACAD: TDateTime;
    fDESC_FONE2: String;
    fDESC_FONE3: String;
    fDESC_FONE1: String;
    fFONE2: String;
    fFONE3: String;
    fFONE1: String;
    fBAIRRO: String;
    fCEP: String;
    fEND_RUA: String;
    fCOMPLEMENTO: String;
    fCIDADE: String;
    fESTADO: String;
    fCONTATO_MAIL: String;
    fEMAIL: String;
    fWEBSITE: String;
    fDESCFAX: String;
    fFAX: String;
    fAREA2: String;
    fAREA3: String;
    fAREA1: String;
    fAREAFAX: String;
    fFonesCampanha: TObjectList<TFonesCampanha>;
    fSEGMENTO: Integer;
    fCOD_MIDIA: Integer;
    fGRUPO: Integer;
    fSALDO_DISPONIVEL: Double;
    fPOTENCIAL: Double;
    fSALDO_LIMITE: Double;
    fDATA_ULT_COMPRA: TDate;
    fCOMPRADisplay: String;
    function getFANTASIA: String;
    function GetRAZAO: String;
    function GetPESSOA: String;
    function GetOBS_OPERADOR: String;
    function GetOBS_ADMIN: String;
    function GetDESC_FONE1: String;

    function GetDESC_FONE2: String;
    function GetDESC_FONE3: String;
    function GetDESCFAX: String;
    function GetBAIRRO: String;
    function GetCEP: String;
    function GetCIDADE: String;
    function GetCOMPLEMENTO: String;
    function GetEND_RUA: String;
    function GetESTADO: String;
    function GetCONTATO_MAIL: String;

    function GetEMAIL: String;
    function GetWEBSITE: String;
    function GetDadosLigacao: TDadosLigacao; protected
    function Getid: Integer;
    procedure Setid(const Value: Integer);
  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read Getid write Setid;

    [Column('RAZAO', ftString, 100)]
    [Dictionary('RAZAO','Mensagem de validação','','','',taLeftJustify)]
    property RAZAO: String read GetRAZAO write FRAZAO;

    [Column('FANTASIA', ftString, 60)]
    property FANTASIA:String read getFANTASIA write FFANTASIA;

    [Column('PESSOA', ftString, 3)]
    property PESSOA:String read GetPESSOA write fPESSOA;

    [Column('ATIVO', ftString, 3)]
    property Ativo:String read fAtivo write fAtivo;

    [Column('CPF_CNPJ', ftString, 16)]
    property CPF_CNPJ:String read fCPF_CNPJ write fCPF_CNPJ;

    [Column('IE_RG', ftString, 20)]
    property IE_RG:String read fIE_RG write fIE_RG;

    [Column('COD_ERP', ftInteger, 10)]
    property COD_ERP:Integer read fCOD_ERP write fCOD_ERP;

    [Column('OPERADOR', ftInteger, 10)]
    property OPERADOR:Integer read fOPERADOR write fOPERADOR;

    [Column('OBS_OPERADOR', ftString, 255)]
    property OBS_OPERADOR:String read GetOBS_OPERADOR write fOBS_OPERADOR;

    [Column('OBS_ADMIN', ftString, 255)]
    property OBS_ADMIN:String read GetOBS_ADMIN write fOBS_ADMIN;

    [Column('DATACAD', ftDateTime)]
    property DATACAD:TDateTime read fDATACAD write fDATACAD;

    [Column('FONE1', ftString, 12)]
    property FONE1:String read fFONE1 write fFONE1;
    [Column('FONE2', ftString, 12)]
    property FONE2:String read fFONE2 write fFONE2;
    [Column('FONE3', ftString, 12)]
    property FONE3:String read fFONE3 write fFONE3;
    [Column('FAX', ftString, 12)]
    property FAX:String read fFAX write fFAX;

    [Column('DESC_FONE1', ftString, 30)]
    property DESC_FONE1:String read GetDESC_FONE1 write fDESC_FONE1;
    [Column('DESC_FONE2', ftString, 30)]
    property DESC_FONE2:String read GetDESC_FONE2 write fDESC_FONE2;
    [Column('DESC_FONE3', ftString, 30)]
    property DESC_FONE3:String read GetDESC_FONE3 write fDESC_FONE3;
    [Column('DESCFAX', ftString, 30)]
    property DESCFAX:String read GetDESCFAX write fDESCFAX;

    [Column('AREA1', ftInteger)]
    property AREA1:String read fAREA1 write fAREA1;
    [Column('AREA2', ftInteger)]
    property AREA2:String read fAREA2 write fAREA2;
    [Column('AREA3', ftInteger)]
    property AREA3:String read fAREA3 write fAREA3;
    [Column('AREAFAX', ftInteger)]
    property AREAFAX:String read fAREAFAX write fAREAFAX;

    [Column('END_RUA', ftString, 100)]
    property END_RUA:String read GetEND_RUA write fEND_RUA;
    [Column('CIDADE', ftString, 60)]
    property CIDADE:String read GetCIDADE write fCIDADE;
    [Column('BAIRRO', ftString, 60)]
    property BAIRRO:String read GetBAIRRO write fBAIRRO;
    [Column('ESTADO', ftString, 2)]
    property ESTADO:String read GetESTADO write fESTADO;
    [Column('CEP', ftString, 15)]
    property CEP:String read GetCEP write fCEP;
    [Column('COMPLEMENTO', ftString, 100)]
    property COMPLEMENTO:String read GetCOMPLEMENTO write fCOMPLEMENTO;

    [Column('CONTATO_MAIL', ftString)]
    property CONTATO_MAIL:String read GetCONTATO_MAIL write fCONTATO_MAIL;

    [Column('WEBSITE', ftString)]
    property WEBSITE:String read GetWEBSITE write fWEBSITE;
    [Column('EMAIL', ftString)]
    property EMAIL:String read GetEMAIL write fEMAIL;

    [Column('SALDO_DISPONIVEL', ftFloat)]
    property SALDO_DISPONIVEL:Double read fSALDO_DISPONIVEL write fSALDO_DISPONIVEL;
    [Column('POTENCIAL', ftFloat)]
    property POTENCIAL:Double read fPOTENCIAL write fPOTENCIAL;
    [Column('SALDO_LIMITE', ftFloat)]
    property SALDO_LIMITE:Double read fSALDO_LIMITE write fSALDO_LIMITE;
    [Column('DATA_ULT_COMPRA', ftDate)]
    property DATA_ULT_COMPRA:TDate read fDATA_ULT_COMPRA write fDATA_ULT_COMPRA;

    property COMPRADisplay:String read fCOMPRADisplay write fCOMPRADisplay;

    [Column('GRUPO', ftInteger)]
    property GRUPO:Integer read fGRUPO write fGRUPO;

    [Column('COD_MIDIA', ftInteger)]
    property COD_MIDIA:Integer read fCOD_MIDIA write fCOD_MIDIA;

    [Column('SEGMENTO', ftInteger)]
    property SEGMENTO:Integer read fSEGMENTO write fSEGMENTO;

    property DadosLigacao: TDadosLigacao read GetDadosLigacao write fDadosLigacao;

    property Contatos: TObjectList<TContatos> read fContatos write fContatos;

    property FonesCampanha: TObjectList<TFonesCampanha> read fFonesCampanha write fFonesCampanha;
  end;

implementation


{ TClientes }

uses Infotec.Utils;

constructor TClientes.create;
begin
  FDadosLigacao := TDadosLigacao.Create;
  FContatos := TObjectList<TContatos>.Create;
  FFonesCampanha:= TObjectList<TFonesCampanha>.Create;
end;

destructor TClientes.destroy;
begin
  FreeAndNil(fDadosLigacao);
  FreeAndNil(FContatos);
  FreeAndNil(FFonesCampanha);
  inherited;
end;

function TClientes.GetBAIRRO: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fBAIRRO);
end;

function TClientes.GetCEP: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fCEP);
end;

function TClientes.GetCIDADE: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fCIDADE);
end;

function TClientes.GetCOMPLEMENTO: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fCOMPLEMENTO);
end;

function TClientes.GetCONTATO_MAIL: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fCONTATO_MAIL);
end;

function TClientes.GetDadosLigacao: TDadosLigacao;
begin
  Result := fDadosLigacao;
  Result.CAMPANHA := TInfotecUtils.RemoverEspasDuplas(Result.CAMPANHA);
  Result.CARTEIRA := TInfotecUtils.RemoverEspasDuplas(Result.CARTEIRA);
  Result.GRUPO := TInfotecUtils.RemoverEspasDuplas(Result.GRUPO);
  Result.ORIGEM := TInfotecUtils.RemoverEspasDuplas(Result.ORIGEM);
  Result.MIDIA := TInfotecUtils.RemoverEspasDuplas(Result.MIDIA);
  Result.SEGMENTO := TInfotecUtils.RemoverEspasDuplas(Result.SEGMENTO);
  Result.NOME_OPERADOR := TInfotecUtils.RemoverEspasDuplas(Result.NOME_OPERADOR);
  Result.ASSINATURA := TInfotecUtils.RemoverEspasDuplas(Result.ASSINATURA);
  Result.NOME_CONTATO := TInfotecUtils.RemoverEspasDuplas(Result.NOME_CONTATO);
  Result.EMAIL := TInfotecUtils.RemoverEspasDuplas(Result.EMAIL);
  Result.CONTATO_MAIL := TInfotecUtils.RemoverEspasDuplas(Result.CONTATO_MAIL);
end;

function TClientes.GetDESCFAX: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fDESCFAX);
end;

function TClientes.GetDESC_FONE1: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fDESC_FONE1);
end;

function TClientes.GetDESC_FONE2: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fDESC_FONE2);
end;

function TClientes.GetDESC_FONE3: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fDESC_FONE3);
end;

function TClientes.GetEMAIL: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fEMAIL);
end;

function TClientes.GetEND_RUA: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fEND_RUA);
end;

function TClientes.GetESTADO: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fESTADO);
end;

function TClientes.getFANTASIA: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(FFANTASIA);

  if Result = EmptyStr then
    Result := TInfotecUtils.RemoverEspasDuplas(FRAZAO);
end;

function TClientes.Getid: Integer;
begin
 Result := fid;
end;

function TClientes.GetOBS_ADMIN: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fOBS_ADMIN);
end;

function TClientes.GetOBS_OPERADOR: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fOBS_OPERADOR);
end;

function TClientes.GetPESSOA: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fPESSOA);
end;

function TClientes.GetRAZAO: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(FRAZAO);
end;

function TClientes.GetWEBSITE: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fWEBSITE);
end;

procedure TClientes.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TClientes);

end.

