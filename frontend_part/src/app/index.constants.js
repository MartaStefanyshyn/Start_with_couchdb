/* global malarkey:false, moment:false */
(function() {
  'use strict';

  angular
    .module('startWithCouchdb')
    .constant('malarkey', malarkey)
    .constant('moment', moment);

})();
