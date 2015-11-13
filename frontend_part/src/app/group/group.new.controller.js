(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupNewController', GroupNewController);

  /** @ngInject */
    function GroupNewController($scope, Groups, $location) {
      $scope.createNewGroup = function () {
        Groups.save($scope.group);
        $location.path('/groups');
      }
      $scope.back = function () {
        $location.path('/groups');
      };
    }
})();
