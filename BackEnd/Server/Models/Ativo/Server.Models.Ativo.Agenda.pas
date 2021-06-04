unit Server.Models.Ativo.Agenda;

interface

type
  TAgendaOperador = class
  Strict private
    fMANUAL: String;
    fCAMPANHA: String;
    fCOD_ERP: Integer;
    fCLIENTE: String;
    fCODIGO: Integer;
    fCONCLUIDO: String;
    fDT_AGENDAMENTO: TDateTime;
    fCODIGO_CLIENTE: Integer;
    fCOR: string;
  published
    property CODIGO:Integer read fCODIGO write fCODIGO;
    property CAMPANHA:String read fCAMPANHA write fCAMPANHA;
    property CLIENTE:String read fCLIENTE write fCLIENTE;
    property COD_ERP:Integer read fCOD_ERP write fCOD_ERP;
    property DT_AGENDAMENTO:TDateTime read fDT_AGENDAMENTO write fDT_AGENDAMENTO;
    property CONCLUIDO:String read fCONCLUIDO write fCONCLUIDO;
    property CODIGO_CLIENTE:Integer read fCODIGO_CLIENTE write fCODIGO_CLIENTE;
    property MANUAL:String read fMANUAL write fMANUAL;
    property COR:String read fCOR write fCOR;
  end;

  TStatusSIP = class
    strict private
      FCodStatus: string;
      FDescricaoStatus: string;
    published
      property CODSTATUS :string read FCodStatus write FCodStatus;
      property DESCRICAOSTATUS :string read FDescricaoStatus write FDescricaoStatus;
  end;

  THistoricoCliente = class
  Strict private
    fTELEFONE_LIGADO: String;
    fOBSERVACAO: String;
    fECONTATO: String;
    fFIDELIZARCOTACAO: String;
    fCAMPANHA: Integer;
    fRES_NOME: String;
    fOPERADOR_LIGACAO: String;
    fRESULTADO: Integer;
    fDATA_HORA_LIG: TDateTime;
    fCODIGO: Integer;
    fUNIDADE: String;
    fCor: string;
  published
    property CAMPANHA:Integer read fCAMPANHA write fCAMPANHA;
    property TELEFONE_LIGADO:String read fTELEFONE_LIGADO write fTELEFONE_LIGADO;
    property OPERADOR_LIGACAO:String read fOPERADOR_LIGACAO write fOPERADOR_LIGACAO;
    property RESULTADO:Integer read fRESULTADO write fRESULTADO;
    property RES_NOME:String read fRES_NOME write fRES_NOME;
    property ECONTATO:String read fECONTATO write fECONTATO;
    property FIDELIZARCOTACAO:String read fFIDELIZARCOTACAO write fFIDELIZARCOTACAO;
    property DATA_HORA_LIG:TDateTime read fDATA_HORA_LIG write fDATA_HORA_LIG;
    property OBSERVACAO:String read fOBSERVACAO write fOBSERVACAO;
    property CODIGO:Integer read fCODIGO write fCODIGO;
    property UNIDADE:String read fUNIDADE write fUNIDADE;
    property COR:String read fCor write fCor;
  end;

  TAgendaFiltros = class
  Strict private
    fCLIENTE_ATIVO: String;
    fCLIENTE_EXCECAO: String;
    fCOD_ERP: String;
    fDATA_FINAL: String;
    fDATA_INICIAL: String;
    fNOME: String;
    fDATABASE: String;
    fOPERADOR: String;
    fEM_ATRASO: String;
  published
    property DATA_INICIAL:String read fDATA_INICIAL write fDATA_INICIAL;
    property DATA_FINAL:String read fDATA_FINAL write fDATA_FINAL;
    property COD_ERP:String read fCOD_ERP write fCOD_ERP;
    property CLIENTE_ATIVO:String read fCLIENTE_ATIVO write fCLIENTE_ATIVO;
    property CLIENTE_EXCECAO:String read fCLIENTE_EXCECAO write fCLIENTE_EXCECAO;
    property NOME:String read fNOME write fNOME;
    property DATABASE:String read fDATABASE write fDATABASE;
    property OPERADOR:String read fOPERADOR write fOPERADOR;
    property EM_ATRASO:String read fEM_ATRASO write fEM_ATRASO;
  end;

implementation

end.
