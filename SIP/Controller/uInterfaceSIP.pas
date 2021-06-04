unit uInterfaceSIP;

interface

type
  ISip = interface
    ['{0C5CFECE-9F70-49E6-91DE-1F30EDAA29A4}']
    function Ligar(const pObj: TObject):String;
    function Transferir(const pObj: TObject):String;
    function EnviarDTMF(const pObj: TObject):String;
    function Desligar:String;
    function Registrar(const pObj: TObject):String;
    function GetState:String;
  end;

implementation

end.
