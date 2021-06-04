unit Server.Models.Ativo.Start;

interface

uses Server.Models.Cadastros.Resultados, Generics.Collections,
  Server.Models.Cadastros.FaseContato, Server.Models.Cadastros.ConfigMail,
  Server.Models.Cadastros.Operadores, Server.Models.Cadastros.MotivosPausa,
  Server.Models.Cadastros.FoneAreas, Server.Models.Cadastros.Grupos,
  Server.Models.Cadastros.Midias, Server.Models.Cadastros.Segmentos,
  Server.Models.Cadastros.Cargos;

type
  TAtivoStart = class
  private
    fResultados: TObjectList<TResultados>;
    fFaseContato: TObjectList<TFaseContato>;
    fConfigMail: TObjectList<TConfigMail>;
    fOperadores: TObjectList<TOperadores>;
    fMotivosPausa: TObjectList<TMotivosPausa>;
    fFoneAreas: TObjectList<TFoneAreas>;
    fSegmentos: TObjectList<TSegmentos>;
    fGrupos: TObjectList<TGrupos>;
    fMidias: TObjectList<TMidias>;
    fCargos: TObjectList<TCargos>;
  public
    property Resultados: TObjectList<TResultados> read fResultados write fResultados;
    property FaseContato: TObjectList<TFaseContato> read fFaseContato write fFaseContato;
    property ConfigMail: TObjectList<TConfigMail> read fConfigMail write fConfigMail;
    property Operadores: TObjectList<TOperadores> read fOperadores write fOperadores;
    property MotivosPausa: TObjectList<TMotivosPausa> read fMotivosPausa write fMotivosPausa;
    property FoneAreas: TObjectList<TFoneAreas> read fFoneAreas write fFoneAreas;

    property Grupos: TObjectList<TGrupos> read fGrupos write fGrupos;
    property Midias: TObjectList<TMidias> read fMidias write fMidias;
    property Segmentos: TObjectList<TSegmentos> read fSegmentos write fSegmentos;
    property Cargos: TObjectList<TCargos> read fCargos write fCargos;

    constructor Create;
    destructor destroy; override;
  end;



implementation

{ TAtivoStart }

constructor TAtivoStart.Create;
begin
  Resultados := TObjectList<TResultados>.Create;
  FaseContato := TObjectList<TFaseContato>.Create;
  ConfigMail := TObjectList<TConfigMail>.Create;
  Operadores := TObjectList<TOperadores>.Create;
  MotivosPausa := TObjectList<TMotivosPausa>.Create;
  FoneAreas := TObjectList<TFoneAreas>.Create;

  Grupos := TObjectList<TGrupos>.Create;
  Midias := TObjectList<TMidias>.Create;
  Segmentos := TObjectList<TSegmentos>.Create;
  Cargos := TObjectList<TCargos>.Create;
end;

destructor TAtivoStart.destroy;
begin
  Resultados.Free;
  FaseContato.Free;
  ConfigMail.Free;
  Operadores.Free;
  MotivosPausa.Free;
  FoneAreas.Free;

  Grupos.Free;
  Midias.Free;
  Segmentos.Free;
  Cargos.Free;
  inherited;
end;

end.
