unit Server.Models.Cadastros.Unidades;

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
  [Table('unidades','')]
  [PrimaryKey('CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  Tunidades = class(TTabelaBase)
  private
    FDescricao: String;

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

    [Column('DESCRICAO', ftString)]
    property Descricao: string read FDescricao write FDescricao;

  end;

implementation


{ TCampanhas }

constructor Tunidades.create;
begin
 //
end;

destructor Tunidades.destroy;
begin
  //
  inherited;
end;

function Tunidades.Getid: Integer;
begin
  Result := fid;
end;

procedure Tunidades.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(Tunidades);

end.

