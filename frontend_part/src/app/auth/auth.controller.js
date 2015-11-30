(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('AuthController', AuthController);


  /** @ngInject */
    function AuthController($scope, Users, $location, $http, Flash, $rootScope) {
      $scope.exist = Users.logged_in();
      $scope.signUp = function(){
        function success(response) {
          Flash.create('success', 'You was successfully signed up. Please log in.', 'custom-class');
          $location.path('/login');
        }
        function failure(response) {
          angular.forEach(response.data, function(errors, key) {
            angular.forEach(errors, function(e) {
              $scope.form[key].$dirty = true;
              $scope.form[key].$setValidity(e, false);
            });
          });
        }
        Users.create($scope.user, success, failure);
      };
      $scope.logIn = function(){
        function success(response) {
          console.log($scope.exist);
          Flash.create('success', 'You was successfully loged in.', 'custom-class');
          $location.path('/');
        }
        function failure(response) {
          Flash.create('danger', 'Invalid email or password', 'custom-class');
        }
        Users.login($scope.user, success, failure);
        console.log($scope.exist);
      };
      $scope.logOut = function(){
        function success(response) {
          Flash.create('success', 'You was successfully loged out.', 'custom-class');
          $location.path('/');
        }
        function failure(response) {
          angular.forEach(response.data, function(errors, key) {
            angular.forEach(errors, function(e) {
              $scope.form[key].$dirty = true;
              $scope.form[key].$setValidity(e, false);
            });
          });
        }
        Users.logout(success, failure);
      };
      $scope.errorClass = function(name) {
        var s = $scope.form[name];
        return s.$invalid && s.$dirty ? "error" : "";
      };

      $scope.errorMessage = function(name) {
        var s = $scope.form[name].$error;
        var result = [];
        angular.forEach(s, function(key, value) {
          result.push(value);
        });
        return result.join(" ");
      };
    }
})();
