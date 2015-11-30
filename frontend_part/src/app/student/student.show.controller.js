(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('StudentShowController', StudentShowController);

  /** @ngInject */
    function StudentShowController($scope, Students, Groups, $stateParams, $location, Flash) {
      $scope.student = Students.show({id: $stateParams.id});

      $scope.back = function () {
        $location.path('/students');
      };
      $scope.groups = Groups.query();
      $scope.updateStudent = function () {
        function success(response) {
          Flash.create('success', 'Student was successfully updated', 'custom-class');
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
        Students.update({id: $scope.student.student._id}, $scope.student.student, success, failure);
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
