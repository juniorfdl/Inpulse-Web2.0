unit Server.Controller.Base.TabelaBase;

interface

uses
  Classes,
  SysUtils,
  DB,
  Generics.Collections,
  ormbr.mapping.attributes,
  ormbr.types.mapping,
  ormbr.types.lazy,
  ormbr.types.nullable,
  ormbr.mapping.register;

type
 TTabelaBase = class //abstract(TInterfacedObject, ITabelaBase)
 private

    fDataBase: String;
    function Getid: Integer;
    procedure Setid(const Value: Integer);
    function GetDataBase:String;
    procedure SetDataBase(const Value: String);
 protected
    fid: Integer;
 public
//    [Restrictions([NotNull, Unique])]
//    [Column('CODIGO', ftInteger)]
//    [Dictionary('CODIGO','','','','',taCenter)]
//    property id: Integer read fid write fid;

   property id: Integer read fid write fid;
   [CalcField('DATABASE', ftString, 255)]
   property DataBase:String read fDataBase write fDataBase;
 end;

implementation


function TTabelaBase.GetDataBase: String;
begin
 result := fDataBase;
end;

function TTabelaBase.Getid: Integer;
begin
  Result := fid;
end;

procedure TTabelaBase.SetDataBase(const Value: String);
begin
  fDataBase := Value;
end;


procedure TTabelaBase.Setid(const Value: Integer);
begin
  fid := Value;
end;

end.
