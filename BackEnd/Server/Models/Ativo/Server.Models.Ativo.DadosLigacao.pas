unit Server.Models.Ativo.DadosLigacao;

interface

uses System.Classes,
  DB,
  System.SysUtils,
  Generics.Collections,
  /// orm
  dbcbr.mapping.attributes,
  dbcbr.types.mapping,
  ormbr.types.lazy,
  ormbr.types.nullable,
  dbcbr.mapping.register,
  Server.Models.Base.TabelaBase;

type
  [Restrictions([NoUpdate])]
  TPropostasClientes = class
  private
    fVENDA: Double;
    fVALOR: Double;
    fCODIGO: Integer;
    fUTILIZAR: String;
    fOPERADOR: String;
    fDATA: TDateTime;
  public
    [Restrictions([NotNull])]
    [Column('CODIGO', ftInteger)]
    property CODIGO:Integer read fCODIGO write fCODIGO;
    property DATA:TDateTime read fDATA write fDATA;
    property OPERADOR:String read fOPERADOR write fOPERADOR;
    property VALOR:Double read fVALOR write fVALOR;
    property UTILIZAR:String read fUTILIZAR write fUTILIZAR;
    property VENDA:Double read fVENDA write fVENDA;
  end;

  [Restrictions([NoUpdate])]
  TDadosCompras = class(TTabelaBase)
  private
    fVALOR: Double;
    fDESCRICAO: String;
    fDadosPropostasCliente: TObjectList<TPropostasClientes>;
  public
    property VALOR:Double read fVALOR write fVALOR;
    property DESCRICAO:String read fDESCRICAO write fDESCRICAO;
    property DadosPropostasCliente: TObjectList<TPropostasClientes> read fDadosPropostasCliente write fDadosPropostasCliente;

    constructor Create;
    destructor destroy; override;
  end;

  TFinalizar = Class
  private
    fOBSERVACAO: string;
    fFASE_CONTATO: Integer;
    fPAUSAR_ENTRE_CHAMADAS: String;
    fENVIAR_MANIFESTO: String;
    fALTA_PRIORIDADE: String;
    fTIPO_EMAIL: String;
    fRESULTADO: Integer;
    fDATA: TDateTime;
    fTELEFONE: String;
    fHORA: String;
    fOperadorDelegar: Integer;
    fVALOR_PROPOSTA: Double;
    fCOMPRAS: TDadosCompras;
  public
    [Column('RESULTADO', ftInteger)]
    property RESULTADO:Integer read fRESULTADO write fRESULTADO;
    property FASE_CONTATO:Integer read fFASE_CONTATO write fFASE_CONTATO;
    property OBSERVACAO:string read fOBSERVACAO write fOBSERVACAO;
    property TELEFONE:String read fTELEFONE write fTELEFONE;
    property DATA:TDateTime read fDATA write fDATA;
    property ALTA_PRIORIDADE:String read fALTA_PRIORIDADE write fALTA_PRIORIDADE;
    property ENVIAR_MANIFESTO:String read fENVIAR_MANIFESTO write fENVIAR_MANIFESTO;
    property PAUSAR_ENTRE_CHAMADAS:String read fPAUSAR_ENTRE_CHAMADAS write fPAUSAR_ENTRE_CHAMADAS;
    property TIPO_EMAIL:String read fTIPO_EMAIL write fTIPO_EMAIL;
    property HORA: String read fHORA write fHORA;
    property OperadorDelegar:Integer read fOperadorDelegar write fOperadorDelegar;
    property VALOR_PROPOSTA:Double read fVALOR_PROPOSTA write fVALOR_PROPOSTA;
    property COMPRAS: TDadosCompras read fCOMPRAS write fCOMPRAS;

    constructor create;
    destructor destroy; override;
  End;

  [Restrictions([NoUpdate])]
  THistorico = Class
  private
    fTIPO_LIGACAO: String;
    fCAMPANHA: String;
    fCODIGO: Integer;
    fFIM: TDateTime;
    fOPERADOR: String;
    fINICIO: TDateTime;
    fRESULTADO: String;
    fTELEFONE: String;
    fOBSERVACAO: String;
    fCOR: string;
    function GetOBSERVACAO: String;
  public
    [Column('CODIGO', ftInteger)]
    property CODIGO:Integer read fCODIGO write fCODIGO;
    property CAMPANHA:String read fCAMPANHA write fCAMPANHA;
    property TIPO_LIGACAO:String read fTIPO_LIGACAO write fTIPO_LIGACAO;
    property OPERADOR:String read fOPERADOR write fOPERADOR;
    property RESULTADO:String read fRESULTADO write fRESULTADO;
    property INICIO:TDateTime read fINICIO write fINICIO;
    property FIM:TDateTime read fFIM write fFIM;
    property TELEFONE:String read fTELEFONE write fTELEFONE;
    property OBSERVACAO:String read GetOBSERVACAO write fOBSERVACAO;
    property COR:String read fCOR write fCOR;
  End;

  [Restrictions([NoUpdate])]
  TAgenda = Class
  private
    fCAMPANHA: String;
    fCODIGO: Integer;
    fOPERADOR: String;
    fDT_AGENDAMENTO: TDateTime;
    fDT_RESULTADO: TDateTime;
    fFONE2: String;
    fRESULTADO: String;
    fFONE1: String;
    fOPERADOR_LIGACAO: String;
    fPROPOSTA: String;
  public
    [Column('CODIGO', ftInteger)]
    property CODIGO: Integer read fCODIGO write fCODIGO;
    property DT_AGENDAMENTO: TDateTime read fDT_AGENDAMENTO write fDT_AGENDAMENTO;
    property FONE1:String read fFONE1 write fFONE1;
    property FONE2:String read fFONE2 write fFONE2;
    property OPERADOR:String read fOPERADOR write fOPERADOR;
    property OPERADOR_LIGACAO:String read fOPERADOR_LIGACAO write fOPERADOR_LIGACAO;
    property RESULTADO:String read fRESULTADO write fRESULTADO;
    property DT_RESULTADO: TDateTime read fDT_RESULTADO write fDT_RESULTADO;
    property CAMPANHA:String read fCAMPANHA write fCAMPANHA;
    property PROPOSTA:String read fPROPOSTA write fPROPOSTA;
  End;

  [Restrictions([NoUpdate])]
  TComprasItem = class
  private
    fDESCONTO: Double;
    fQDT: Integer;
    fDESCRICAO: String;
    fUN_MEDIDA: String;
    fVALOR_UN: Double;
    fCODPROD: String;
  public
    [Restrictions([NotNull])]
    [Column('CODPROD', ftString)]
    property CODPROD:String read fCODPROD write fCODPROD;
    property DESCRICAO:String read fDESCRICAO write fDESCRICAO;
    property QDT:Integer read fQDT write fQDT;
    property UN_MEDIDA:String read fUN_MEDIDA write fUN_MEDIDA;
    property VALOR_UN:Double read fVALOR_UN write fVALOR_UN;
    property DESCONTO:Double read fDESCONTO write fDESCONTO;
  end;

  [PrimaryKey('CODIGO')]
  TCompras = class
  private
    fVALOR: Double;
    fDESCRICAO: String;
    fCODIGO: Integer;
    fFORMA_PGTO: String;
    fDATA: TDateTime;
    fItens: TObjectList<TComprasItem>;
  public
    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    property CODIGO:Integer read fCODIGO write fCODIGO;
    property DATA:TDateTime read fDATA write fDATA;
    property DESCRICAO:String read fDESCRICAO write fDESCRICAO;
    property VALOR:Double read fVALOR write fVALOR;
    property FORMA_PGTO:String read fFORMA_PGTO write fFORMA_PGTO;
    property Itens:TObjectList<TComprasItem> read fItens write fItens;

    constructor create;
    destructor destroy; override;
  end;

  TDadosTempoTotal = class
  private
    fSegundo: String;
    fHora: String;
    fMinuto: String;
    fMes: String;
    fAno: String;
    fDia: String;
  public
    property Ano:String read fAno write fAno;
    property Mes:String read fMes write fMes;
    property Dia:String read fDia write fDia;
    property Hora:String read fHora write fHora;
    property Minuto:String read fMinuto write fMinuto;
    property Segundo:String read fSegundo write fSegundo;
  end;

  [PrimaryKey('CODIGO')]
  TDadosLigacao = class
  private
    fCODIGO: Integer;
    fCAMPANHA: String;
    fCARTEIRA: String;
    fPRIORIDADE: String;
    fBAIRRO: String;
    fGRUPO: String;
    fORIGEM: String;
    fMIDIA: String;
    fSEGMENTO: String;
    fOPERADOR: String;
    fNOME_OPERADOR: String;
    fCOMPRAS: TObjectList<TCompras>;
    fAGENDA: TObjectList<TAgenda>;
    fHistorico: TObjectList<THistorico>;
    fFinalizar: TFinalizar;
    fFONE: String;
    fFIDELIZA: String;
    fCOD_CAMPANHA: Integer;
    fPRODUTIVIDADE: String;
    fPEDIDOS_FECHADOS: String;
    fASSINATURA: String;
    fDATA_INICIO: Double;
    fLIG_EFETUADAS: String;
    fNOME_CONTATO: String;
    fTempoTotal: TDadosTempoTotal;
    fCODIGOENTRADA: String;
    FATIVO_RECEP: string;
    fLigacoesUlt7Dias: Integer;
    fFidelizacoes: String;
    fCONTATO_MAIL: String;
    fEMAIL: String;
  public
    [Restrictions([NotNull, Unique])]
    [Column('CODIGO', ftInteger)]
    property CODIGO:Integer read fCODIGO write fCODIGO;

    property CAMPANHA:String read fCAMPANHA write fCAMPANHA;
    property CARTEIRA:String read fCARTEIRA write fCARTEIRA;

    property LIG_EFETUADAS:String read fLIG_EFETUADAS write fLIG_EFETUADAS;

    property PRIORIDADE:String read fPRIORIDADE write fPRIORIDADE;
    property COD_CAMPANHA:Integer read fCOD_CAMPANHA write fCOD_CAMPANHA;

    property GRUPO:String read fGRUPO write fGRUPO;
    property ORIGEM:String read fORIGEM write fORIGEM;
    property MIDIA:String read fMIDIA write fMIDIA;

    property SEGMENTO:String read fSEGMENTO write fSEGMENTO;
    property OPERADOR:String read fOPERADOR write fOPERADOR;
    property NOME_OPERADOR:String read fNOME_OPERADOR write fNOME_OPERADOR;

    property COMPRAS:TObjectList<TCompras> read fCOMPRAS write fCOMPRAS;
    property AGENDA:TObjectList<TAgenda> read fAGENDA write fAGENDA;
    property Historico:TObjectList<THistorico> read fHistorico write fHistorico;

    property Finalizar: TFinalizar read fFinalizar write fFinalizar;

    property FONE:String read fFONE write fFONE;
    property FIDELIZA:String read fFIDELIZA write fFIDELIZA;
    property PRODUTIVIDADE:String read fPRODUTIVIDADE write fPRODUTIVIDADE;
    property PEDIDOS_FECHADOS:String read fPEDIDOS_FECHADOS write fPEDIDOS_FECHADOS;

    property ASSINATURA:String read fASSINATURA write fASSINATURA;
    property DATA_INICIO:Double read fDATA_INICIO write fDATA_INICIO;
    property NOME_CONTATO:String read fNOME_CONTATO write fNOME_CONTATO;
    property CODIGOENTRADA:String read fCODIGOENTRADA write fCODIGOENTRADA;
    property ATIVO_RECEP: string read FATIVO_RECEP write FATIVO_RECEP;
    property TempoTotal: TDadosTempoTotal read fTempoTotal write fTempoTotal;

    property LigacoesUlt7Dias:Integer read fLigacoesUlt7Dias write fLigacoesUlt7Dias;
    property Fidelizacoes:String read fFidelizacoes write fFidelizacoes;

    property EMAIL:String read fEMAIL write fEMAIL;
    property CONTATO_MAIL:String read fCONTATO_MAIL write fCONTATO_MAIL;

    constructor create;
    destructor destroy; override;
  end;


