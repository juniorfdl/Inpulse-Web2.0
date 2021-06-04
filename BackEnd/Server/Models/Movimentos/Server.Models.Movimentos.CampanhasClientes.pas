unit Server.Models.Movimentos.CampanhasClientes;

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
  Server.Models.Base.TabelaBase;

type
  [Entity]
  [Table('campanhas_clientes','')]
  [PrimaryKey('CODIGO', TableInc, NoSort, False, 'Chave primária')]
  TCampanhasClientes = class(TTabelaBase)
  private
    fMANUAL: String;
    fTELEFONE_LIGADO: String;
    fDESC_FONE2: String;
    fDESC_FONE3: String;
    fFIDELIZA: String;
    fDESC_FONE1: String;
    fCampanha: Integer;
    fCliente: Integer;
    fCONCLUIDO: String;
    fOPERADOR: Integer;
    fDT_AGENDAMENTO: TDateTime;
    fDT_RESULTADO: String;
    fFONE2: String;
    fFONE3: String;
    fRESULTADO: Integer;
    fFONE1: String;
    fOPERADOR_LIGACAO: Integer;
    fORDEM: Integer;
    fAGENDA: Integer;
    fDATA_HORA_FIM: TDateTime;
    fDATA_HORA_LIG: TDateTime;
    function Getid: Integer;
    procedure Setid(const Value: Integer);
    { Private declarations }
//    function Getid: Integer;
//    procedure Setid(const Value: Integer);
  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read Getid write Setid;

    [Column('CLIENTE', ftInteger)]
    property Cliente: Integer read fCliente write fCliente;

    [Column('CAMPANHA', ftInteger)]
    property Campanha: Integer read fCampanha write fCampanha;

    [Column('DT_RESULTADO', ftString)]
    property DT_RESULTADO: String read fDT_RESULTADO write fDT_RESULTADO;

    [Column('DT_AGENDAMENTO', ftDateTime)]
    property DT_AGENDAMENTO: TDateTime read fDT_AGENDAMENTO write fDT_AGENDAMENTO;

    [Column('RESULTADO', ftInteger)]
    property RESULTADO: Integer read fRESULTADO write fRESULTADO;

    [Column('CONCLUIDO', ftString)]
    property CONCLUIDO: String read fCONCLUIDO write fCONCLUIDO;

    [Column('FONE1', ftString)]
    property FONE1: String read fFONE1 write fFONE1;

    [Column('FONE2', ftString)]
    property FONE2: String read fFONE2 write fFONE2;

    [Column('FONE3', ftString)]
    property FONE3: String read fFONE3 write fFONE3;

    [Column('ORDEM', ftInteger)]
    property ORDEM: Integer read fORDEM write fORDEM;

    [Column('OPERADOR', ftInteger)]
    property OPERADOR: Integer read fOPERADOR write fOPERADOR;

    [Column('OPERADOR_LIGACAO', ftInteger)]
    property OPERADOR_LIGACAO: Integer read fOPERADOR_LIGACAO write fOPERADOR_LIGACAO;

    [Column('DATA_HORA_LIG', ftDateTime)]
    property DATA_HORA_LIG: TDateTime read fDATA_HORA_LIG write fDATA_HORA_LIG;

    [Column('TELEFONE_LIGADO', ftString)]
    property TELEFONE_LIGADO: String read fTELEFONE_LIGADO write fTELEFONE_LIGADO;

    [Column('DATA_HORA_FIM', ftDateTime)]
    property DATA_HORA_FIM: TDateTime read fDATA_HORA_FIM write fDATA_HORA_FIM;

    [Column('AGENDA', ftInteger)]
    property AGENDA: Integer read fAGENDA write fAGENDA;

    [Column('DESC_FONE1', ftString)]
    property DESC_FONE1: String read fDESC_FONE1 write fDESC_FONE1;

    [Column('DESC_FONE2', ftString)]
    property DESC_FONE2: String read fDESC_FONE2 write fDESC_FONE2;

    [Column('DESC_FONE3', ftString)]
    property DESC_FONE3: String read fDESC_FONE3 write fDESC_FONE3;

    [Column('FIDELIZA', ftString)]
    property FIDELIZA: String read fFIDELIZA write fFIDELIZA;

    [Column('MANUAL', ftString)]
    property MANUAL: String read fMANUAL write fMANUAL;
  end;

implementation


{ TCampanhasClientes }

constructor TCampanhasClientes.create;
begin
 //
end;

destructor TCampanhasClientes.destroy;
begin
  //
  inherited;
end;

function TCampanhasClientes.Getid: Integer;
begin
  Result := fid;
end;

procedure TCampanhasClientes.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TCampanhasClientes);

end.

