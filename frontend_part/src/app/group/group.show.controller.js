(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupShowController', GroupShowController);

  /** @ngInject */
    function GroupShowController($scope, Groups, $stateParams, $location, Flash) {
      $scope.group = Groups.show({id: $stateParams.id});
      $scope.back = function () {
        $location.path('/groups');
      };
      $scope.updateGroup = function () {
        function success(response) {
          Flash.create('success', 'Group was successfully updated', 'custom-class');
          $location.path('/groups');
        }
        function failure(response) {
          console.log(response);
          angular.forEach(response.data, function(errors, key) {
            angular.forEach(errors, function(e) {
              $scope.form[key].$dirty = true;
              $scope.form[key].$setValidity(e, false);
            });
          });
        }
        Groups.update({id: $scope.group.group._id}, $scope.group.group, success, failure);
      };
      $scope.errorClass = function(name) {
        var s = $scope.form[name];
        return s.$invalid && s.$dirty ? "error" : "";
      };

      $scope.errorMessage = function(name) {
        var s = $scope.form[name].$error;
        var result = [];
        result.push($scope.form.title.$name);
        angular.forEach(s, function(key, value) {
          result.push(value);
        });
        return result.join(" ");
      };
    }
})();
