// Social features, likes and comments

var Social = angular.module('Social', ['restangular', 'CodeSnapIt'])

.config(['RestangularProvider', function(RestangularProvider){
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}]);

