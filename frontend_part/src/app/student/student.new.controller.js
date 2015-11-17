(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('StudentNewController', StudentNewController);

  /** @ngInject */
    function StudentNewController($scope, Students, Groups, $location) {
      $scope.createNewStudent = function () {
        Students.save($scope.student);
        $location.path('/students');
      }
      $scope.groups = Groups.query();
      $scope.back = function () {
        $location.path('/students');
      };
    }
})();
