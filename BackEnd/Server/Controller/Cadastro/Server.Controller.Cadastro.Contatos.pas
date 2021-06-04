unit Server.Controller.Cadastro.Contatos;

interface

uses
  //Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Server.Base.Crud,
  System.JSON, jsonbr,
  ormbr.container.objectset, //ormbr.jsonutils.datasnap,
  Generics.Collections, Server.Models.Cadastros.Contatos;

type
  TContatos = class(TServerBaseCrud)
  private
    { Private declarations }
    FContainer: TContainerObjectSet<TContatos>;
  protected
    Function GetObjTabela(const AValue: TJSONObject): TObject; override;
    function GetContainer: TObject; override;
  public
    { Public declarations }
  end;

var
  Contatos: TContatos;

implementation

{$R *.dfm}

{ TLogin }

function TContatos.GetContainer: TObject;
begin
  if fContainer = nil then
    fContainer := TContainerObjectSet<TContatos>.Create(FConnection);

  Result := fContainer;

end;

function TContatos.GetObjTabela(const AValue: TJSONObject): TObject;
begin
  result := TJSONBr.JsonToObject<TContatos>(AValue.ToJSON);
end;

end.
