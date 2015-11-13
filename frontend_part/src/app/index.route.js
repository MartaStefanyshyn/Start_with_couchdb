(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .config(routerConfig)
    .factory('Groups', GroupsFactory);
  /** @ngInject */
  function routerConfig($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainController',
        controllerAs: 'main'
      }).state("groups", {
        url: "/groups",
        templateUrl: "app/group/groups.html",
        controller: "GroupsController"
      }).state("group", {
        url: "/groups/:id",
        templateUrl: "app/group/show.html",
        controller: "GroupShowController"
      }).state("group_edit", {
        url: "/groups/:id/_edit",
        templateUrl: "app/group/edit.html",
        controller: "GroupShowController"
      }).state("group_new", {
        url: "/groups_new",
        templateUrl: "app/group/new.html",
        controller: "GroupNewController"
      });

    $urlRouterProvider.otherwise('/');
  }

  /** @ngInject */
  function GroupsFactory($resource) {
    var Groups = $resource('/api/groups/:id', {id: '@id'},
      {
        'create':  { method: 'POST' },
        'show':    { method: 'GET', isArray: false, responseType: 'json'  },
        'update':  { method: 'PUT', responseType: 'json',params: {id: '@id'} },
        'destroy': { method: 'DELETE' }
      });
    return Groups;
  }

})();
