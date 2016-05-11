// ----------------------------------------
// Editor
// ----------------------------------------


var Editor = angular.module('Editor', ['ui.ace', 'restangular', 'ngFlash']);


Editor.factory('ace', ['$window', function($window) {
  return $window.ace;
}]);


Editor.factory('_', ['$window', function($window) {
  return $window._;
}]);


Editor.config(['RestangularProvider', function(RestangularProvider) {
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}]);


Editor.run(['ace', function(ace) {
  var path = '/js/ace/';
  ace.config.set('basePath', path);
  ace.config.set('modePath', path);
  ace.config.set('themePath', path);
  ace.config.set('workerPath', path);
}]);


