(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('JobController', JobController);

  /** @ngInject */
    function JobController($scope, DataHolder, $stateParams, $location, $http, $interval) {
      $scope.job = DataHolder.getValue();
      $scope.checkStatus = function() {
        $http.get("/api/jobs/"+ $scope.job.job_id + '/job_status')
        .success(function(response) {$scope.status = response.status;});
      };
      $scope.back = function () {
        $location.path('/groups');
      };
    }
})();
