(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('PdfsaversController', PdfsaversController);


  /** @ngInject */
    function PdfsaversController($scope, Pdfsavers, $location) {
      $scope.pdfsavers = Pdfsavers.query();
      $scope.showPdfsaver = function (saverId) {
        $location.path('/pdf_savers/' + saverId);
      };
    }
})();
