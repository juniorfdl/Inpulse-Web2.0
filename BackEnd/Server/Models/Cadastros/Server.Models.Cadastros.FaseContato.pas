unit Server.Models.Cadastros.FaseContato;
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
  [Table('FASE_CONTATO','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TFaseContato = class(TTabelaBase)
  private
    fNOME: String;
    fEXIGE_OBSERVACAO: String;
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

    [Column('NOME', ftString, 50)]
    [Dictionary('NOME','Mensagem de validação','','','',taLeftJustify)]
    property NOME: String read fNOME write GetNOME;

    [Column('EXIGE_OBSERVACAO', ftString, 1)]
    [Dictionary('EXIGE_OBSERVACAO','Mensagem de validação','','','',taLeftJustify)]
    property EXIGE_OBSERVACAO:String read fEXIGE_OBSERVACAO write fEXIGE_OBSERVACAO;
  end;

implementation


{ TFaseContato }

uses Infotec.Utils;

constructor TFaseContato.create;
begin
end;

destructor TFaseContato.destroy;
begin
  inherited;
end;

function TFaseContato.Getid: Integer;
begin
  Result := fid;
end;

procedure TFaseContato.GetNOME(const Value: String);
begin
  fNOME := TInfotecUtils.RemoverEspasDuplas(Value);
end;

procedure TFaseContato.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TFaseContato);

end.

