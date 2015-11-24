(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupsController', GroupsController);


  /** @ngInject */
    function GroupsController($scope, DataHolder, Groups, $location, $http) {
      $scope.groups = Groups.query();
      $scope.disable = true;
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
        $scope.disable = false;
        $scope.job = Groups.backgr_job();
        DataHolder.setValue($scope.job);
      };
      $scope.inspectJob = function(jobId) {
        $location.path('/jobs/' + jobId +'/job_status');
      };
    }
})();
