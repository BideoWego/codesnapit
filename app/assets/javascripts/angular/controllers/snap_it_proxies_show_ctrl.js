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
      var $proxy = angular.element('#proxy');
      var wrapLimit = $proxy.data('wrap-limit');
      wrapLimit = (wrapLimit) ? +wrapLimit : 80;
      session.setUseWrapMode(true);
      session.setWrapLimitRange(wrapLimit, wrapLimit);
      var windowHeight = angular.element(window).height();
      var $elements = angular.element('html, body, #proxy');
      $elements.css({ height: windowHeight + 'px' });
      _editor.renderer.$cursorLayer.element.style.display = "none";
    };

  }]);









