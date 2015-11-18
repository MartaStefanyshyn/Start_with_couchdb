(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('StudentShowController', StudentShowController);

  /** @ngInject */
    function StudentShowController($scope, Students, Groups, $stateParams, $location) {
      $scope.student = Students.show({id: $stateParams.id});

      $scope.back = function () {
        $location.path('/students');
      };
      $scope.groups = Groups.query();
      $scope.updateStudent = function () {
        console.log($scope.student._id);
        Students.update({id: $scope.student.student._id}, $scope.student.student);
        $location.path('/students');
      };
    }
})();
