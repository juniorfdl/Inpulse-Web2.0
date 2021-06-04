

var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};

var App;
(function (App) {
    var Services;
    (function (Services) {
        "use strict";
        var CrudAtivoService = (function (_super) {
            __extends(CrudAtivoService, _super);

            function CrudAtivoService($q, api, luarApp, $location) {
                _super.apply(this, arguments);

                this.Ligar = function (pDados){   
                   
                                    
                    var vURL = luarApp.APISIP;
                    var params = {};
                    params.Telefone = pDados.Finalizar.TELEFONE;
                    params.CodigoLigacao = pDados.CODIGO;
                    params.NomeOperador = pDados.NOME_OPERADOR;
                    debugger;
                    return this.api.invokePostDirectRestWD('LigarSIP',params,vURL);
                }

                this.EnviarDTMF = function (pDados){
                    var vURL = luarApp.APISIP;
                    var params = {};
                    params.Telefone = pDados.FONE;
                    return this.api.invokePostDirectRestWD('EnviarDTMFSIP',params,vURL);
                }

                this.Transferir = function (pDados){
                    var vURL = luarApp.APISIP;
                    var params = {};
                    params.Telefone = pDados.FONE;
                    return this.api.invokePostDirectRestWD('TransferirSIP',params,vURL);
                }

                this.SetMicVolume = function (volume) {
                    var vURL = luarApp.APISIP;
                    var params = {};
                    this.api.invokePostDirectRestWD('SetVolumeMic' + '/' +volume, params, vURL);
                }
                this.SetPhoneVolume = function (volume) {
                    var vURL = luarApp.APISIP;
                    var params = {};
                    this.api.invokePostDirectRestWD('SetVolumePhone' + '/' +volume, params, vURL);
                }

                this.SetMicMute = function (mute) {
                    var vURL = luarApp.APISIP;
                    var params = {};
                    this.api.invokePostDirectRestWD('SetMuteMic' + '/' +mute, params, vURL);
                }
                this.SetPhoneMute = function (volume) {
                    var vURL = luarApp.APISIP;
                    var params = {};
                    this.api.invokePostDirectRestWD('SetMutePhone' + '/' +volume, params, vURL);
                }
                this.Desligar = function (pFone){
                    var params = {};
                    var vURL = luarApp.APISIP;  
                    return this.api.invokePostDirectRestWD('DesligarSIP',params,vURL);
                }
                
                this.RenameRecord = function (id){
                    var params = {};
                    var vURL = luarApp.APISIP;  
                    return this.api.invokePostDirectRestWD('RenameRecord/' + id, params,vURL);
                }

                this.unRegister = function (){
                    var params = {};
                    var vURL = luarApp.APISIP;               
                    
                    return this.api.invokePostDirectRestWD('UnRegisterSIP','',vURL);
                   
                }

                this.State = function (){
                    var params = {};
                    var vURL = luarApp.APISIP;
                    //return this.api.invokePostDirect('State',params,vURL);
                    return this.api.invokePostDirectRestWD('StateSIP',params,vURL);
                }

                this.PesquisarClientes = function (pFiltro, pCAMINHO_BANCO, Page){
                    return this.api.get('PesquisaClientes/'+pFiltro+'/'+ pCAMINHO_BANCO+ '/' + Page);
                }

                this.StateToDesc = function (pCodStatus, pCAMINHO_BANCO){
                    return this.api.get('DescricaoStatus/'+pCodStatus+'/'+ pCAMINHO_BANCO);
                }

                this.SetStatusLigacao = function (pOperador,pStatus, pCAMINHO_BANCO){                    

                    return this.api.get('SetStatusLigacao/'+pStatus+'/'+pOperador+'/'+pCAMINHO_BANCO);
                }                

                this.Registrar = function (pDados){                    
                    var vURL = luarApp.APISIP;
                    if (pDados.SIP_MODO === 'DEMO') {
                        return true;
                    }
                    //return this.api.invokePost('Registrar',pDados,"http://localhost:8082/registrar");
                    return this.api.invokePostDirectRestWD('RegistrarSIP',pDados,vURL);            
                }

                this.PausarSIP = function (){                    
                    var vURL = luarApp.APISIP;
                    var pDados = {};
                    //return this.api.invokePost('Registrar',pDados,"http://localhost:8082/registrar");
                    return this.api.invokePostDirectRestWD('PausarSIP',pDados,vURL);            
                }

                this.SairPausarSIP = function (){                    
                    var vURL = luarApp.APISIP;
                    var pDados = {};
                    //return this.api.invokePost('Registrar',pDados,"http://localhost:8082/registrar");
                    return this.api.invokePostDirectRestWD('SairPausaSIP',pDados,vURL);            
                }

                this.GetProximaLigacao = function (operador, CAMINHO_BANCO) { 
                    var params = {}; 
                    params.DATABASE = CAMINHO_BANCO;   
                    params.operador = operador;                 
                    return this.api.invokePost('ProximaLigacao', params);
                };

                this.GetDadosRecebendoLigacao = function (pFone, CAMINHO_BANCO, operador) { 
                    var params = {};                     
                    return this.api.get('DadosRecebendoLigacao/'+pFone+'/'+CAMINHO_BANCO+'/'+operador, params);
                };

                this.BuscarDadosCliente = function (pCodCli, CAMINHO_BANCO, operador) { 
                    var params = {};                     
                    return this.api.get('BuscaDadosRecebendoLigacao/'+pCodCli+'/'+CAMINHO_BANCO+'/'+operador, params);
                };

                this.BuscaCampanhas = function (CAMINHO_BANCO) { 
                    var params = {};                     
                    return this.api.get('Campanhas/'+CAMINHO_BANCO, params);
                };

                this.FinalizarLigacao = function (pDados, pDemo){                   

                    if (pDados.DadosLigacao.Finalizar.HORA){
                        var vHra = new Date(pDados.DadosLigacao.Finalizar.HORA.getTime());
                        vHra = vHra.getHours().toString()+':'+vHra.getMinutes().toString();
                        pDados.DadosLigacao.Finalizar.HORA = vHra;                            
                    }
                    if (!pDemo) {
                        this.Desligar();
                    }
                    
                    return this.api.invokePost('FinalizarLigacao', pDados);                    
                }

                this.LiberarLigacao = function (operador) {
                    return this.api.allLook(null, 'TAtivo/liberar');
                };

                this.GetStart = function (pCAMINHO_BANCO) {                    
                    return this.api.get('Start/'+ pCAMINHO_BANCO);
                };

                this.PesquisarCidades = function (pUF, pCAMINHO_BANCO) {
                    return this.api.allLook(null, 'TAtivo/Cidades/'+pUF+'/'+pCAMINHO_BANCO);
                };

                this.GravarPausa = function (pDados){                    
                    return this.api.invokePost('GravarPausa', pDados);                    
                }

                this.CadastraNovoAgendamento = function (pDados){                    
                    this.api.invokePost('NovoAgendamento', pDados);                    
                }

                this.GetDate = function (){                    
                    return this.api.get('GetDate');                   
                }

                this.AtualizarAgenda = function (pDados){                    
                    return this.api.invokePost('Agenda', pDados);                    
                }

                this.AbrirHistorico = function(pCodigo_Cliente, pBASEDADOS){
                    return this.api.get('HistoricoCliente/'+ pCodigo_Cliente +'/'+ pBASEDADOS);
                }

                this.AtualizarPropostasCliente = function(pDados, pBASEDADOS){

                    var pDATA_INICIAL = '0';
                    var pDATA_FINAL = '0';
                    var pUTILIZADAS = 'NAO';

                    if (pDados.UTILIZADAS){
                        pUTILIZADAS = pDados.UTILIZADAS;
                    }

                    if (pDados.DATA_INICIAL){
                        pDATA_INICIAL = pDados.DATA_INICIAL;
                    }

                    if (pDados.DATA_FINAL){
                        pDATA_FINAL = pDados.DATA_FINAL;
                    }

                    return this.api.get('PropostasCliente/'+ pDados.CLIENTE 
                    +'/'+ pDATA_INICIAL 
                    +'/'+ pDATA_FINAL
                    +'/'+ pUTILIZADAS
                    +'/'+ pBASEDADOS);                    
                }

                this.ConfirmarPropostasCliente = function (pDados){
                    return this.api.invokePost('ConfirmaVenda', pDados);
                }  

                this.EnviarEmail = function (pDados){
                    return this.api.invokePost('EnviarEmail', pDados);
                }
                
                this.GravarContato = function (pDados){
                    return this.api.invokePost('GravarContato', pDados);
                }

                this.DeletarContato = function (item){
                    return this.api.invokePost('DeletarContato', item);
                }

                this.uploadFile = function (file, pOperador) {
                    var fileFormData = {};
                    fileFormData.file = file.base64;
                    fileFormData.filename = file.filename;
                    fileFormData.operador = pOperador;
                    return this.api.invokePost('uploadFile', fileFormData);
                }
            }            

            Object.defineProperty(CrudAtivoService.prototype, "baseEntity", {
                /// @override
                get: function () {
                    return 'TAtivo';
                },
                enumerable: true,
                configurable: true
            });            
   
            return CrudAtivoService;
        })(Services.CrudBaseService);
        Services.CrudAtivoService = CrudAtivoService;
        App.modules.Services
            .service('CrudAtivoService', CrudAtivoService);
    })(Services = App.Services || (App.Services = {}));
})(App || (App = {}));
//# sourceMappingURL=services.js.map