implementation

{ TCompras }

uses Infotec.Utils;

constructor TCompras.create;
begin
  FItens := TObjectList<TComprasItem>.create;
end;

destructor TCompras.destroy;
begin
  FreeAndNil(FItens);
  inherited;
end;

{ TDadosLigacao }

constructor TDadosLigacao.create;
begin
  FCOMPRAS := TObjectList<TCompras>.create;
  FAGENDA := TObjectList<TAgenda>.create;
  FHistorico := TObjectList<THistorico>.create;
  FFinalizar := TFinalizar.Create;
  FTempoTotal := TDadosTempoTotal.Create;
end;

destructor TDadosLigacao.destroy;
begin
  FreeAndNil(FFinalizar);
  FreeAndNil(FCOMPRAS);
  FreeAndNil(FAGENDA);
  FreeAndNil(FHistorico);
  FreeAndNil(FTempoTotal);
  inherited;
end;

{ TDadosCompras }

constructor TDadosCompras.Create;
begin
  FDadosPropostasCliente := TObjectList<TPropostasClientes>.create;
end;

destructor TDadosCompras.destroy;
begin
  FreeAndNil(FDadosPropostasCliente);
  inherited;
end;

{ TFinalizar }

constructor TFinalizar.create;
begin
  FCOMPRAS := TDadosCompras.Create;
end;

destructor TFinalizar.destroy;
begin
  FreeAndNil(FCOMPRAS);
  inherited;
end;

{ THistorico }

function THistorico.GetOBSERVACAO: String;
begin
  Result := TInfotecUtils.RemoverEspasDuplas(fOBSERVACAO);
end;

end.
