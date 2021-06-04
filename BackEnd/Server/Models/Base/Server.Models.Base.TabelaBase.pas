unit Server.Models.Base.TabelaBase;

interface

uses
  Classes,
  SysUtils,
  DB,
  Generics.Collections,
  dbcbr.mapping.attributes,
  dbcbr.types.mapping,
  ormbr.types.lazy,
  ormbr.types.nullable,
  dbcbr.mapping.register;

type
 TTabelaBase = class //abstract(TInterfacedObject, ITabelaBase)
 private
    fDataBase: String;
    function getDataBase: String;

    //function GetDataBase:String;
    //procedure SetDataBase(const Value: String);
 protected
    fid: Integer;
 public
//    [Restrictions([NotNull, Unique])]
//    [Column('CODIGO', ftInteger)]
//    [Dictionary('CODIGO','','','','',taCenter)]
//    property id: Integer read fid write fid;
   property id: Integer read fid write fid;
   //[Column('DATABASE', ftString, 255)]
   //[CalcField('DATABASE',ftString,255)]
   property DataBase:String read getDataBase write fDataBase;
 end;

implementation


{ TTabelaBase }

function TTabelaBase.getDataBase: String;
begin
  if (fDataBase = '') then
    fDataBase := 'crm_sgr';

  Result := fDataBase;
end;

end.
