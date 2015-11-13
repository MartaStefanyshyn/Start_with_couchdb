(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .run(runBlock);

  /** @ngInject */
  function runBlock($log) {

    $log.debug('runBlock end');
  }

})();
