unit Server.Models.Base.Consulta;

interface

uses
  //Classes,
  Generics.Collections;

Type
  TConsultaWhere = class
  private
    fValor: String;
    fCampo: String;
    fCondicao: String;
    fSinal: String;
    function GetSinal: String;
    function GetCondicao: String;
  public
    property Campo:String read fCampo write fCampo;
    property Valor:String read fValor write fValor;
    property Condicao:String read GetCondicao write fCondicao;
    property Sinal:String read GetSinal write fSinal;
  end;

  TConsulta = class
  private
    fWhere: TObjectList<TConsultaWhere>;
    fDataBase: String;
  public
    property Where: TObjectList<TConsultaWhere> read fWhere write fWhere;
    property DataBase:String read fDataBase write fDataBase;
    constructor create;
    destructor destroy; override;
  end;

implementation

{ TConsulta }

constructor TConsulta.create;
begin
  Where := TObjectList<TConsultaWhere>.Create;
end;

destructor TConsulta.destroy;
begin
  Where.Free;
  inherited;
end;

{ TConsultaWhere }

function TConsultaWhere.GetCondicao: String;
begin
  Result := fCondicao;

  if Result = '' then
    Result := ' = ';
end;

function TConsultaWhere.GetSinal: String;
begin
  Result := fSinal;

  if Result = '' then
    Result := ' AND ';
end;

end.
