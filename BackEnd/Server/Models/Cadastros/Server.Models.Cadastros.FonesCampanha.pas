unit Server.Models.Cadastros.FonesCampanha;

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
  [Table('FONES_CAMPANHA_CLI','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TFonesCampanha = Class(TTabelaBase)
  private
    fCLIENTE: Integer;
    fFONE: String;
    fTIPO_FONE: string;
    function Getid: Integer;
    procedure Setid(const Value: Integer);
  public
    { Public declarations }
    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read Getid write Setid;

    [Column('CLIENTE', ftInteger)]
    property CLIENTE: Integer read fCLIENTE write fCLIENTE;

    [Column('FONE', ftInteger)]
    property TELEFONE: String read fFONE write fFONE;

    [Column('TIPO_FONE', ftInteger)]
    property TIPO_FONE: string read fTIPO_FONE write fTIPO_FONE;

  End;

implementation

{ TFonesCampanha }


{ TFonesCampanha }

function TFonesCampanha.Getid: Integer;
begin
  Result := fid;
end;

procedure TFonesCampanha.Setid(const Value: Integer);
begin
  fid := Value;
end;

end.
