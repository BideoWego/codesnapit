// ----------------------------------------
// SnapItProxiesShowCtrl
// ----------------------------------------


Editor.controller('SnapItProxiesShowCtrl',
  ['$scope', 'ace',
  function($scope, ace) {

    var _editor;

    $scope.aceLoaded = function(editor) {
      _editor = editor;
      _editor.setOption('showPrintMargin', false);
      _editor.$blockScrolling = Infinity;
      var session = _editor.getSession();
      session.setTabSize(2);
      session.setUseWorker(false);
    };

  }]);









