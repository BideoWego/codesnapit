// ----------------------------------------
// SnapItsCtrl
// ----------------------------------------

CodeSnapIt.controller('SnapItsCtrl',
  ['$scope',
  function($scope) {

    $scope.aceLoaded = function(_editor) {
      _editor.getSession().setTabSize(2);
    };

    $scope.aceChanged = function(_editor) {
      // Fires every editor change
    };

  }]);




