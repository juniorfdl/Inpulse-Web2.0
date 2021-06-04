unit Server.Models.Cadastros.MotivosPausa;

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
  [Table('MOTIVOS_PAUSA','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TMotivosPausa = class(TTabelaBase)
  private
    fTEMPO_MAX_SEG: Integer;
    fDESCRICAO: String;
    function Getid: Integer;
    procedure Setid(const Value: Integer);
    procedure GetDESCRICAO(const Value: String);
  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read Getid write Setid;

    [Column('DESCRICAO', ftString, 50)]
    property DESCRICAO: String read fDESCRICAO write GetDESCRICAO;

    [Column('TEMPO_MAX_SEG', ftInteger)]
    property TEMPO_MAX_SEG: Integer read fTEMPO_MAX_SEG write fTEMPO_MAX_SEG;
  end;

implementation


{ TMotivosPausa }

uses Infotec.Utils;

constructor TMotivosPausa.create;
begin
end;

destructor TMotivosPausa.destroy;
begin
  inherited;
end;

procedure TMotivosPausa.GetDESCRICAO(const Value: String);
begin
  fDESCRICAO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

function TMotivosPausa.Getid: Integer;
begin
  Result := fid;
end;

procedure TMotivosPausa.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TMotivosPausa);

end.

