unit Server.Models.Cadastros.Cidades;

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
  [Table('CIDADES','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TCidades = class(TTabelaBase)
  private
    fNOME: String;
    fORDEM: String;
    fUF: String;
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

    [Column('NOME', ftString, 100)]
    [Dictionary('NOME','Mensagem de validação','','','',taLeftJustify)]
    property NOME: String read fNOME write fNOME;

    [Column('ORDEM', ftInteger)]
    property ORDEM:String read fORDEM write fORDEM;

    [Column('UF', ftString, 150)]
    property UF:String read fUF write fUF;
  end;

implementation


{ TCidades }

constructor TCidades.create;
begin
end;

destructor TCidades.destroy;
begin
  inherited;
end;

function TCidades.Getid: Integer;
begin
  Result := fid;
end;

procedure TCidades.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TCidades);

end.

