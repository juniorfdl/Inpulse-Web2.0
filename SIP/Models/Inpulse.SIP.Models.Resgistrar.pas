unit Inpulse.SIP.Models.Resgistrar;

interface

type
  TRegistrar = class
  private
    fSIP_VOLUME_AUTOMATICO: String;
    fASTERISK_PROXY: String;
    fASTERISK_PORTA: String;
    fASTERISK_SERVER: String;
    fSIP_EMITE_BIP: String;
    fASTERISK_USERID: String;
    fASTERISK_LOGIN: String;
    fASTERISK_SENHA: String;
    fLOCAL_GRAVACAO: String;
    fOPERADORA_LOCAL: String;
    fUsa_ddds_diferentes: String;
    fDDD_LOCAL: String;
    FLicenseKey: String;
    FLicenseUser: String;
    FSip_modo: String;
    FPESQUISA_CLIENTE_ATIVO: String;
  public
    property ASTERISK_PROXY:String read fASTERISK_PROXY write fASTERISK_PROXY;
    property ASTERISK_SERVER:String read fASTERISK_SERVER write fASTERISK_SERVER;
    property ASTERISK_PORTA:String read fASTERISK_PORTA write fASTERISK_PORTA;
    property SIP_EMITE_BIP:String read fSIP_EMITE_BIP write fSIP_EMITE_BIP;
    property SIP_VOLUME_AUTOMATICO: String read fSIP_VOLUME_AUTOMATICO write fSIP_VOLUME_AUTOMATICO;

    property ASTERISK_USERID: String read fASTERISK_USERID write fASTERISK_USERID;
    property ASTERISK_LOGIN: String read fASTERISK_LOGIN write fASTERISK_LOGIN;
    property ASTERISK_SENHA: String read fASTERISK_SENHA write fASTERISK_SENHA;
    property LOCAL_GRAVACAO: String read fLOCAL_GRAVACAO write fLOCAL_GRAVACAO;

    property DDD_LOCAL: String read fDDD_LOCAL write fDDD_LOCAL;
    property OPERADORA_LOCAL: String read fOPERADORA_LOCAL write fOPERADORA_LOCAL;
    property Usa_ddds_diferentes: String read fUsa_ddds_diferentes write fUsa_ddds_diferentes;
    property LICENSEKEY: String read FLicenseKey write FLicenseKey;
    property LICENSEUSER: String read FLicenseUser write FLicenseUser;
    property SIP_MODO: String read FSip_modo write FSip_modo;
    property PESQUISA_CLIENTE_ATIVO: String read FPESQUISA_CLIENTE_ATIVO write FPESQUISA_CLIENTE_ATIVO;

  end;

type
  TModelLigar = class
  private
    fTelefone: String;
    fCodigoLigacao: String;
    fNomeOperador: String;
  public
    property Telefone: String read fTelefone write fTelefone;
    property CodigoLigacao: String read fCodigoLigacao write fCodigoLigacao;
    property NomeOperador: String read fNomeOperador write fNomeOperador;
  end;

type
  TModelState = class
  private
    fStateCod: String;
    fStateDescricao: String;
  public
    property StateCod: String read fStateCod write fStateCod;
    property StateDescricao: String read fStateDescricao write fStateDescricao;
  end;

implementation

{ TRegistrar }


end.

