unit Server.Models.Cadastros.ClientesGravar;

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
  [Entity]
  [Table('CLIENTES','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TClientesGravar = class(TTabelaBase)
  private
    fCPF_CNPJ: String;
    FFANTASIA: String;
    fPESSOA: String;
    fAtivo: String;
    FRAZAO: String;
    fIE_RG: String;
    fCOD_ERP: string;
    fDataBase: String;
    //fid: Integer;
    fOPERADOR: Integer;
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
    fAREA2: integer;
    fAREA3: integer;
    fAREA1: integer;
    fAREAFAX: integer;
    fSEGMENTO: Integer;
    fCOD_MIDIA: Integer;
    fGRUPO: Integer;
    FCOD_CAMPANHA: integer;
    FCOD_UNIDADE: integer;
    { Private declarations }
  protected
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
    property RAZAO: String read FRAZAO write FRAZAO;

    [Column('FANTASIA', ftString, 3)]
    property FANTASIA:String read FFANTASIA write FFANTASIA;

    [Column('PESSOA', ftString, 3)]
    property PESSOA:String read fPESSOA write fPESSOA;

    [Column('ATIVO', ftString, 3)]
    property Ativo:String read fAtivo write fAtivo;

    [Column('CPF_CNPJ', ftString, 16)]
    property CPF_CNPJ:String read fCPF_CNPJ write fCPF_CNPJ;

    [Column('IE_RG', ftString, 20)]
    property IE_RG:String read fIE_RG write fIE_RG;

    [Column('COD_ERP', ftString, 10)]
    property COD_ERP:string read fCOD_ERP write fCOD_ERP;

    [Column('OPERADOR', ftInteger, 10)]
    property OPERADOR:Integer read fOPERADOR write fOPERADOR;

    [Column('OBS_OPERADOR', ftString, 255)]
    property OBS_OPERADOR:String read fOBS_OPERADOR write fOBS_OPERADOR;

    [Column('OBS_ADMIN', ftString, 255)]
    property OBS_ADMIN:String read fOBS_ADMIN write fOBS_ADMIN;

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
    property DESC_FONE1:String read fDESC_FONE1 write fDESC_FONE1;
    [Column('DESC_FONE2', ftString, 30)]
    property DESC_FONE2:String read fDESC_FONE2 write fDESC_FONE2;
    [Column('DESC_FONE3', ftString, 30)]
    property DESC_FONE3:String read fDESC_FONE3 write fDESC_FONE3;
    [Column('DESCFAX', ftString, 30)]
    property DESCFAX:String read fDESCFAX write fDESCFAX;

    [Column('AREA1', ftInteger)]
    property AREA1:integer read fAREA1 write fAREA1;
    [Column('AREA2', ftInteger)]
    property AREA2:integer read fAREA2 write fAREA2;
    [Column('AREA3', ftInteger)]
    property AREA3:integer read fAREA3 write fAREA3;
    [Column('AREAFAX', ftInteger)]
    property AREAFAX:integer read fAREAFAX write fAREAFAX;

    [Column('END_RUA', ftString, 100)]
    property END_RUA:String read fEND_RUA write fEND_RUA;
    [Column('CIDADE', ftString, 60)]
    property CIDADE:String read fCIDADE write fCIDADE;
    [Column('BAIRRO', ftString, 60)]
    property BAIRRO:String read fBAIRRO write fBAIRRO;
    [Column('ESTADO', ftString, 2)]
    property ESTADO:String read fESTADO write fESTADO;
    [Column('CEP', ftString, 15)]
    property CEP:String read fCEP write fCEP;
    [Column('COMPLEMENTO', ftString, 100)]
    property COMPLEMENTO:String read fCOMPLEMENTO write fCOMPLEMENTO;

    [Column('CONTATO_MAIL', ftString)]
    property CONTATO_MAIL:String read fCONTATO_MAIL write fCONTATO_MAIL;

    [Column('WEBSITE', ftString)]
    property WEBSITE:String read fWEBSITE write fWEBSITE;
    [Column('EMAIL', ftString)]
    property EMAIL:String read fEMAIL write fEMAIL;

    [Column('GRUPO', ftInteger)]
    property GRUPO:Integer read fGRUPO write fGRUPO;

    [Column('COD_MIDIA', ftInteger)]
    property COD_MIDIA:Integer read fCOD_MIDIA write fCOD_MIDIA;

    [Column('SEGMENTO', ftInteger)]
    property SEGMENTO:Integer read fSEGMENTO write fSEGMENTO;

    [Column('COD_CAMPANHA', ftInteger)]
    property COD_CAMPANHA:Integer read FCOD_CAMPANHA write FCOD_CAMPANHA;

    [Column('COD_UNIDADE', ftInteger)]
    property COD_UNIDADE:Integer read FCOD_UNIDADE write FCOD_UNIDADE;
  end;

implementation

{ TClientesGravar }

constructor TClientesGravar.create;
begin

end;

destructor TClientesGravar.destroy;
begin

  inherited;
end;

function TClientesGravar.Getid: Integer;
begin
  Result := fid;
end;

procedure TClientesGravar.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TClientesGravar);

end.
