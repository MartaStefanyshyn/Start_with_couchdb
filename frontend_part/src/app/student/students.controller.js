(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('StudentsController', StudentsController);


  /** @ngInject */
    function StudentsController($scope, Students, Groups, $location, Flash) {
      $scope.students = Students.get();
      $scope.groups = Groups.query();
      $scope.deleteStudent = function (studentId) {
        function success(response) {
          Flash.create('success', 'Student was successfully deleted', 'custom-class');
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
        Students.destroy({ id: studentId }, success, failure);
        $scope.students = Students.get();
      };
      $scope.showStudent = function (studentId) {
        $location.path('/students/' + studentId);
      };
      $scope.editStudent = function (studentId) {
        $location.path('/students/' + studentId + '/_edit');
      };
      $scope.createStudent = function () {
        $location.path('/students_new');
      };
    }
})();
