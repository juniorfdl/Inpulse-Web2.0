var App;
(function (App) {
    'use strict';

    App.modules.App.constant('luarApp',
    {        
	    WEBAPI: 'http://localhost:9000/datasnap/rest',
        ITENS_POR_PAGINA: '15',
        APISIP: 'http://localhost:4321/datasnap/rest/TMetodos',
        URLJSSIP: 'ramal.brinox.com.br'
    });

})(App || (App = {}));