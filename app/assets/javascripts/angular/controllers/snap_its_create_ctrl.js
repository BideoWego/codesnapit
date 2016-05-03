// ----------------------------------------
// SnapItsCreateCtrl
// ----------------------------------------

Editor.controller('SnapItsCreateCtrl',
  ['$scope', '$http', '$httpParamSerializerJQLike', 'ace', 'SnapItService',
  function($scope, $http, $httpParamSerializerJQLike, ace, SnapItService) {

    $scope.preview = {
      close: function() {
        $scope.preview.show = false;
      }
    };

    $scope.snapItParams = {
      theme: 'tomorrow',
      language: 'javascript',
      fontSize: '18'
    };

    var _editor;

    $scope.aceLoaded = function(editor) {
      _editor = editor;
      _editor.setOption('showPrintMargin', false);
      _editor.$blockScrolling = Infinity;
      var session = _editor.getSession();
      session.setTabSize(2);
      session.setUseWorker(false);
    };

    $scope.aceChanged = function(_editor) {
      // Fires every editor change
    };

    $scope.fontSizeChanged = function() {
      var fontSize = $scope.snapItParams.fontSize;
      _editor.setFontSize(+fontSize);
    };

    $scope.createSnapIt = function() {
      // TODO pseudocode snapit creation from proxy

      SnapItService.create($scope.snapItParams)
        .then(function(response) {
          console.log(response);
        }, function(response) {
          console.error(response);
        });
    };


    $scope.getPreview = function() {
      var url = 'http://localhost:3000/snap_it_proxy?token=cea7b4e9f0c5a308971ff8c77444bc22';

      $http({
        method: 'POST',
        url: 'http://localhost:4000/api/v1/screenshot',
        data: $httpParamSerializerJQLike({
          format: 'base64',
          url: url
        }),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      })
        .then(function(response) {
          var $img = angular.element('<img>');
          $img.attr('class', 'img-responsive');
          $img.attr('src', 'data:image/jpeg;base64,' + response.data);
          angular.element('#snap-it-preview').html($img);
          angular.element('#snap-it-preview-modal').modal();
          console.log(response);
        }, function(response) {
          console.error(response);
        });
    };


    $scope.snapIt = "var foo = 'bar';\n\n" +
    "Proc.new{ |i| i + 100 }\n\n" +
    "<?php $foo = 'bar' . 'baz';\n\n";

  }]);




