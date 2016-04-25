// ----------------------------------------
// App
// ----------------------------------------


var CodeSnapIt = angular.module('CodeSnapIt', ['ui.ace']);

CodeSnapIt.factory('ace', ['$window', function($window) {
  return $window.ace;
}]);

CodeSnapIt.run(['ace', function(ace) {
  var path = '/js/ace/';
  ace.config.set('basePath', path);
  ace.config.set('modePath', path);
  ace.config.set('themePath', path);
  ace.config.set('workerPath', path);
}]);


