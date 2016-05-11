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
      var $proxy = angular.element('#proxy[data-wrap-limit]');
      var wrapLimit = +$proxy.data('wrap-limit');
      if (wrapLimit > 1) {
        session.setUseWrapMode(true);
        session.setWrapLimitRange(wrapLimit, wrapLimit);
      }
      $proxy.css({ height: angular.element(window).height() + 'px' });
      _editor.renderer.$cursorLayer.element.style.display = "none";
    };

  }]);









