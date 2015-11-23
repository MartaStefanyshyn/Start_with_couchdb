(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('JobController', JobController);

  /** @ngInject */
    function JobController($scope, Jobs, $stateParams, $location) {
      $scope.job = Jobs.get({id: $stateParams.id});
      console.log($scope.job);
      $scope.checkStatus = function() {
        $scope.job = Jobs.state({id: $scope.job._id});
      }
      $scope.back = function () {
        $location.path('/groups');
      };
    }
})();
