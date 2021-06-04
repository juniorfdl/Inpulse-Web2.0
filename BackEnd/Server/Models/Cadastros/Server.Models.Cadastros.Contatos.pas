unit Server.Models.Cadastros.Contatos;

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
  [Table('CONTATOS','')]
  [PrimaryKey('CODIGO', NotInc, NoSort, False, 'Chave primária')]
  TContatos = class(TTabelaBase)
  private
    fEMAIL: String;
    fCARGO: Integer;
    fNOME: String;
    fAREA_DIRETO: String;
    fAREA_CEL: String;
    fFONE_DIRETO: String;
    fFONE_RESIDENCIAL: String;
    fCLIENTE: Integer;
    fTIME_FUTEBOL: String;
    fAREA_RESI: String;
    fANIVERSARIO: TDate;
    fFILHOS: Integer;
    fSEXO: String;
    fTRATAMENTO: String;
    fCELULAR: String;
    fCARGO_DESCRICAO: String;
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

    [Column('CARGO', ftInteger)]
    property CARGO:Integer read fCARGO write fCARGO;

    [Column('EMAIL', ftString, 150)]
    property EMAIL:String read fEMAIL write fEMAIL;

    [Column('AREA_DIRETO', ftString, 5)]
    property AREA_DIRETO:String read fAREA_DIRETO write fAREA_DIRETO;

    [Column('AREA_CEL', ftString, 5)]
    property AREA_CEL:String read fAREA_CEL write fAREA_CEL;

    [Column('AREA_RESI', ftString, 5)]
    property AREA_RESI:String read fAREA_RESI write fAREA_RESI;

    [Column('FONE_DIRETO', ftString, 10)]
    property FONE_DIRETO:String read fFONE_DIRETO write fFONE_DIRETO;

    [Column('CELULAR', ftString, 10)]
    property CELULAR:String read fCELULAR write fCELULAR;

    [Column('FONE_RESIDENCIAL', ftString, 10)]
    property FONE_RESIDENCIAL:String read fFONE_RESIDENCIAL write fFONE_RESIDENCIAL;

    [Column('ANIVERSARIO', ftDate)]
    property ANIVERSARIO:TDate read fANIVERSARIO write fANIVERSARIO;

    [Column('TIME_FUTEBOL', ftString, 80)]
    property TIME_FUTEBOL:String read fTIME_FUTEBOL write fTIME_FUTEBOL;

    [Column('SEXO', ftString, 1)]
    property SEXO:String read fSEXO write fSEXO;

    [Column('FILHOS', ftInteger)]
    property FILHOS:Integer read fFILHOS write fFILHOS;

    [Column('CLIENTE', ftInteger)]
    property CLIENTE:Integer read fCLIENTE write fCLIENTE;

    [Column('TRATAMENTO', ftString, 50)]
    property TRATAMENTO:String read fTRATAMENTO write fTRATAMENTO;

    property CARGO_DESCRICAO:String read fCARGO_DESCRICAO write fCARGO_DESCRICAO;
  end;

implementation


{ TCONTATOS }

constructor TContatos.create;
begin
end;

destructor TContatos.destroy;
begin
  inherited;
end;

function TContatos.Getid: Integer;
begin
  Result := fid;
end;

procedure TContatos.Setid(const Value: Integer);
begin
  fid := Value;
end;

initialization
  TRegisterClass.RegisterEntity(TContatos);

end.

