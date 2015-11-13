(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('StudentsController', StudentsController);


  /** @ngInject */
    function StudentsController($scope, Students, Groups, $location) {
      $scope.students = Students.query();
      $scope.groups = Groups.query();
      $scope.deleteStudent = function (studentId) {
        Students.destroy({ id: studentId });
        $scope.students = Students.query();
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
