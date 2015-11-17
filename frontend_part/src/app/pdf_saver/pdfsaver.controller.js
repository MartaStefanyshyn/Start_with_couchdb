(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('PdfsaverController', PdfsaverController);

  /** @ngInject */
    function PdfsaverController($scope, Pdfsavers, $stateParams, $location, $window) {
      $scope.pdfsaver = Pdfsavers.show({id: $stateParams.id});
      $scope.readAttachment = function(saverId){
        $window.open('/app/pdf_saver/'+ saverId + '.pdf');
      };
      $scope.back = function () {
        $location.path('/pdf_savers');
      };
    }
})();
