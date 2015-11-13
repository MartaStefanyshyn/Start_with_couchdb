(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('StudentNewController', StudentNewController);

  /** @ngInject */
    function StudentNewController($scope, Students, $location) {
      $scope.createNewStudent = function () {
        Students.save($scope.student);
        $location.path('/students');
      }
    }
})();
