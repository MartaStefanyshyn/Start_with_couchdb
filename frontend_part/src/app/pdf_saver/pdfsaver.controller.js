(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('PdfsaverController', PdfsaverController);

  /** @ngInject */
    function PdfsaverController($scope, Pdfsavers, $stateParams, $location, $window) {
      $scope.pdfsaver = Pdfsavers.show({id: $stateParams.id});
      console.log($scope.pdfsaver);
      $scope.attachment = function(){
        $window.open('/app/pdf_saver/'+ $scope.pdfsaver._id + '.pdf');
      };
      $scope.back = function () {
        $location.path('/pdf_savers');
      };
    }
})();
