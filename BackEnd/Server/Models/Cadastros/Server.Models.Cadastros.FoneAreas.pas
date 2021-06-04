unit Server.Models.Cadastros.FoneAreas;

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
  [Table('fone_areas','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TFoneAreas = class(TTabelaBase)
  private
    fid: String;
    fDESCRICAO: String;
    fArea: String;
    function Getid: String;
    procedure Setid(const Value: String);
    procedure GetDESCRICAO(const Value: String);
  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([Unique])]
    [Column('CODIGO', ftString, 5)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: String read Getid write Setid;

    [Column('DESCRICAO', ftString, 3)]
    property DESCRICAO: String read fDESCRICAO write GetDESCRICAO;

    property Area: String read fArea write fArea;
  end;

implementation


{ TFoneAreas }

uses Infotec.Utils;

constructor TFoneAreas.create;
begin
end;

destructor TFoneAreas.destroy;
begin
  inherited;
end;

procedure TFoneAreas.GetDESCRICAO(const Value: String);
begin
  fDESCRICAO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

function TFoneAreas.Getid: String;
begin
  Result := fid;
end;

procedure TFoneAreas.Setid(const Value: String);
begin
  fid := Value;
  fArea := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TFoneAreas);

end.

