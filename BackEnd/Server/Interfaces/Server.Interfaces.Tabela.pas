unit Server.Interfaces.Tabela;

interface

type
  ITabelaBase = interface ['{1D257E15-B914-436D-A850-F35D75138598}']
   {$REGION 'Property Getters & Setters'}
    function Getid: Integer;
    procedure Setid(const Value: Integer);
    function GetDataBase:String;
    procedure SetDataBase(const Value: String);
  {$ENDREGION}
    property id: Integer read Getid write Setid;

    property DataBase:String read GetDataBase write SetDataBase;
  end;

implementation

end.
