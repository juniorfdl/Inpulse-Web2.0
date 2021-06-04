unit Server.Methods.Sistema.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Server.Base.Crud,
  System.JSON, Server.Models.Cadastros.Operadores, ormbr.rest.json,
  ormbr.container.objectset;

type
  TLogin = class(TServerBaseCrud)
  private
    { Private declarations }
    FContainer: TContainerObjectSet<TOperadores>;
  protected
    Function GetObjTabela(AValue: TJSONObject): TObject; override;
    function GetContainer: TObject; override;
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

{ TLogin }

function TLogin.GetContainer: TObject;
begin
  if fContainer = nil then
    fContainer := TContainerObjectSet<TOperadores>.Create(FConnection);

  Result := fContainer;
end;

function TLogin.GetObjTabela(AValue: TJSONObject): TObject;
begin
  result := TORMBrJson.JsonToObject<TOperadores>(AValue.ToJSON);
end;

end.
