unit Server.Models.Cadastros.PausasRealizadas;

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
  [Table('PAUSAS_REALIZADAS','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TPausasRealizadas = class(TTabelaBase)
  private
    fOBS: String;
    fEXCEDEU: String;
    fTEMPO_EXEDIDO: TTime;
    fCOD_PAUSA: Integer;
    fOPERADOR: Integer;
    fDATA_HORA: TDateTime;
    fTIPO: String;
    fDATA_HORA_FIM: TDateTime;
    fDataInicioPausa: Double;
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

    [Column('OPERADOR', ftInteger)]
    property OPERADOR: Integer read fOPERADOR write fOPERADOR;

    [Column('OBS', ftString, 50)]
    property OBS: String read fOBS write fOBS;

    [Column('COD_PAUSA', ftinteger)]
    property COD_PAUSA: Integer read fCOD_PAUSA write fCOD_PAUSA;

    [Column('EXCEDEU', ftString, 3)]
    property EXCEDEU: String read fEXCEDEU write fEXCEDEU;

    [Column('TIPO', ftString, 5)]
    property TIPO: String read fTIPO write fTIPO;

    [Column('TEMPO_EXEDIDO', ftTime)]
    property TEMPO_EXEDIDO: TTime read fTEMPO_EXEDIDO write fTEMPO_EXEDIDO;

    [Column('DATA_HORA', ftDateTime)]
    property DATA_HORA: TDateTime read fDATA_HORA write fDATA_HORA;

    [Column('DATA_HORA_FIM', ftDateTime)]
    property DATA_HORA_FIM: TDateTime read fDATA_HORA_FIM write fDATA_HORA_FIM;

    property DataInicioPausa: Double read fDataInicioPausa write fDataInicioPausa;
  end;

implementation


{ TPausasRealizadas }

constructor TPausasRealizadas.create;
begin
end;

destructor TPausasRealizadas.destroy;
begin
  inherited;
end;

function TPausasRealizadas.Getid: Integer;
begin
  Result := fid;
end;

procedure TPausasRealizadas.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TPausasRealizadas);

end.

