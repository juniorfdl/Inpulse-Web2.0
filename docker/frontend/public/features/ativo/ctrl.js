
var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var App;
(function (App) {
    var Controllers;
    (function (Controllers) {
        'use strict';
        var CrudAtivoCtrl = (function (_super) {
       
            __extends(CrudAtivoCtrl, _super);
            function CrudAtivoCtrl($rootScope, api, CrudAtivoService, $q, $scope, $modal, security, SweetAlert) { //roundProgressService, $interval,
                var _this = this;
                this.SweetAlert = SweetAlert;
                var _rootScope = $rootScope;
                
                var _scope = $scope;
                var timestampLigacao = null;
                var tecladoVisivel = false;
                var receptivoVisivel = false;
               

                var input = {
                    year: 0,
                    month: 0,
                    day: 0,
                    hours: 0,
                    minutes: 0,
                    seconds: 1
                };
                var timestamp = new Date(input.year, input.month, input.day,
                    input.hours, input.minutes, input.seconds);

                _this.ExectandoGetStateLigacao = false;
                _this.timestampLigacaoTotal = 0;
                _this.tempoEmPausa = 0;
                _this.RecebendoChamada = false;
                _this.filtrosPesquisaCLiente = '';
                _this.NumeroRecebendoChamada = 'Numero Desconhecido';
                _this.CallFrom = '';
                _this.DadosClienteCarregado = false;
                _this.tempoTotal = '00:00:00';
                _this.tempoLigacao = '00:00:00';
                _this.tempoTotalLigacao = '00:00:00';
                _super.call(this);
                _this.PausarLigacoes = $rootScope.PausarLigacoes;
                _this.lista = {};
                _this.DadosRecebendoLigacao ={};
                _this.ListaCampanhas = {}
                _this.CPF_CNPJ = ''
                _this.UltimaPagina = false;
                _this.PaginaAtual = 1; 
               
                _this.DadosPesquisaCliente ={};    
                _this.modalPesquisaCLiente = {};
                _this.PessoaSelecionada = -1;
                this.Sexo = [{ SEXO: 'M', DESCRICAO: 'Masculino' }, { SEXO: 'F', DESCRICAO: 'Feminino' }];
                this.ListaPrioridade = [{ PRIORIDADE: 'Alta' }, { PRIORIDADE: 'Normal' }, { PRIORIDADE: 'Baixa' }];

                this.UFLook = [{ UF: 'AC' }, { UF: 'AL' }, { UF: 'AM' }, { UF: 'AP' }, { UF: 'BA' }, { UF: 'CE' }
                    , { UF: 'DF' }, { UF: 'ES' }, { UF: 'GO' }, { UF: 'MA' }, { UF: 'MG' }, { UF: 'MS' }, { UF: 'MT' }
                    , { UF: 'PA' }, { UF: 'PB' }, { UF: 'PE' }, { UF: 'PI' }, { UF: 'PR' }, { UF: 'RJ' }
                    , { UF: 'RN' }, { UF: 'RO' }, { UF: 'RR' }, { UF: 'RS' }, { UF: 'SC' }, { UF: 'SE' },
                { UF: 'SP' }, { UF: 'TO' }];

                this.Flg_Filtros = [{ FLG: 'SIM' }, { FLG: 'NAO' }, { FLG: 'TODOS' }];

                this.CidadeLook = [];

                this.$modal = $modal;

                this.MenuSelecionado = 'ENDEREÇO';
                this.TempoAguardeLigacao = -1;

                this.TempoAntesProximoLigacao = function () {
                    this.GetProximaLigacao();
                    // this.modalTempo = $modal.open({
                    //     templateUrl: 'features/ativo/tempoAntesproximaligacao.html',
                    //     resolve: {},
                    //     scope: $scope,
                    //     backdrop: 'static',
                    //     rootScope: $rootScope
                    // });
                }
                
                this.FecharTempo = function () {
                    this.modalTempo.close();

                    if (this.ProximaLigacao && this.ProximaLigacao.DadosLigacao && !this.SipDemo()) {
                        this.crudSvc.Ligar(this.ProximaLigacao.DadosLigacao);
                    }
                }

                this.PermitePesquisarClienteAtivo = function () {
                    if (_rootScope.currentUser.Registrar.PESQUISA_CLIENTE_ATIVO == 'S') {
                        return true
                    }
                    else {
                        return false
                    }
                }

                this.SipDemo = function () {
                    //console.log('sip_mnodo' +_rootScope.currentUser.Registrar.SIP_MODO )
                   if (_rootScope.currentUser.Registrar.SIP_MODO == 'DEMO') {
                       return true
                   }
                   else {
                       return false
                   }
                }
                this.Registrar = function () {
                    if (_this.SipDemo()) {
                        _this.RegistroOK = true;
                        if (_this.PausarLigacoes) {
                            _this.AbrirModalPausa();
                        } else {
                            _this.TempoAntesProximoLigacao();
                        }
                        return
                    }
                        this.crudSvc.Registrar(_rootScope.currentUser.Registrar).then(function (dados) {
                            _this.RegistroOK = true;
                            if (_this.PausarLigacoes) {
                                _this.AbrirModalPausa();
                            } else {
                                _this.TempoAntesProximoLigacao();
                            }
                        }).catch(function (data) {
                            _this.RegistroOK = false;
                        });
                  
                   
                }

                this.LigarTeclado = function () {
                    if ( (_this.TelefoneTeclado) || (_this.RecebendoChamada)) {
                        var vDados = {};
                        if (_this.SipDemo()) {
                            return
                        }
                        vDados.Finalizar = {};
                        vDados.Finalizar.TELEFONE = _this.TelefoneTeclado;
                        vDados.CodigoLigacao = _rootScope.currentUser.id;
                        vDados.NomeOperador = _rootScope.currentUser.LOGIN;
                        _this.crudSvc.Ligar(vDados);
                    }
                }

                this.Transferir = function () {
                    if (_this.TelefoneTeclado) {
                        var vDados = {};
                        vDados.FONE = _this.TelefoneTeclado;
                        _this.crudSvc.Transferir(vDados);
                    }
                }

                this.EnviarDTMF = function (pNro) {
                    if (pNro) {
                        var vDados = {};
                        vDados.FONE = pNro;
                        _this.crudSvc.EnviarDTMF(vDados);
                    }
                }
                this.BuscaDadosCampanhas = function () {
                    _this.crudSvc.BuscaCampanhas( 
                        _rootScope.currentUser.CAMINHO_DATABASE).then(function (dados) {
                            _this.ListaCampanhas = dados;
                            debugger
                        });
                          
                }
                this.GetDadosRecebendoLigacao = function (pFone) {
            
                    _this.crudSvc.GetDadosRecebendoLigacao(pFone,
                        _rootScope.currentUser.CAMINHO_DATABASE,_rootScope.currentUser.id).then(function (dados) {
                          
                                
                                _this.DadosRecebendoLigacao = dados;
                               /* _this.DadosRecebendoLigacao.id = dados.id; 
                                _this.DadosRecebendoLigacao.FANTASIA = dados.FANTASIA;
                                _this.DadosRecebendoLigacao.NOME_CONTATO = dados.NOME_CONTATO; 
                                _this.DadosRecebendoLigacao.CPF_CNPJ = dados.CPF_CNPJ;
                                _this.DadosRecebendoLigacao.IE_RG = dados.IE_RG;
                                _this.DadosRecebendoLigacao.PESSOA = dados.PESSOA;
                                _this.DadosRecebendoLigacao.COD_ERP = dados.COD_ERP;
                                _this.DadosRecebendoLigacao.OBS_ADMIN = dados.OBS_ADMIN;
                                _this.DadosRecebendoLigacao.OBS_OPERADOR = dados.OBS_OPERADOR;
                                _this.DadosRecebendoLigacao.DadosLigacao = dados.DadosLigacao;
                                _this.DadosRecebendoLigacao.DadosLigacao.Finalizar = dados.DadosLigacao.Finalizar;

                                _this.DadosRecebendoLigacao.AREA1 = dados.AREA1;
                                _this.DadosRecebendoLigacao.AREA2 = dados.AREA2;
                                _this.DadosRecebendoLigacao.AREA3 = dados.AREA3;

                                _this.DadosRecebendoLigacao.FONE1 = dados.FONE1;
                                _this.DadosRecebendoLigacao.FONE2 = dados.FONE2;
                                _this.DadosRecebendoLigacao.FONE3 = dados.FONE3;

                                _this.DadosRecebendoLigacao.DESC_FONE1 = dados.DESC_FONE1;
                                _this.DadosRecebendoLigacao.DESC_FONE2 = dados.DESC_FONE2;
                                _this.DadosRecebendoLigacao.DESC_FONE3 = dados.DESC_FONE3;*/

                            

                        });
                }
                this.GetProximaLigacao = function () {

                    _this.tempoEmPausa = 0;
                    _this.crudSvc.GetProximaLigacao(_rootScope.currentUser.id,
                        _rootScope.currentUser.CAMINHO_DATABASE).then(function (dados) {
                            if (dados) {
                                _this.TempoAguardeLigacao = 1;
                                _this.ProximaLigacao = dados;
                                _this.EnviarEmail = {};
                                _this.EnviarEmail.Anexos = {};

                                //debugger;
                                _this.ProximaLigacao.DadosLigacao.CODIGOENTRADA = _rootScope.currentUser.CODIGOENTRADA;

                                _this.timestampLigacaoTotal = new Date(_this.ProximaLigacao.DadosLigacao.TempoTotal.Ano,
                                    _this.ProximaLigacao.DadosLigacao.TempoTotal.Mes,
                                    _this.ProximaLigacao.DadosLigacao.TempoTotal.Dia,
                                    _this.ProximaLigacao.DadosLigacao.TempoTotal.Hora,
                                    _this.ProximaLigacao.DadosLigacao.TempoTotal.Minuto,
                                    _this.ProximaLigacao.DadosLigacao.TempoTotal.Segundo);

                                if (_this.ProximaLigacao.Contatos && _this.ProximaLigacao.Contatos.length > 0) {
                                    _this.ProximaLigacao.NOME_CONTATO = _this.ProximaLigacao.Contatos[0].NOME;
                                }

                                _this.SelectCompra = 0;
                                _this.CidadeLook = [];
                                _this.CidadeLook.push({ NOME: _this.ProximaLigacao.CIDADE });
                                _this.lista = _this.ProximaLigacao.DadosLigacao.AGENDA;
                                _this.lista.$params = {};

                                if (_this.ProximaLigacao.DadosLigacao.Historico &&
                                    _this.ProximaLigacao.DadosLigacao.Historico.length > 0) {
                                    _this.HistoricoOBSERVACAO =
                                        _this.ProximaLigacao.DadosLigacao.Historico[0].OBSERVACAO;
                                }
                            };
                        });
                }

                this.GetDescricaoResultado = function (item) {

                    if (item.id > -1) {
                        if (item.NOME != "")
                            return item.NOME
                        else
                            return "Selecione um Resultado";
                    }

                    return "Selecione um Resultado";
                }

                this.GetProposta = function (item) {

                    if (item.PROPOSTA == "NAO")
                        return 'NÃO'
                    else
                        return item.PROPOSTA;
                }

                this.GetDescricaoResultadoCod = function (item) {

                    if (item.id > -1) {
                        if (item.NOME != "")
                            return item.id
                        else
                            return item.id;
                    }

                    return "";
                }

                this.ChangeResultado = function () {

                    var vItens = this.DadosStart.Resultados;
                    for (var i in vItens) {
                        if (vItens[i].id == this.ProximaLigacao.DadosLigacao.Finalizar.RESULTADO) {
                            this.ProximaLigacao.DadosLigacao.Finalizar.ACAO = vItens[i].COD_ACAO;
                            this.ProximaLigacao.DadosLigacao.Finalizar.DESCRICAO_ACAO = vItens[i].DESCRICAO_ACAO;
                            this.ProximaLigacao.DadosLigacao.Finalizar.PROPOSTA = vItens[i].PROPOSTA;

                            if (vItens[i].EVENDA == 'SIM') {
                                this.AbrirModalPropostasCliente();
                            } else {
                                _this.COMPRAS = {};
                            }
                            return;
                        }
                    }

                }

                this.ChangeResultadoReceptivo = function () {

                    var vItens = this.DadosStart.Resultados;
                    for (var i in vItens) {
                        if (vItens[i].id == _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.RESULTADO) {
                            _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.ACAO = vItens[i].COD_ACAO;
                            _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.DESCRICAO_ACAO = vItens[i].DESCRICAO_ACAO;
                            _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.PROPOSTA = vItens[i].PROPOSTA;

                            if (vItens[i].EVENDA == 'SIM') {
                                this.AbrirModalPropostasCliente();
                            } else {
                                _this.COMPRAS = {};
                            }
                            return;
                        }
                    }

                }

                this.VisualizarData = function () {
                    return this.ProximaLigacao.DadosLigacao.Finalizar.ACAO == '2'
                        || this.ProximaLigacao.DadosLigacao.Finalizar.ACAO == '7'
                        || this.ProximaLigacao.DadosLigacao.Finalizar.ACAO == '8';
                }
                this.VisualizarDataReceptivo = function () {
                    if (_this.DadosRecebendoLigacao.DadosLigacao) {
                        return _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.ACAO == '2'
                        || _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.ACAO == '7'
                        || _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.ACAO == '8';
                    }                    
                }
                this.VisualizarEmail = function () {
                    return this.ProximaLigacao.DadosLigacao.Finalizar.ACAO == '14'
                        || this.ProximaLigacao.DadosLigacao.Finalizar.ACAO == '7';
                }
                this.VisualizarEmailReceptivo = function () {
                    if (_this.DadosRecebendoLigacao.DadosLigacao) {
                    return _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.ACAO == '14'
                        || _this.DadosRecebendoLigacao.DadosLigacao.Finalizar.ACAO == '7';
                    }
                }

                this.PodeFinalizar = function () {

                    if (this.OperacaoFinalizada == 1) {
                        return false;
                    }

                    if (this.ProximaLigacao.DadosLigacao.Finalizar.ACAO == 8) {
                        if (!this.ProximaLigacao.DadosLigacao.Finalizar.OperadorDelegar ||
                            this.ProximaLigacao.DadosLigacao.Finalizar.OperadorDelegar <= 0) {
                            _this.toaster.error("Atenção", "Informe o campo Delegar Operador!");

                            return false;
                        }
                    }

                    return true;
                }

                this.FinalizarLigacao = function () {

                    if (!this.PodeFinalizar()) {
                        return;
                    }

                    this.OperacaoFinalizada = 1;

                    if (this.ProximaLigacao) {
                        this.ProximaLigacao.DataBase = $rootScope.currentUser.CAMINHO_DATABASE;

                        if (!this.ProximaLigacao.DadosLigacao.Finalizar.OperadorDelegar) {
                            this.ProximaLigacao.DadosLigacao.Finalizar.OperadorDelegar = -1;
                        }

                        this.ProximaLigacao.DadosLigacao.OPERADOR = _rootScope.currentUser.id;
                        this.ProximaLigacao.DadosLigacao.Finalizar.COMPRAS = this.COMPRAS;

                        if (this.ProximaLigacao.AREA1=="") {
                            this.ProximaLigacao.AREA1 = 0;
                        }
                        if (this.ProximaLigacao.AREAFAX=="") {
                            this.ProximaLigacao.AREAFAX = 0;
                        }
                        if (this.ProximaLigacao.AREA2=="") {
                            this.ProximaLigacao.AREA2 = 0;
                        }
                        if (this.ProximaLigacao.AREA3=="") {
                            this.ProximaLigacao.AREA3 = 0;
                        }

                        var vDados = angular.copy(this.ProximaLigacao);
                        this.crudSvc.FinalizarLigacao(vDados, _this.SipDemo()).then(function (dados) {
                            // _this.ProximaLigacao = dados;
                            // _this.SelectCompra = 0; 
                            

                            if (!_this.SipDemo()){
                                _this.RenameRecordFile(dados.id) ; }
                           
                            _this.OperacaoFinalizada = 0;
                            if (dados) {
                                _this.FecharFinalizar();

                                if (_this.PausarLigacoes) {
                                    _this.AbrirModalPausa();
                                } else {
                                    _this.TempoAntesProximoLigacao();
                                }
                            }
                        });
                    }
                    else {
                        _this.toaster.error("Atenção", "Não existe ligação ativa!");
                    }
                }
                this.SetMicValue = function() {
                    if (_this.SipDemo()) {
                        return
                    }
                    this.crudSvc.SetMicVolume(this.micvolume);  
                }
                this.SetPhoneValue = function() {
                    if (_this.SipDemo()) {
                        return
                    }
                    this.crudSvc.SetPhoneVolume(this.phonevolume);  
                }

                this.SetMicMute = function() {
                        if (this.micmute) {
                            this.crudSvc.SetMicMute('S');
                        }
                        else {
                            this.crudSvc.SetMicMute('N');
                        }
                      
                }
                this.SetPhoneMute = function() {
                    if (this.phonemute){
                        this.crudSvc.SetPhoneMute('S');  
                    }
                    else{
                        this.crudSvc.SetPhoneMute('N');  
                    }
                 //   
                }
                
                this.FinalizarLigacaoRecebida = function () {
                   
                    this.OperacaoFinalizada = 1;
                    if (this.DadosRecebendoLigacao.RAZAO==''){
                        _this.toaster.error("Atenção", "Selecione um cliente ou preencha os dads para cadastro");
                    } else if (this.DadosRecebendoLigacao) {
                        this.DadosRecebendoLigacao.DataBase = $rootScope.currentUser.CAMINHO_DATABASE;

                        if (!this.DadosRecebendoLigacao.DadosLigacao.Finalizar.OperadorDelegar) {
                            this.DadosRecebendoLigacao.DadosLigacao.Finalizar.OperadorDelegar = -1;
                        }

                        this.DadosRecebendoLigacao.DadosLigacao.OPERADOR = _rootScope.currentUser.id;
                        this.DadosRecebendoLigacao.OPERADOR = _rootScope.currentUser.id;
                        this.DadosRecebendoLigacao.DadosLigacao.Finalizar.COMPRAS = this.COMPRAS;
                        this.DadosRecebendoLigacao.DadosLigacao.COD_CAMPANHA =   this.DadosRecebendoLigacao.COD_UNIDADE * 4;
                        if (this.DadosRecebendoLigacao.AREA1=="") {
                            this.DadosRecebendoLigacao.AREA1 = 0;
                        }
                        if (this.DadosRecebendoLigacao.AREAFAX=="") {
                            this.DadosRecebendoLigacao.AREAFAX = 0;
                        }
                        if (this.DadosRecebendoLigacao.AREA2=="") {
                            this.DadosRecebendoLigacao.AREA2 = 0;
                        }
                        if (this.DadosRecebendoLigacao.AREA3=="") {
                            this.DadosRecebendoLigacao.AREA3 = 0;
                        }
                        if (this.DadosRecebendoLigacao.GRUPO=="") {
                            this.DadosRecebendoLigacao.GRUPO = 0;
                        }
                        if (this.DadosRecebendoLigacao.COD_MIDIA=="") {
                            this.DadosRecebendoLigacao.COD_MIDIA = 0;
                        }
                        if (this.DadosRecebendoLigacao.SEGMENTO=="") {
                            this.DadosRecebendoLigacao.SEGMENTO = 0;
                        }
                        if (this.DadosRecebendoLigacao.PESSOA =="") {
                            this.DadosRecebendoLigacao.PESSOA = 1;
                        }

                        this.DadosRecebendoLigacao.DadosLigacao.ATIVO_RECEP = 'RECEP';
                        var vDados = angular.copy(this.DadosRecebendoLigacao);
                        
                        this.crudSvc.FinalizarLigacao(vDados, _this.SipDemo()).then(function (dados) {
                            if (!_this.SipDemo()){
                                 _this.RenameRecordFile(dados.id) ;
                            }
                             
                            _this.OperacaoFinalizada = 0;
                            if (dados) {
                                _this.modalReceptivo.close(); 

                                if (_this.PausarLigacoes) {
                                    _this.AbrirModalPausa();
                                } else {
                                    _this.TempoAntesProximoLigacao();
                                }
                            }
                        });
                    }
                    else {
                        _this.toaster.error("Atenção", "Não existe ligação ativa!");
                    }
                }
                this.RenameRecordFile = function(id) {
                    this.crudSvc.RenameRecord(id);
                }
                this.LigacaoPerdida = function () {
                    this.TempoAguardeLigacao = -1;
                    if (!_this.SipDemo()){
                      this.crudSvc.Desligar().then((dados) => {
                        _this.RenameRecordFile(-2);
                    });   
                    }
                   
                    _this.modalReceptivo.close();
                }
                this.LiberarLigacao = function () {
                    if (this.ProximaLigacao) {
                        this.TempoAguardeLigacao = -1;
                        this.crudSvc.Desligar().then((dados) => {
                          // alert(_this.ProximaLigacao.id); 
                          if (_this.RecebendoChamada) {
                              if (_this.DadosRecebendoLigacao.id) {
                                _this.RenameRecordFile(_this.DadosRecebendoLigacao.id) ;
                              }
                              else {
                                _this.RenameRecordFile(0) ;
                              }                             
                            }
                            else {
                                _this.RenameRecordFile(_this.ProximaLigacao.id) ;
                            } 
                        
                        });
                        //
                        //this.stopTimer();
                        // this.crudSvc.LiberarLigacao($rootScope.currentUser.id,
                        //     $rootScope.currentUser.CAMINHO_DATABASE).then(function (dados) {
                        //         _this.LiberarOK = dados;
                        //     });
                    }
                    else {
                        _this.toaster.error("Atenção", "Não existe ligação ativa!");
                    }
                }

                this.GetStart = function () {
                    
                    this.crudSvc.GetStart($rootScope.currentUser.CAMINHO_DATABASE).then(function (dados) {
                        _this.DadosStart = dados;
                        _this.BuscaDadosCampanhas();
                    });
                }
                this.CalcDoc = function () {
                    if (document.getElementById("CPF_CNPJ_INPUT").value.length < 12) {
                        _this.CPF_CNPJ = 'cpf' 
                    }
                    else {
                        _this.CPF_CNPJ = 'cnpj' 
                    }
                    alert(_this.CPF_CNPJ)

                }
                this.unRegister = function () {
                        debugger;
                    this.crudSvc.unRegister().then(function (dados) {
                        debugger;
                           console.log(dados)   ;
                   
                 })}
                this.GetStateLigacao = function () {
                    console.log(_rootScope.currentUser.Registrar)
                    if (_rootScope.currentUser.Registrar.SIP_MODO == 'DEMO') {
                        return true
                    }
                    if (_this.ExectandoGetStateLigacao) {
                        return;
                    }

                    _this.ExectandoGetStateLigacao = true;
                    this.ExecutarState();                                        
                }

                this.TestarStatusEmConversacao = function (value) {
                    var status = value.substring(3, 11);
                    status = status.toLowerCase();
                    return status == 'conversa';
                }

                this.ExecutarState = function () {
                    this.crudSvc.State().then(function (dados) {
                        var statusAnt = _this.StatusLigacao;						

                        if (dados) {
                            _this.StatusLigacao = dados.StateDescricao;
                        }
                        else {
						   _this.StatusLigacao = "";
						} 							
						
						if (!_this.StatusLigacao || (_this.StatusLigacao == "")) {
						   dados = JSON.parse(dados);
						   _this.StatusLigacao = dados.StateDescricao;
						}

                        if (!_this.TestarStatusEmConversacao(statusAnt) && _this.TestarStatusEmConversacao(_this.StatusLigacao)) {
                            timestampLigacao = new Date(input.year, input.month, input.day,
                                input.hours, input.minutes, input.seconds);
                        }
                        else {
                            if (!_this.TestarStatusEmConversacao(_this.StatusLigacao)) {
                                timestampLigacao = null;
                                _this.tempoLigacao = '00:00:00';
                            }
                        }
						
						if (_this.StatusLigacao == 'Recebendo ligaçao...') {
							if (!_this.RecebendoChamada) {
                                if (obj.StateCod.match(/^[0-9]+$/) != null) {
                                 //   _this.DadosRecebendoLigacao(obj.StateCod);
                                 _this.GetDadosRecebendoLigacao(obj.StateCod); 
                                 _this.NumeroRecebendoChamada = 'Recebendo Chamada de : ' + obj.StateCod;
                                }   
                                else
                                {
                                   _this.NumeroRecebendoChamada = 'Recebendo Chamada de : Numero Desconhecido';
                                } 
                                                          
                                _this.AbrirModalreceptivo();
                                _this.RecebendoChamada = true;
                            }
							
                        }
                        else
                        {
                            _this.RecebendoChamada = false;
                        }

                        _this.StatusLigacaoCalc = _this.StatusLigacao;

                        if (_this.StatusLigacaoCalc == 'Em conversacao...') {
                            _this.StatusLigacaoCalc = 'Em Conversação...';
                        }

                        if (statusAnt != _this.StatusLigacao) {
                            _this.SetStatusLigacao(_rootScope.currentUser.id,
                                _this.StatusLigacao, _rootScope.currentUser.CAMINHO_DATABASE);
                        }

                        _this.ExectandoGetStateLigacao = false;
                    }).catch(function (data) {
                        _this.ExectandoGetStateLigacao = false;
                        console.log('this.ExecutarState ', data);
                    }); 
                }

                this.InserirClientes = function (){

                    _this.PessoaSelecionada = -1;
                    
                    _this.DadosRecebendoLigacao = {};

                }

                this.ChamarReceptivo = function (){
                    _this.AbrirModalreceptivo();
                    _this.RecebendoChamada = true;
                }

                this.SetStatusLigacao = function (pOperador, pStatus, pCAMINHO_BANCO) {

                    if (!pOperador) {
                        return;
                    }

                    if (!pStatus) {
                        return;
                    }

                    if (!pCAMINHO_BANCO) {
                        return;
                    }

                    if (!_this.ProximaLigacao) {
                        return;
                    }

                    if (!_this.ProximaLigacao.DadosLigacao) {
                        return;
                    }

                    _this.crudSvc.SetStatusLigacao(pOperador, pStatus, pCAMINHO_BANCO).then(function (dados) {
                        if (dados == 2 || dados == 1) {

                            _this.crudSvc.GetDate().then(function (pdata) {
                                if (pdata) {
                                    _this.ProximaLigacao.DadosLigacao.DATA_INICIO = pdata;
                                };
                            });

                        };
                    });

                }
                this.PausarSIP = function (){
                    this.crudSvc.PausarSIP();
                }
                this.SairPausarSIP = function (){
                    this.crudSvc.SairPausarSIP();    
                }
                function ExecutaStart() {
                    _this.$rootScope = $rootScope;
                    _this.api = api;
                    _this.crudSvc = CrudAtivoService;
                    _this.ApenasConsulta = true;
                    _this.GetStart();
                    _this.Registrar();

                    

                }

                this.ChangeMotivoPausa = function () {
                    if (this.SelectedMotivoPausa) {
                        this.MotivoPausa = this.SelectedMotivoPausa.id;

                        this.TEMPO_MAX_SEG = this.SelectedMotivoPausa.TEMPO_MAX_SEG;
                        var tick = this.TEMPO_MAX_SEG;
                        var secs = tick % 60;
                        tick = (tick - secs) / 60;
                        var mins = tick % 60;
                        tick = (tick - mins) / 60;
                        var hrs = tick;
                        this.TEMPO_MAX_SEG_DISPLAY = (hrs < 10 ? "0" : "") + hrs + ":"
                            + (mins < 10 ? "0" : "") + mins + ":"
                            + (secs < 10 ? "0" : "") + secs;

                    }
                }
                this.SelecionarPesquisa = function() {
                    _this.DadosClienteCarregado = true;
                    if (_this.PessoaSelecionada == -1){
                        this.toaster.error("Atenção", "Selecione uma pessoa para continuar!");
                        _this.DadosClienteCarregado = false;
                    }
                    else {
                         _this.crudSvc.BuscarDadosCliente(_this.PessoaSelecionada,_rootScope.currentUser.CAMINHO_DATABASE, _this.PaginaAtual).then(function (dados) {
                        if (_this.receptivoVisivel) {
                            _this.DadosRecebendoLigacao = dados;
                        }else {
                            _this.ProximaLigacao = dados;
                        }
                       
                        _this.DadosClienteCarregado = false;
                        _this.fecharPesquisa();
                    
                    });
                 }
                   
                           
                }
                this.fecharPesquisa = function () {
                    this.modalPesquisaCLiente.close();
                }
                this.ProximaPagina = function () {
                    _this.DadosClienteCarregado = false;
                    if (!_this.UltimaPagina) {                        
                        _this.PessoaSelecionada = -1;                        
                        _this.PaginaAtual++;
                        _this.crudSvc.PesquisarClientes(_this.filtrosPesquisaCLiente,_rootScope.currentUser.CAMINHO_DATABASE, _this.PaginaAtual).then(function (dados) {
                            if (dados){
                                _this.DadosPesquisaCliente =  dados; 
                                _this.DadosClienteCarregado = true;
                                if ((Object.keys(dados).length) < 100) {
                                    _this.UltimaPagina = true; 
                                }
                            }
                        });
                    }  
                }
                this.FiltrarPesquisa = function () {
                    _this.DadosClienteCarregado = false;  
                    _this.PessoaSelecionada = -1;                        
                    _this.PaginaAtual = 1;
                    _this.crudSvc.PesquisarClientes(_this.filtrosPesquisaCLiente,_rootScope.currentUser.CAMINHO_DATABASE, _this.PaginaAtual).then(function (dados) {
                        if (dados){
                            _this.DadosPesquisaCliente = {};
                            _this.DadosPesquisaCliente =  dados;  
                            _this.DadosClienteCarregado = true;       
                            if ((Object.keys(dados).length) < 100) {
                                _this.UltimaPagina = true; 
                            }                       
                        }
                    });
                }
                this.PaginaAnterior = function () {
                    _this.DadosClienteCarregado = false;
                    if (_this.PaginaAtual > 1) {
                       
                        _this.PessoaSelecionada = -1;                        
                        _this.PaginaAtual--;
                        _this.crudSvc.PesquisarClientes(_this.filtrosPesquisaCLiente,_rootScope.currentUser.CAMINHO_DATABASE, _this.PaginaAtual).then(function (dados) {
                            if (dados){
                                _this.DadosPesquisaCliente = {};
                                _this.DadosPesquisaCliente =  dados;  
                                _this.DadosClienteCarregado = true;                              
                            }
                        });
                    }                  

                }
                this.AbrirPesquisaClientes = function () {
                    _this.DadosClienteCarregado = false;
                    _this.crudSvc.PesquisarClientes(_this.filtrosPesquisaCLiente,_rootScope.currentUser.CAMINHO_DATABASE, 1).then(function (dados) {
                        if (dados) {        
                            _this.DadosPesquisaCliente = {};       
                            _this.DadosPesquisaCliente =  dados;   
                            _this.DadosClienteCarregado = true;
                            _this.modalPesquisaCLiente = $modal.open({
                                templateUrl: 'features/ativo/pesquisacliente.html',
                                resolve: {},
                                size: 'lg',
                                scope: $scope,  
                                backdrop: 'static',
                                rootScope: $rootScope
                            });
                        }                      
                    });
                   
                
                }

                this.AbrirModalPausa = function () {

                    _this.crudSvc.GetDate().then(function (dados) {
                        if (dados) {
                            _this.DataInicioPausa = dados;
                        };
                    });

                    this.tempoEmPausa = 0;
                    this.InicioPausa = true;
                    this.PausarSIP();
                    this.modalPausa = $modal.open({
                        templateUrl: 'features/ativo/pausa.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.TransferirLigacao = function () {
                   
                    if (this.telefonetransferir){
                        
                        var vDados = {};
                        vDados.FONE = this.telefonetransferir;
                        _this.crudSvc.Transferir(vDados);                       
                    }
                    else {
                        this.toaster.error("Atenção", "Preencha um numero para transferir!");
                    }                                  

                }

                this.AbrirModalTransferir = function () {                   
                    
                    this.modalTransferir = $modal.open({
                        templateUrl: 'features/ativo/transferir.html',
                        resolve: {},
                        size: 'sm',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.FecharTransferir = function () {
                   
                    this.modalTransferir.close();
                };

                this.FecharPausa = function () {
                    this.SairPausarSIP();
                    this.InicioPausa = false;
                    this.modalPausa.close();
                    this.PausarLigacoes = false;
                    this.TempoAntesProximoLigacao();
                };

                this.CalcTempoPausa = function () {

                    if (this.InicioPausa) {
                        this.tempoEmPausa = _this.tempoEmPausa + 1;

                        var tick = this.tempoEmPausa;
                        var secs = tick % 60;
                        tick = (tick - secs) / 60;
                        var mins = tick % 60;
                        tick = (tick - mins) / 60;
                        var hrs = tick;
                        this.tempoEmPausa_DISPLAY = (hrs < 10 ? "0" : "") + hrs + ":"
                            + (mins < 10 ? "0" : "") + mins + ":"
                            + (secs < 10 ? "0" : "") + secs;
                    }
                }

                this.cssPausa = function () {

                    if (this.tempoEmPausa > this.TEMPO_MAX_SEG) {

                        var vcalc = this.tempoEmPausa / 2;

                        if (vcalc & 1) {
                            return 'label label-danger';
                        } else {
                            return 'label label-primary';
                        }
                    }
                    else {
                        return 'label label-primary';
                    }
                }

                ExecutaStart();

                this.TempoDiscagem = function () {
                    var modalInstance = $modal.open({
                        templateUrl: 'tempodiscagem.html',
                        scope: $scope,
                        controller: 'ModalTempoDiscagemCtrl',
                        controllerAs: 'Ctrl'
                    });
                }
				
				

                this.AddFoneCampanha = function (pAREA, pFONE, pDESC_FONE) {

                    if (!this.ProximaLigacao.FonesCampanha) {
                        this.ProximaLigacao.FonesCampanha = [];
                    }

                    if (pFONE != '') {

                        if (pFONE.length <= 9) {
                            pFONE = pAREA + pFONE;
                        }

                        var vFone = {};
                        var i;
                        for (i = 0; i < this.ProximaLigacao.FonesCampanha.length; i++) {
                            if (this.ProximaLigacao.FonesCampanha[i].TELEFONE == pFONE) {
                                vFone = this.ProximaLigacao.FonesCampanha[i];
                                break;
                            }
                        }

                        if (vFone.TELEFONE) {
                            vFone.TELEFONE = pFONE;
                            vFone.TIPOFONE = pDESC_FONE;
                            this.ProximaLigacao.FonesCampanha[i] = vFone;
                        }
                        else {
                            vFone.TELEFONE = pFONE;
                            vFone.TIPOFONE = pDESC_FONE;
                            this.ProximaLigacao.FonesCampanha.push(vFone);
                        }

                        if (this.ProximaLigacao.FonesCampanha.length > 3) {
                            var vlist = this.ProximaLigacao.FonesCampanha;

                            this.ProximaLigacao.FonesCampanha = [];

                            for (i = 0; i < vlist.length; i++) {
                                if (i > 0) {
                                    this.ProximaLigacao.FonesCampanha.push(vlist[i]);
                                }
                            }

                        }
                    }
                }

                this.AbrirModalFinalizar = function () {
                    this.OperacaoFinalizada = 0;
                    this.COMPRAS = {};
                    this.FonesCliente = [];

                    if (this.ProximaLigacao.DadosLigacao.Finalizar.TELEFONE.charAt(0) == '0') {
                        this.ProximaLigacao.DadosLigacao.Finalizar.TELEFONE =
                            this.ProximaLigacao.DadosLigacao.Finalizar.TELEFONE.substring(1, 15);
                    } else {
                        this.ProximaLigacao.DadosLigacao.Finalizar.TELEFONE =
                            this.ProximaLigacao.AREA1 + this.ProximaLigacao.FONE1;
                    }

                    this.FonesCliente.push(
                        {
                            FONE: this.ProximaLigacao.AREA1 + this.ProximaLigacao.FONE1,
                            DESCRICAO: this.ProximaLigacao.AREA1 + this.ProximaLigacao.FONE1
                        }
                    );

                    if (this.ProximaLigacao.FONE2) {
                        this.FonesCliente.push(
                            {
                                FONE: this.ProximaLigacao.AREA2 + this.ProximaLigacao.FONE2,
                                DESCRICAO: this.ProximaLigacao.AREA2 + this.ProximaLigacao.FONE2
                            });
                    }

                    if (this.ProximaLigacao.FONE3) {
                        this.FonesCliente.push(
                            {
                                FONE: this.ProximaLigacao.AREA3 + this.ProximaLigacao.FONE3,
                                DESCRICAO: this.ProximaLigacao.AREA3 + this.ProximaLigacao.FONE3
                            });
                    }

                    this.ProximaLigacao.DadosLigacao.Finalizar.OperadorDelegar = -1;
                    this.modalFinalizar = $modal.open({
                        templateUrl: 'features/ativo/finalizar.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.FecharFinalizar = function () {
                    this.modalFinalizar.close();
                };

                this.AbrirModalreceptivo = function () {
                  
                    if (_this.receptivoVisivel) {
                        this.modalReceptivo.close(); 
                    }
                    _this.receptivoVisivel = true;
                    this.modalReceptivo = $modal.open({
                        templateUrl: 'features/ativo/receptivo.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.AbrirModalTeclado = function () {
                  
                   if (_this.tecladoVisivel) {
                        this.modalTeclado.close(); 
                    }
                    _this.tecladoVisivel = true;
                    this.modalTeclado = $modal.open({
                        templateUrl: 'features/ativo/tecladovirtual.html',
                        resolve: {},
                        size: 'sm',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    }); 

                }

                this.FecharTeclado = function () {
                    this.modalTeclado.close();
                    _this.tecladoVisivel  = false;
                };
                this.FecharReceptivo = function () {
                    _this.receptivoVisivel = false;
                    _this.RecebendoChamada = false;
                    this.modalReceptivo.close();
                };
                setInterval(function () {
                    var i = 0;
                    var loop = setInterval(function(){                      
                      if(i == 10){
                         clearInterval(loop);
                      }
                      i++;
                    }, 2000);
                    if (_this.TempoAguardeLigacao > 0) {
                        _this.toaster.info("Aguarde . . .", "Tempo para início da discagem: "
                            + _this.TempoAguardeLigacao);
                        _this.TempoAguardeLigacao = _this.TempoAguardeLigacao - 1;
                    }
                    else if (_this.TempoAguardeLigacao == 0) {
                        _this.TempoAguardeLigacao = -1;
                        _this.toaster.clear();

                        if (_this.ProximaLigacao && _this.ProximaLigacao.DadosLigacao && !_this.SipDemo() ) {
                            _this.crudSvc.Ligar(_this.ProximaLigacao.DadosLigacao);
                        }
                    }
                    if (!_this.SipDemo()) {
                        _this.GetStateLigacao()
                  }
                   

                    _this.calcTempoTotal();

                    _this.CalcTempoPausa();

                    if (timestampLigacao) {
                        _this.calcTempoLigacao();
                        _this.calcTempoTotalLigacoes();
                    }

                }, Math.abs(1) * 1000);

                this.calcTempoTotal = function () {
                    timestamp = new Date(timestamp.getTime() + 1 * 1000);

                    if (timestamp.getHours().toString().length == 1)
                        _this.tempoTotal = '0' + timestamp.getHours().toString()
                    else
                        _this.tempoTotal = timestamp.getHours().toString();

                    if (timestamp.getMinutes().toString().length == 1)
                        _this.tempoTotal = _this.tempoTotal + ':0' + timestamp.getMinutes().toString()
                    else
                        _this.tempoTotal = _this.tempoTotal + ':' + timestamp.getMinutes().toString();

                    if (timestamp.getSeconds().toString().length == 1)
                        _this.tempoTotal = _this.tempoTotal + ':0' + timestamp.getSeconds().toString()
                    else
                        _this.tempoTotal = _this.tempoTotal + ':' + timestamp.getSeconds().toString();
                }

                this.calcTempoLigacao = function () {
                    timestampLigacao = new Date(timestampLigacao.getTime() + 1 * 1000);

                    if (timestampLigacao.getHours().toString().length == 1)
                        _this.tempoLigacao = '0' + timestampLigacao.getHours().toString()
                    else
                        _this.tempoLigacao = timestampLigacao.getHours().toString();

                    if (timestampLigacao.getMinutes().toString().length == 1)
                        _this.tempoLigacao = _this.tempoLigacao + ':0' + timestampLigacao.getMinutes().toString()
                    else
                        _this.tempoLigacao = _this.tempoLigacao + ':' + timestampLigacao.getMinutes().toString();

                    if (timestampLigacao.getSeconds().toString().length == 1)
                        _this.tempoLigacao = _this.tempoLigacao + ':0' + timestampLigacao.getSeconds().toString()
                    else
                        _this.tempoLigacao = _this.tempoLigacao + ':' + timestampLigacao.getSeconds().toString();
                }

                this.calcTempoTotalLigacoes = function () {
                    // debugger;
                    var timestamptot = new Date(_this.timestampLigacaoTotal.getTime() + 1 * 1000);
                    _this.timestampLigacaoTotal = timestamptot;

                    if (_this.timestampLigacaoTotal.getHours().toString().length == 1)
                        _this.tempoTotalLigacao = '0' + _this.timestampLigacaoTotal.getHours().toString()
                    else
                        _this.tempoTotalLigacao = _this.timestampLigacaoTotal.getHours().toString();

                    if (_this.timestampLigacaoTotal.getMinutes().toString().length == 1)
                        _this.tempoTotalLigacao = _this.tempoTotalLigacao + ':0' + _this.timestampLigacaoTotal.getMinutes().toString()
                    else
                        _this.tempoTotalLigacao = _this.tempoTotalLigacao + ':' + _this.timestampLigacaoTotal.getMinutes().toString();

                    if (_this.timestampLigacaoTotal.getSeconds().toString().length == 1)
                        _this.tempoTotalLigacao = _this.tempoTotalLigacao + ':0' + _this.timestampLigacaoTotal.getSeconds().toString()
                    else
                        _this.tempoTotalLigacao = _this.tempoTotalLigacao + ':' + _this.timestampLigacaoTotal.getSeconds().toString();
                }

                this.PesquisarCidades = function () {
                    if (!this.ProximaLigacao.ESTADO) {
                        _this.toaster.error("Atenção", "Selecione um Estado!");
                    }
                    else {
                        _this.crudSvc.PesquisarCidades(this.ProximaLigacao.ESTADO,
                            _rootScope.currentUser.CAMINHO_DATABASE).then(function (dados) {
                                if (dados) {
                                    _this.CidadeLook = dados;
                                };
                            });
                    }
                }

                this.GravarPausa = function (ptipo) {

                    if (this.MotivoPausa) {
                        var vObjPausa = {};
                        vObjPausa.DataBase = _rootScope.currentUser.CAMINHO_DATABASE;
                        vObjPausa.OBS = this.MotivosPausaDescricao;
                        vObjPausa.COD_PAUSA = this.MotivoPausa;
                        vObjPausa.OPERADOR = _rootScope.currentUser.id;
                        vObjPausa.DataInicioPausa = this.DataInicioPausa;

                        _this.crudSvc.GravarPausa(vObjPausa);

                        if (ptipo == 1) { //logof

                            _this.modalPausa.close();
                            security.logout();

                        } else { //sair
                            this.FecharPausa();
                        }
                    }
                    else {
                        _this.toaster.error("Atenção", "Informe o Motivo da Pausa!");
                    }
                }

                _this.FiltroAgenda = {};
                _this.NovaAgenda = {};
                _this.FiltroAgenda.OPERADOR = _rootScope.currentUser.id;
                _this.FiltroAgenda.DATABASE = _rootScope.currentUser.CAMINHO_DATABASE;
                _this.NovaAgenda.DATABASE = _rootScope.currentUser.CAMINHO_DATABASE;
                _this.FiltroAgenda.CLIENTE_ATIVO = 'SIM';
                _this.FiltroAgenda.CLIENTE_EXCECAO = 'TODOS';

                this.AtualizarAgenda = function () {
                    _this.crudSvc.AtualizarAgenda(_this.FiltroAgenda).then(function (dados) {

                        if (dados) {
                            _this.DadosAgenda = dados;
                            _this.HistoricoCliente = null;
                        };
                    });
                }

                this.SetCliente = function (item) {
                    _this.NovaAgenda = {};
                    _this.NovaAgenda.DATABASE = _rootScope.currentUser.CAMINHO_DATABASE;
                    _this.NovaAgenda.CLIENTE = item.CODIGO_CLIENTE;   
                }

                this.CadastraNovoAgendamento = function () {                   
                     _this.crudSvc.CadastraNovoAgendamento(_this.NovaAgenda);                  
                    this.modalNovoAgendamento.close();    

                }
                this.ValidaNovoAgenda = function ( ){
                    if (_this.NovaAgenda.DATA) {
                        if (!_this.NovaAgenda.PRIORIDADE) {
                            _this.toaster.error("Atenção", "Informe a prioridade do agendamento!");
                        }
                        else {
                            if (!_this.NovaAgenda.HORA) {
                                const d = new Date();
                                 _this.NovaAgenda.HORA = d.getHours()+':'+d.getMinutes();   
                             }
                             _this.CadastraNovoAgendamento() ;
                             _this.AtualizarAgenda();
                            
                        }
                       
                    }
                    else {
                        _this.toaster.error("Atenção", "Informe a data do agendamento!");
                    }
                }
                this.FecharAgenda = function () {
                    this.modalAgenda.close();
                };

                this.FecharNovoAgendamento = function () {
                    this.modalNovoAgendamento.close();
                };

                this.AbrirNovoAgendamento = function(){                    
                    if (!this.NovaAgenda.CLIENTE) {
                        _this.toaster.error("Atenção", "Selecione o cliente!");
                        return false;
                    }
                    _this.DATA = {};
                    _this.NovaAgenda.HORA = '';
                    _this.NovaAgenda.DATA = '';
                    _this.NovaAgenda.PRIORIDADE = '';
                    this.modalNovoAgendamento = $modal.open({
                        templateUrl: 'features/ativo/novoagendamento.html',
                        resolve: {},
                        size: 'sm',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.AbrirModalAgenda = function () {

                    this.AtualizarAgenda();
                    this.modalAgenda = $modal.open({
                        templateUrl: 'features/ativo/agendacliente.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.AtualizarPropostasCliente = function () {
                    if (!_this.FiltroPropostasCliente) {
                        _this.FiltroPropostasCliente = {};
                    }

                    if (_this.FiltroPropostasCliente.CLIENTE != this.ProximaLigacao.id) {
                        _this.FiltroPropostasCliente = {};
                    }

                    _this.FiltroPropostasCliente.CLIENTE = this.ProximaLigacao.id;
                    _this.crudSvc.AtualizarPropostasCliente(_this.FiltroPropostasCliente,
                        _rootScope.currentUser.CAMINHO_DATABASE).then(function (dados) {

                            if (dados) {
                                _this.DadosPropostasCliente = dados;
                            };
                        });
                }

                this.ConfirmarPropostasCliente = function () {

                    if (!this.COMPRAS) {
                        _this.toaster.error("Atenção", "Informe os dados da Venda!");
                        return false;
                    }

                    if (!this.COMPRAS.DESCRICAO) {
                        _this.toaster.error("Atenção", "Informe a descrição da Venda!");
                        return false;
                    }

                    if (!this.COMPRAS.VALOR) {
                        _this.toaster.error("Atenção", "Informe o valor da Venda!");
                        return false;
                    }

                    // _this.ProximaLigacao.DadosLigacao.Finalizar.EVENDA = '';
                    // _this.COMPRAS.CLIENTE = this.ProximaLigacao.id;      
                    _this.COMPRAS.DadosPropostasCliente = _this.DadosPropostasCliente;
                    // _this.COMPRAS.DataBase = _rootScope.currentUser.CAMINHO_DATABASE; 
                    _this.FecharPropostasCliente();
                    // _this.crudSvc.ConfirmarPropostasCliente(_this.COMPRAS).then(function (dados){

                    //   if (dados){
                    //     _this.FecharPropostasCliente();
                    //     _this.FinalizarLigacao();
                    //   };
                    // });
                }

                this.AbrirModalPropostasCliente = function () {

                    this.AtualizarPropostasCliente();
                    this.modalPropostasCliente = $modal.open({
                        templateUrl: 'features/ativo/propostascliente.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.FecharPropostasCliente = function () {
                    this.modalPropostasCliente.close();
                };

                this.AbrirHistorico = function (pItem) {

                    _this.crudSvc.AbrirHistorico(pItem.CODIGO_CLIENTE,
                        _this.FiltroAgenda.DATABASE).then(function (dados) {

                            if (dados) {
                                _this.HistoricoCliente = dados;
                            };
                        });
                }

                this.AbrirNovoContato = function () {
                    this.NovoContato = {};
                    this.NovoContato.DataBase = _rootScope.currentUser.CAMINHO_DATABASE
                    this.NovoContato.CLIENTE = this.ProximaLigacao.id;

                    this.modalNovoContato = $modal.open({
                        templateUrl: 'features/ativo/novocontato.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });
                }

                this.ConfirmarNovoContato = function () {
                    if (_this.SelectedCargo)
                        _this.NovoContato.CARGO = _this.SelectedCargo.id;

                    this.crudSvc.GravarContato(_this.NovoContato).then(function (dados) {
                        if (dados) {
                            _this.NovoContato.APELIDO = _this.NovoContato.TRATAMENTO;

                            if (_this.SelectedCargo)
                                _this.NovoContato.CARGO_DESCRICAO = _this.SelectedCargo.DESCRICAO;

                            if (!_this.NovoContato.id) {
                                _this.NovoContato.id = dados.id;

                                if (!_this.ProximaLigacao.NOME_CONTATO) {
                                    _this.ProximaLigacao.NOME_CONTATO = _this.NovoContato.NOME;
                                }

                                _this.ProximaLigacao.Contatos.push(_this.NovoContato);
                            }

                            _this.FecharNovoContato();
                        };

                    });
                }

                this.EditContato = function (item) {
                    this.NovoContato = item;
                    this.NovoContato.DataBase = _rootScope.currentUser.CAMINHO_DATABASE;

                    for (var i = 0; i < _this.DadosStart.Cargos.length; i++) {
                        if (_this.DadosStart.Cargos[i].id === item.CARGO) {
                            this.SelectedCargo = _this.DadosStart.Cargos[i];
                            break;
                        }
                    }

                    this.modalNovoContato = $modal.open({
                        templateUrl: 'features/ativo/novocontato.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });
                }

                this.DelContato = function (item) {

                    _this.SweetAlert.swal({
                        title: "Deseja excluir esse contato?",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "Sim",
                        cancelButtonText: "Nao"
                    }, function (isConfirm) {

                        if (isConfirm) {

                            _this.crudSvc.DeletarContato(item).then(function (dados) {

                                if (dados) {
                                    for (var i = 0; i < _this.ProximaLigacao.Contatos.length; i++) {
                                        if (_this.ProximaLigacao.Contatos[i].id === item.id) {
                                            _this.ProximaLigacao.Contatos.splice(i, 1);
                                            return;
                                        }
                                    }
                                };

                            });
                        }
                    });
                }

                this.FecharNovoContato = function () {
                    this.modalNovoContato.close();
                };

                this.FecharEnviarEmail = function () {
                    this.modalEnviarEmail.close();
                };

                this.ChangePrioridade = function () {

                    if (!this.EnviarEmail) {
                        this.EnviarEmail = {};
                        this.EnviarEmail.PRIORIDADE = 'Alta';
                    }

                    if (this.SelectedPrioridade) {
                        this.EnviarEmail.PRIORIDADE = this.SelectedPrioridade.PRIORIDADE;
                    }

                }

                this.AbrirModalEnviarEmail = function () {

                    if (!this.EnviarEmail) {
                        this.EnviarEmail = {};
                        this.EnviarEmail.PRIORIDADE = 'Alta';
                    }

                    if (this.ConfigMail) {
                        this.EnviarEmail = angular.copy(this.ConfigMail);
                        //    this.EnviarEmail.COPIA = this.ConfigMail.COPIA;
                        //    this.EnviarEmail.COPIAOCULTA = this.ConfigMail.COPIAOCULTA;
                        //    this.EnviarEmail.CONFIRMACAOLEITURA = this.ConfigMail.CONFIRMACAOLEITURA;  
                        //    this.EnviarEmail.OPERADOR_NAME = _rootScope.currentUser.LOGIN;                    

                        var str = this.ConfigMail.TEXTO;
                        str = str.replace("<RAZAO_SOCIAL>", this.ProximaLigacao.RAZAO);
                        str = str.replace("<NOME_OPERADOR>", _rootScope.currentUser.LOGIN);
                        str = str.replace("<CONTATO_MAIL>", this.ProximaLigacao.CONTATO_MAIL);
                        str = str.replace("<CODIGO_CLI>", this.ProximaLigacao.id);
                        str = str.replace("<ASSINATURA>", this.ProximaLigacao.DadosLigacao.ASSINATURA);

                        this.EnviarEmail.TEXTO = str;
                    }

                    this.EnviarEmail.OPERADOR = _rootScope.currentUser.id;
                    this.EnviarEmail.DataBase = _rootScope.currentUser.CAMINHO_DATABASE;
                    this.EnviarEmail.PARA = this.ProximaLigacao.EMAIL;

                    this.modalEnviarEmail = $modal.open({
                        templateUrl: 'features/ativo/enviaremail.html',
                        resolve: {},
                        size: 'lg',
                        scope: $scope,
                        backdrop: 'static',
                        rootScope: $rootScope
                    });

                }

                this.ChangeConfigMail = function (item) {
                    this.ProximaLigacao.DadosLigacao.Finalizar.TIPO_EMAIL = this.SelectedTipoEmail.id;
                    this.ConfigMail = this.SelectedTipoEmail;
                }

                this.ConfirmarEnviarEmail = function () {

                    this.crudSvc.EnviarEmail(this.EnviarEmail).then(function (dados) {
                        if (dados) {
                            _this.FecharEnviarEmail();
                            _this.toaster.info("Atenção", "E-mail enviado com sucesso!");
                        };
                    });
                }

                this.InserirAnexo = function () {

                    if (!this.myFile) {
                        return;
                    }

                    var vfile = this.myFile;
                    var vNovoAnexo = {};
                    vNovoAnexo.NOME = vfile.filename;
                    vNovoAnexo.FILEBASE64 = vfile.base64;
                    vNovoAnexo.OPERADOR = _rootScope.currentUser.id;

                    if (!this.EnviarEmail.Anexos) {
                        this.EnviarEmail.Anexos = [];
                    }

                    this.EnviarEmail.Anexos.push(vNovoAnexo);
                    this.myFile = null;
                }

                this.DelAnexo = function (item) {
                    for (var i = 0; i < _this.EnviarEmail.Anexos.length; i++) {
                        if (_this.EnviarEmail.Anexos[i].NOME === item.NOME) {
                            _this.EnviarEmail.Anexos.splice(i, 1);
                            return;
                        }
                    }
                };

                $scope.$on('onBeforeUnload', function (e, confirmation) {
                    //_this.AbrirModalPausa();
                    confirmation.message = "Você não pode sair do sistema sem estar em pausa, sua produtividade será perdida.";
                    e.preventDefault();
                });

                $scope.$on('onUnload', function (e) {
                    console.log('leaving page'); // Use 'Preserve Log' option in Console
                    _this.unRegister();
                    console.log('unregister page'); 
                });

            }

            CrudAtivoCtrl.prototype.crud = function () {
                return "Ativo";
            };

            CrudAtivoCtrl.prototype.buscar = function () {
                return null;
            };

            // CrudAtivoCtrl.prototype.ultimoTermo = function () {
            //     return '';
            // };            

            CrudAtivoCtrl.prototype.overrideApenasConsulta = function () {
                return true;
            }

            return CrudAtivoCtrl;
        })(Controllers.CrudBaseEditCtrl);
        Controllers.CrudAtivoCtrl = CrudAtivoCtrl;

        App.modules.Controllers.controller('CrudAtivoCtrl', CrudAtivoCtrl);
		App.modules.Controllers.controller('wysiwygeditor', wysiwygeditor);
    })(Controllers = App.Controllers || (App.Controllers = {}));
})(App || (App = {}));

