unit Server.Models.Cadastros.Resultados;

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
  [Table('RESULTADOS','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TResultados = class(TTabelaBase)
  private
    fNOME: String;
    fPROPOSTA: String;
    fCOD_ACAO: Integer;
    fDESCRICAO_ACAO: String;
    fECONTATO: String;
    fFIDELIZARCOTACAO: String;
    fQTDE_FIDELIZARCOTACAO: Integer;
    fPRIORIDADE: String;
    fEVENDA: String;
    function Getid: Integer;
    procedure Setid(const Value: Integer);
    procedure GetNOME(const Value: String);
    procedure GetDESCRICAO_ACAO(const Value: String);
  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read Getid write Setid;

    [Column('NOME', ftString, 50)]
    [Dictionary('NOME','Mensagem de validação','','','',taLeftJustify)]
    property NOME: String read fNOME write GetNOME;

    [Column('PROPOSTA', ftString, 3)]
    property PROPOSTA: String read fPROPOSTA write fPROPOSTA;
    [Column('ECONTATO', ftString, 3)]
    property ECONTATO: String read fECONTATO write fECONTATO;
    [Column('FIDELIZARCOTACAO', ftString, 3)]
    property FIDELIZARCOTACAO: String read fFIDELIZARCOTACAO write fFIDELIZARCOTACAO;

    [Column('PRIORIDADE', ftString, 3)]
    property PRIORIDADE: String read fPRIORIDADE write fPRIORIDADE;

    [Column('QTDE_FIDELIZARCOTACAO', ftInteger)]
    property QTDE_FIDELIZARCOTACAO: Integer read fQTDE_FIDELIZARCOTACAO write fQTDE_FIDELIZARCOTACAO;

    [Column('COD_ACAO', ftInteger)]
    property COD_ACAO: Integer read fCOD_ACAO write fCOD_ACAO;

    [Column('EVENDA', ftString)]
    property EVENDA: String read fEVENDA write fEVENDA;

    property DESCRICAO_ACAO: String read fDESCRICAO_ACAO write GetDESCRICAO_ACAO;
  end;

implementation


{ TResultados }

uses Infotec.Utils;

constructor TResultados.create;
begin
end;

destructor TResultados.destroy;
begin
  inherited;
end;

procedure TResultados.GetDESCRICAO_ACAO(const Value: String);
begin
  fDESCRICAO_ACAO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

function TResultados.Getid: Integer;
begin
  Result := fid;
end;

procedure TResultados.GetNOME(const Value: String);
begin
  fNOME := TInfotecUtils.RemoverEspasDuplas(Value);
end;

procedure TResultados.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TResultados);

end.

