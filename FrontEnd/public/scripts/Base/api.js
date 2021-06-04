var App;
(function (App) {
    var Services;
    (function (Services) {
        'use strict';
        /**
         * Interface de configuração da API.
         *
         * ~~~
         * angular.module('app').config(function(apiProvider: App.Services.ApiProvider) {
         *     apiProvider.setBaseUrl("/api");
         * });
         * ~~~
         *
         */
        var ApiProvider = (function () {
            function ApiProvider() {
            }
            /**
             * Retorna a URL configurada do back-end.
             */
            ApiProvider.prototype.getBaseUrl = function () {
                return this.baseUrl;
            };
            /**
             * Configura a URL do back-end.
             *
             * ~~~
             * apiProvider.setBaseUrl("/api");
             * ~~~
             *
             * @param baseUrl   Prefixo das APIs no back-end.
             */
            ApiProvider.prototype.setBaseUrl = function (baseUrl) {
                this.baseUrl = baseUrl.toString().toLowerCase();
            };
            /**
             * @private
             * Método de suporte do AngularJS. Não invocar diretamente.
             */
            /* @ngInject */
            ApiProvider.prototype.$get = function ($http, $q, TratarErroDaApi, intercept, toaster) {
                var _this = this;
                return function (api) {
                    return new ApiService(_this.baseUrl + '/' + api, $http, $q, TratarErroDaApi, intercept, toaster);
                };
            };
            return ApiProvider;
        })();
        Services.ApiProvider = ApiProvider;
        /**
         * Interface para operações de CRUD no back-end.
         */
        var ApiService = (function () {
            /**
             * @private
             */
            function ApiService(api, $http, $q, TratarErroDaApi, intercept, toaster) {

                this.api = api;
                this.$http = $http;
                this.$q = $q;
                this.TratarErroDaApi = TratarErroDaApi;
                this.intercept = intercept;
                this.toaster = toaster;

                var posicao = this.api.toLowerCase().indexOf("/datasnap/rest") + 14;
                this.apibase = this.api.substr(0, posicao);
            }
            ApiService.prototype.fetch = function (url, params) {
                var _this = this;
                return this.$http.get(url, params ? { params: params } : null).then(function (response) {
                    if (angular.isObject(response.data) && response.data.lista) {
                        var lista = response.data.lista;
                        lista.$totalCount = response.data.totalCount;
                        lista.$pageSize = params ? params.itensPorPagina : null;
                        lista.$params = params;
                        return lista;
                    }

                    if (response.data.result) {
                        return response.data.result[0];
                    }

                    return response.data;
                }).catch(function (data) {

                    if (data && data.data) {
                        if (data.data.error) {
                            _this.toaster.error("Atenção", data.data.error);
                            return null;
                        }
                        else {
                            return _this.$q.reject(_this.TratarErroDaApi(data));
                        }
                    }
                });
            };
            /**
             * Obtem uma lista de registros.
             *
             * ~~~
             * api("TipoImovel")
             *     .all()
             *     .then(result => this.listaTipoImovel = result);
             * ~~~
             *
             * @param params    Parâmetros passados para a query string.
             * @returns         Promise para a lista de registros.
             */
            ApiService.prototype.all = function (params) {
                return this.fetch(this.api, params);
            };

            ApiService.prototype.allLook = function (params, look) {
                return this.fetch(this.apibase + '/' + look, params);
            };

            ApiService.prototype.allExterna = function (params, api) {
                return this.fetch(api, params);
            };

            /**
             * Obtem um registro através do seu identificador.
             *
             * ~~~
             * api("TipoImovel")
             *     .get(20)
             *     .then(result => this.selected = result);
             * ~~~
             *
             * @param id    Identificar do registro, conforme indicado por [[ApiEntity.id]].
             * @returns     Promise para o registro retornado.
             */
            ApiService.prototype.get = function (id) {
                return this.$http.get(this.api + '/' + id).then(function (response) {

                    if (response.data.result) {
                        return response.data.result[0];
                    }

                    return response.data;
                });
            };

            /**
             * Obtem uma lista de registros através de um comando específico da entidade.
             *
             * ~~~
             * api("Imovel")
             *     .query("localizar", {endereco: "Rua Indepêndencia 123"})
             *     .then(result => this.listaImovel = result);
             * ~~~
             *
             * @param method    Nome do método disponibilizado pelo back-end.
             * @param params    Parâmetros passados para a query string.
             * @returns         Promise para o retorno do back-end.
             */
            ApiService.prototype.query = function (method, params) {
                return this.fetch(this.api + "/" + method, params);
            };
            /**
             * Obtem uma lista de registros através de um comando específico da entidade.
             *
             * ~~~
             * api("TipoImovel")
             *     .command(1, "caracteristicas")
             *     .then(result => this.listaCaracteristicas = result);
             * ~~~
             *
             * @param id        Parâmetros passados para a query string.
             * @param method    Nome do método disponibilizado pelo back-end.
             * @returns         Promise para o retorno do back-end.
             */
            ApiService.prototype.relation = function (id, method) {
                var parameters = [];
                for (var _i = 2; _i < arguments.length; _i++) {
                    parameters[_i - 2] = arguments[_i];
                }
                var args = parameters ? '/' + parameters.join('/') : '';
                return this.$http.get(this.api + "/" + id + "/" + method + args).then(function (response) { return response.data; });
            };
            /**
             * Envia um registro para ser salvo no back-end.
             *
             * ~~~
             * api("TipoImovel")
             *     .save(selected);
             * ~~~
             *
             * @param entity    Registro a ser salvo. Em caso de sucesso, o objeto é atualizado com o retorno do back-end.
             * @returns         Promise para o registro atualizado.
             */
            ApiService.prototype.save = function (entity) {
                var _this = this;
                var url = this.api;// + (entity.id ? '/' + entity.id : '');
                var method = 'POST';//entity.id ? 'PUT' : 'POST';

                if (entity.id == null) {
                    entity.id = 0;
                }

                return this.$http({
                    method: method,
                    url: url,
                    data: entity
                }).then(function (response) {
                    var payload = (response.data || {});

                    if (response.data.result) {
                        payload = response.data.result[0];
                    }

                    payload.$status = response.status;

                    if (response.status != 201 && response.data.error != null) {
                        _this.toaster.error("Atenção", response.data.error);
                    } else {
                        _this.toaster.success("Atenção", "Operação executada com sucesso!");

                        return angular.extend(entity, payload);
                    }

                }).catch(function (data) {

                    if (data && data.data) {
                        if (data.data.error) {
                            _this.toaster.error("Atenção", data.data.error);
                            return null;
                        }
                        else {
                            return _this.$q.reject(_this.TratarErroDaApi(data));
                        }
                    }

                });
            };
            /**
             * Executa um POST para o método solicitado.
             *
             * URI's aceitas:
             *
             *  * /entity
             *  * /entity/action
             *  * /entity/id/action
             *
             * ~~~
             * api("Login")
             *     .invoke(null);
             * api("User")
             *     .invoke("ResetPassword", user.id);
             * ~~~
             *
             * @param method    Nome da action. Para invocar a action padrão da API, passar null.
             * @param id        Identificador do registro, caso requerido pela action.
             * @param headers   Headers específicos desta requisição.
             * @returns         Promise para o retorno da action.
             */
            ApiService.prototype.invoke = function (method, id, headers, apiExterna) {

                var _this = this;
                var _api = this.api;

                if (apiExterna) {
                    _api = apiExterna;
                }

                var url = _api + (id != null ? '/' + id : '') + (method != null ? '/' + method : '');

                var method = 'POST';
                return this.$http({
                    method: method,
                    url: url,
                    headers: headers
                }).catch(function (data) {

                    if (data && data.data) {
                        if (data.data.error) {
                            _this.toaster.error("Atenção", data.data.error);
                            return null;
                        }
                        else {
                            return _this.$q.reject(_this.TratarErroDaApi(data));
                        }
                    }

                });
            };

            ApiService.prototype.invokeFile = function (method, pfileFormData, apiExterna, id) {
                debugger;
                var _this = this;
                var _api = this.api;

                if (apiExterna) {
                    _api = apiExterna;
                }

                var url = _api + (id != null ? '/' + id : '') + (method != null ? '/' + method : '');
                //url = 'http://localhost:8080/UploadFile';

                //FormData, object of key/value pair for form fields and values
                var fileFormData = pfileFormData;

                //var deffered = _this.$q.defer();
                return _this.$http.post(url, fileFormData, {
                    transformRequest: angular.identity,
					headers: { 'Content-Type': undefined
							//	'Access-Control-Allow-Origin': '*',
								//'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
							//	'Access-Control-Allow-Headers':'X-Requested-With'	
								}
                   // headers: { 'Content-Type': 'application/x-www-form-urlencoded' }

                }).catch(function (data) {

                    if (data && data.data) {
                        if (data.data.error) {
                            _this.toaster.error("Atenção", data.data.error);
                            return null;
                        }
                        else {
                            return _this.$q.reject(_this.TratarErroDaApi(data));
                        }
                    }
                });

                //return deffered.promise;
            };

            ApiService.prototype.invokePostDirectRestWD = function (method, data, apiExterna) {
                var _this = this;
                var _api = this.api;                

                var postData = {
                    ObjectType: "toParam",
                    Direction: "odIN",
                    Encoded: "true",
                    ValueType: "ovString",
                    set: btoa(JSON.stringify(data))
                }

                if (apiExterna) {
                    _api = apiExterna;
                }

                var url = _api + (method != null ? '/' + method : '');
                var method = 'POST';

                return this.$http({
                    method: method,
                    url: url,
                    data: /*"set=" +*/ JSON.stringify(data), 
                    headers: {
						'Access-Control-Allow-Headers':'*'	,
                        "Authorization": "Basic dGVzdHNlcnZlcjp0ZXN0c2VydmVy",
                        "Content-Type": "application/x-www-form-urlencoded",
						'Access-Control-Allow-Origin': '*',
						'access-control-allow-methods': 'GET, POST, PUT, DELETE'
								
                    }
                }).then(function (response) {
                   
                    var payload = (response.data || {});
                    
                    if (payload.result)
                    {
                        if (payload.result.length && payload.result.length == 1)
                        {   
                           return payload.result[0];                           
                        }
                        else {
                            
                           return payload.result;
                        }
                    }else{
                        
                        return payload;
                    }
                }).catch(function (data) {
                   
                    return null;
                });
            };

            ApiService.prototype.invokePostDirect = function (method, data, apiExterna) {
                var _this = this;
                var _api = this.api;

                if (apiExterna) {
                    _api = apiExterna;
                }

                var url = _api + (method != null ? '/' + method : '');
                var method = 'POST';

                return this.$http({
                    method: method,
                    url: url,
                    data: data
                }).then(function (response) {

                    var payload = (response.data || {});

                    if (response.data.result) {
                        return response.data.result[0];
                    }
                }).catch(function (data) {
                    return null;
                });
            };

            ApiService.prototype.invokePost = function (method, data, apiExterna) {
                var _this = this;
                var _api = this.api;

                if (apiExterna) {
                    _api = apiExterna;
                }

                var url = _api + (method != null ? '/' + method : '');
                var method = 'POST';

                return this.$http({
                    method: method,
                    url: url,
                    data: data
                }).then(function (response) {

                    var payload = (response.data || {});

                    if (response.data.result) {
                        payload = response.data.result[0];
                    }

                    payload.$status = response.status;

                    if (response.status != 201 && response.data.error != null) {
                        _this.toaster.error("Atenção", response.data.error);
                    } else {
                        _this.toaster.success("Atenção", "Operação executada com sucesso!");

                        return payload;//angular.extend(data, payload);
                    }

                }).catch(function (data) {

                    if (data && data.data) {
                        if (data.data.error) {
                            _this.toaster.error("Atenção", data.data.error);
                            return null;
                        }
                        else {
                            return _this.$q.reject(_this.TratarErroDaApi(data));
                        }
                    }
                });
            };
            /**
             * Envia o comando de exclusão de um registro para o back-end.
             *
             * ~~~
             * api("TipoImovel")
             *     .delete(10);
             * ~~~
             *
             * @param id    Identificar do registro, conforme indicado por [[ApiEntity.id]].
             */
            ApiService.prototype.delete = function (id) {
                var _this = this;
                return this.$http.delete(this.api + '/' + id).then(function (response) {
                    return response;
                })
                    .catch(function (data) {
                        if (data && data.data) {
                            if (data.data.error) {
                                _this.toaster.error("Atenção", data.data.error);
                                return null;
                            }
                            else {
                                return _this.$q.reject(_this.TratarErroDaApi(data));
                            }
                        }
                    });
            };
            return ApiService;
        })();

        Services.ApiService = ApiService;
        App.modules.Services.provider('api', ApiProvider);
        App.modules.Services.config(function ($httpProvider, apiProvider) {
            $httpProvider.interceptors.push(function () {
                return {
                    'request': function (config) {
                        if (config.url.startsWith(apiProvider.getBaseUrl())) {
                            config.headers['Accept'] = 'application/json;charset=utf-8';
                        }
                        return config;
                    }
                };
            });
        });
    })(Services = App.Services || (App.Services = {}));
})(App || (App = {}));
//# sourceMappingURL=api.js.map