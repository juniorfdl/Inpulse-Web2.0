unit Server.Models.Cadastros.Segmentos;

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
  [Table('SEGMENTOS','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TSegmentos = class(TTabelaBase)
  private
    fNOME: String;
    function Getid: Integer;
    procedure Setid(const Value: Integer);
    procedure GetNOME(const Value: String);
  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read Getid write Setid;

    [Column('NOME', ftString, 35)]
    [Dictionary('NOME','Mensagem de validação','','','',taLeftJustify)]
    property NOME: String read fNOME write GetNOME;
  end;

implementation


{ TSegmentos }

uses Infotec.Utils;

constructor TSegmentos.create;
begin
end;

destructor TSegmentos.destroy;
begin
  inherited;
end;

function TSegmentos.Getid: Integer;
begin
  Result := fid;
end;

procedure TSegmentos.GetNOME(const Value: String);
begin
  fNOME := TInfotecUtils.RemoverEspasDuplas(Value);
end;

procedure TSegmentos.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TSegmentos);

end.

