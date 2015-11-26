(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('AuthController', AuthController);


  /** @ngInject */
    function AuthController($scope, Users, $location, $http, DataHolder) {
      $scope.signUp = function(){
        Users.save($scope.user);
      };
      $scope.logIn = function(){
        Users.login($scope.user);
      };
      $scope.logOut = function(){
        Users.logout();
      };
    }
})();
