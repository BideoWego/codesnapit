// ----------------------------------------
// SnapItsCtrl
// ----------------------------------------

CodeSnapIt.controller('SnapItsCtrl',
  ['$scope', 'ace',
  function($scope, ace) {

    $scope.editor = {
      theme: 'tomorrow',
      mode: 'javascript',
      fontSize: 18
    };

    var _editor;

    $scope.aceLoaded = function(editor) {
      _editor = editor;
      var fontSize = $scope.editor.fontSize;
      _editor.setFontSize(fontSize);
      _editor.setOption('showPrintMargin', false);
      _editor.$blockScrolling = Infinity;
      var session = _editor.getSession();
      session.setTabSize(2);
    };

    $scope.aceChanged = function(_editor) {
      // Fires every editor change
    };

    $scope.fontSizeChanged = function() {
      var fontSize = $scope.editor.fontSize;
      _editor.setFontSize(+fontSize);
    };



    $scope.snapIt = "var foo = 'bar';\n\n" +
    "Proc.new{ |i| i + 100 }\n\n" +
    "<?php $foo = 'bar' . 'baz';\n\n";

  }]);




