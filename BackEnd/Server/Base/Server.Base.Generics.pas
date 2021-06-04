unit Server.Base.Generics;

interface

type
  TGenericCrud = class
    private
    public
      //procedimentos para o crud
      class function Gravar<T: class>(Obj: T): T;
      class function Excluir<T: class>(Obj: T): T;
  end;

implementation

{ TGenericCrud }

class function TGenericCrud.Excluir<T>(Obj: T): T;
begin

end;

class function TGenericCrud.Gravar<T>(Obj: T): T;
begin

end;

end.
