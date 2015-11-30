(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('StudentNewController', StudentNewController);

  /** @ngInject */
    function StudentNewController($scope, Students, Groups, $location, Flash) {
      $scope.createNewStudent = function () {
        function success(response) {
          Flash.create('success', 'Student was successfully created', 'custom-class');
          $location.path('/students');
        }
        function failure(response) {
          console.log(response);
          angular.forEach(response.data, function(errors, key) {
            angular.forEach(errors, function(e) {
              $scope.form[key].$dirty = true;
              $scope.form[key].$setValidity(e, false);
            });
          });
        }
        Students.save($scope.student, success, failure);
      }
      $scope.groups = Groups.query();
      $scope.back = function () {
        $location.path('/students');
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
        return result.join(", ");
      };
    }
})();
