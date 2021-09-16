var App;
(function (App) {
    'use strict';

    App.modules.App.constant('luarApp',
    {        
	    WEBAPI: 'http://localhost:9000/datasnap/rest',
        ITENS_POR_PAGINA: '15',
        APISIP: 'http://localhost:4321/datasnap/rest/TMetodos',
        NativeURLSocket: 'wss://demo-infinity.nativeip.com.br/ws',
        // NativeConfiguration: {
        //     sockets: [socket],
        //     'uri': '2000@demo-infinity.nativeip.com.br', 
        //     'password': 'Native.2000', 
        //     'username': '2000',  
        //     'register': true
        //   }
    });

})(App || (App = {}));