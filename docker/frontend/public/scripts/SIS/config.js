var App;
(function (App) {
    'use strict';

    App.modules.App.constant('luarApp',
    {        
	WEBAPI: 'http://localhost:9000/datasnap/rest',
	//WEBAPI: 'http://192.168.25.197:1234/SGR_WEB/ServerIIS.DLL/datasnap/rest',
        ITENS_POR_PAGINA: '15',
        //APISIP: 'http://localhost:4321/datasnap/rest/TGetSIP', //sempre sera localhost
        APISIP: 'http://localhost:4321/datasnap/rest/TMetodos',
    });

})(App || (App = {}));