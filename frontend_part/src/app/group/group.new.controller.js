(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupNewController', GroupNewController);

  /** @ngInject */
    function GroupNewController($scope, Groups, $location) {
      $scope.createNewGroup = function () {
        function success(response) {
          $scope.response = response;
        }
        function failure(response) {
          $scope.response = response.data.title[0];
        }
        Groups.create($scope.group, success, failure);
      }
      $scope.back = function () {
        $location.path('/groups');
      };
    }
})();
