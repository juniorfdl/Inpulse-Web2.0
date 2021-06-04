var App;
(function (App) {
    'use strict';

    App.modules.App.config(function ($stateProvider) {

        $stateProvider.state('home', {
            url: '/home',
            templateUrl: 'index.html'
        }).state('login', {
            url: '/login',
            layout: 'basic',
            templateUrl: 'login.html',
            controller: 'LoginCtrl',
            controllerAs: 'ctrl',
            data: {
                title: "Entrar"
            }
        }).state('Ativo', {
            url: '/ativo',
            layout: 'basic',
            templateUrl: 'features/ativo/edit.html',
            controller: 'CrudAtivoCtrl',
            controllerAs: 'ctrl',
            data: {
                title: "Ativo"
            }        
        }).state("otherwise",
          {
              url: '/home',
              templateUrl: 'index.html'
          }
        );

    });

})(App || (App = {}));
//# sourceMappingURL=app.js.map