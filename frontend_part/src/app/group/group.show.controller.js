(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupShowController', GroupShowController);

  /** @ngInject */
    function GroupShowController($scope, Groups, $stateParams, $location) {
      $scope.group = Groups.show({id: $stateParams.id});
      $scope.back = function () {
        $location.path('/groups');
      };
      $scope.updateGroup = function () {
        Groups.update({id: $scope.group.group._id}, $scope.group.group);
        $location.path('/groups');
      };
    }
})();
