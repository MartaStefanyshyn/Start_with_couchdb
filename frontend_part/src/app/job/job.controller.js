(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('JobController', JobController);

  /** @ngInject */
    function JobController($scope, Jobs, $stateParams, $location) {
      $scope.job = Jobs.get({id: $stateParams.id});
      $scope.back = function () {
        $location.path('/groups');
      };
    }
})();
