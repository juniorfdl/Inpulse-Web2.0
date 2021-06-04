unit Server.Controller.ConsistirFinalizarLigacaoFactory;

interface

uses Server.Controller.ConsistirFinalizarLigacao, dbebr.factory.interfaces;

type
  TConsistirFinalizarLigacaoFactory = class
  private
  public
    class procedure Execute(const pObjCli: TObject; const pConnection: IDBConnection);
  end;

implementation

{ TConsistirFinalizarLigacaoFactory }

class procedure TConsistirFinalizarLigacaoFactory.Execute(
  const pObjCli: TObject; const pConnection: IDBConnection);
var
  vConsistir: TConsistirFinalizarLigacao;
begin
  vConsistir:= TConsistirFinalizarLigacao.Create(pObjCli, pConnection);
  try
    vConsistir.Execute();
  finally
    vConsistir.Free;
  end;
end;

end.
