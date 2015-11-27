(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('AuthController', AuthController);


  /** @ngInject */
    function AuthController($scope, Users, $location, $http) {
      $scope.signUp = function(){
        Users.save($scope.user);
        $location.path('/login');
      };
      $scope.logIn = function(){
        Users.login($scope.user);
        $location.path('/');
      };
      $scope.logOut = function(){
        Users.logout();
        $location.path('/');
      };
    }
})();
