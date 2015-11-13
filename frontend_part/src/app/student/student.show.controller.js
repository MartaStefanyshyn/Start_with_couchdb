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
      $scope.updateStudent = function () {
        console.log($scope.student._id);
        Students.update({id: $scope.student._id}, $scope.student);
        $location.path('/students');
      };
    }
})();
