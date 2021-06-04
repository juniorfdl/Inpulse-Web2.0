unit Server.Models.Cadastros.Campanhas;

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
  [Table('campanhas','')]
  [PrimaryKey('CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  TCampanhas = class(TTabelaBase)
  private
    FNome: String;

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

    [Column('NOME', ftString)]
    property Nome: string read Fnome write FNome;

  end;

implementation


{ TCampanhas }

constructor TCampanhas.create;
begin
 //
end;

destructor TCampanhas.destroy;
begin
  //
  inherited;
end;

function TCampanhas.Getid: Integer;
begin
  Result := fid;
end;

procedure TCampanhas.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TCampanhas);

end.

