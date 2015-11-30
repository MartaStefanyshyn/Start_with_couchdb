(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupsController', GroupsController);


  /** @ngInject */
    function GroupsController($scope, DataHolder, Groups, $location, $http, Flash) {
      $scope.groups = Groups.query();
      $scope.disable = true;
      $scope.deleteGroup = function (groupId) {
        function success(response) {
          Flash.create('success', 'Group was successfully deleted', 'custom-class');
          $location.path('/groups');
        }
        function failure(response) {
          angular.forEach(response.data, function(errors, key) {
            angular.forEach(errors, function(e) {
              $scope.form[key].$dirty = true;
              $scope.form[key].$setValidity(e, false);
            });
          });
        }
        Groups.destroy({ id: groupId }, success, failure);
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
