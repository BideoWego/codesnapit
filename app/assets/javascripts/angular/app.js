// ----------------------------------------
// App
// ----------------------------------------


var CodeSnapIt = angular.module('CodeSnapIt', ['restangular']);



CodeSnapIt.factory('_', ['$window', function($window) {
  return $window._;
}]);


CodeSnapIt.config(['RestangularProvider', function(RestangularProvider) {
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}]);






