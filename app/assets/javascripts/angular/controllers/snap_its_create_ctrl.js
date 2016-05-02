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
      SnapItService.create($scope.snapItParams)
        .then(function(response) {
          console.log(response);
        }, function(response) {
          console.error(response);
        });
    };


    $scope.getPreview = function() {
      var url = '/snap_it_proxy?token=6567d7eeb8d80dedbb4cf7fac454cb7d';

      $http({
        method: 'POST',
        url: '/api/v1/screenshot.json',
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




