unit Server.Models.Cadastros.Grupos;


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
  [Table('GRUPOS','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TGrupos = class(TTabelaBase)
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

    [Column('DESCRICAO', ftString, 35)]
    [Dictionary('DESCRICAO','Mensagem de validação','','','',taLeftJustify)]
    property DESCRICAO: String read fDESCRICAO write GetDESCRICAO;
  end;

implementation


{ TGrupos }

uses Infotec.Utils;

constructor TGrupos.create;
begin
end;

destructor TGrupos.destroy;
begin
  inherited;
end;

procedure TGrupos.GetDESCRICAO(const Value: String);
begin
  fDESCRICAO := TInfotecUtils.RemoverEspasDuplas(Value);
end;

function TGrupos.Getid: Integer;
begin
  Result := fid;
end;

procedure TGrupos.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TGrupos);

end.

