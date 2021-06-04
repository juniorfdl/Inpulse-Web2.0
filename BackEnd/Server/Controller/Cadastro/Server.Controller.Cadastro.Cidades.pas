unit Server.Controller.Cadastro.Cidades;

interface

uses
  //Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  //Vcl.Graphics,
  //Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Server.Base.Crud,
  System.JSON, jsonbr,
  ormbr.container.objectset, //ormbr.jsonutils.datasnap,
  Generics.Collections, Server.Models.Cadastros.Cidades;

type
  TCidades = class(TServerBaseCrud)
  private
    { Private declarations }
    FContainer: TContainerObjectSet<TCidades>;
  protected
    Function GetObjTabela(const AValue: TJSONObject): TObject; override;
    function GetContainer: TObject; override;
  public
    { Public declarations }
  end;

var
  Cidades: TCidades;

implementation

uses ormbr.json;

{$R *.dfm}

{ TLogin }

function TCidades.GetContainer: TObject;
begin
  if fContainer = nil then
    fContainer := TContainerObjectSet<TCidades>.Create(FConnection);

  Result := fContainer;

end;

function TCidades.GetObjTabela(const AValue: TJSONObject): TObject;
begin
  result := TORMBrJson.JsonToObject<TCidades>(AValue.ToJSON);
end;

end.
