unit Server.Models.Cadastros.Operadores;

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
  dbcbr.mapping.register, Server.Models.Base.TabelaBase,
  Inpulse.SIP.Models.Resgistrar;

type
  [Entity]
  [Table('OPERADORES','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TOperadores = class(TTabelaBase)
  private
    { Private declarations }
    fAtivo: String;
    fSenha: String;
    fLogin: String;
    FNOME: String;
    fCAMINHO_DATABASE: String;
    fRegistrar: TRegistrar;
    //fid: Integer;
    fCODIGOENTRADA: String;
    fid: Integer;

    procedure GetNOME(const Value: String);//    fid: Integer;
//    function Getid: Integer;
//    procedure Setid(const Value: Integer);
  public
    constructor create;
    destructor destroy; override;
    { Public declarations }

    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO','','','','',taCenter)]
    property id: Integer read fid write fid;

    [Column('NOME', ftString, 255)]
    [Dictionary('USUAA60LOGIN','Mensagem de validação','','','',taLeftJustify)]
    property NOME: String read FNOME write GetNOME;

    [Column('LOGIN', ftString, 255)]
    property LOGIN:String read fLogin write fLogin;

    [Column('SENHA', ftString, 255)]
    property Senha:String read fSenha write fSenha;

    [Column('ATIVO', ftString, 255)]
    property Ativo:String read fAtivo write fAtivo;

    [Column('CAMINHO_DATABASE', ftString, 255)]
    property CAMINHO_DATABASE:String read fCAMINHO_DATABASE write fCAMINHO_DATABASE;

    property Registrar: TRegistrar read fRegistrar write fRegistrar;

    property CODIGOENTRADA:String read fCODIGOENTRADA write fCODIGOENTRADA;
  end;

implementation


{ TOperadores }

uses Infotec.Utils;

constructor TOperadores.create;
begin
  Registrar := TRegistrar.Create;
end;

destructor TOperadores.destroy;
begin
  Registrar.Free;
  inherited;
end;

procedure TOperadores.GetNOME(const Value: String);
begin
  FNOME := TInfotecUtils.RemoverEspasDuplas(Value);
end;

//function TOperadores.Getid: Integer;
//begin
// Result := fid;
//end;

//procedure TOperadores.Setid(const Value: Integer);
//begin
//  fid := Value;
//end;

initialization
  TRegisterClass.RegisterEntity(TOperadores);

end.

