unit Server.Models.Cadastros.Cargos;

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
  [Table('CARGOS','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TCargos = class(TTabelaBase)
  private
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
    [Dictionary('DESCRICAO','Mensagem de validação','','','',taLeftJustify)]
    property DESCRICAO: String read fDESCRICAO write GetDESCRICAO;
  end;

implementation


{ TCargos }

uses Infotec.Utils;

constructor TCargos.create;
begin
end;

destructor TCargos.destroy;
begin
  inherited;
end;

procedure TCargos.GetDESCRICAO(const Value: String);
begin
  fDESCRICAO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

function TCargos.Getid: Integer;
begin
  Result := fid;
end;

procedure TCargos.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TCargos);

end.

