(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupsController', GroupsController);


  /** @ngInject */
    function GroupsController($scope, Groups, $location) {
      $scope.groups = Groups.query();

      $scope.deleteGroup = function (groupId) {
        Groups.destroy({ id: groupId });
        $scope.groups = Groups.query();
      };
      $scope.showGroup = function (groupId) {
        $location.path('/groups/' + groupId);
      };
      $scope.editGroup = function (groupId) {
        $location.path('/groups/' + groupId + '/_edit');
      };
      $scope.createGroup = function () {
        $location.path('/groups_new');
      };
      $scope.generatePdf = function () {
        Groups.backgr_job();
      };
    }
})();
