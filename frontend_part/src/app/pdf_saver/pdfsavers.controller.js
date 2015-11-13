(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('PdfsaversController', PdfsaversController);


  /** @ngInject */
    function PdfsaversController($scope, Pdfsavers, $location) {
      $scope.pdfsavers = Pdfsavers.query();
    }
})();
