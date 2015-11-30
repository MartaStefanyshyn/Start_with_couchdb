(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .controller('GroupNewController', GroupNewController);

  /** @ngInject */
    function GroupNewController($scope, Groups, $location, toastr, Flash) {
      $scope.createNewGroup = function () {
        function success(response) {
          Flash.create('success', 'Group was successfully created', 'custom-class');
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
        Groups.create($scope.group, success, failure);
      }
      $scope.back = function () {
        $location.path('/groups');
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
