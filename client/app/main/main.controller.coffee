'use strict'

angular.module 'syncDrawWebApp'
.controller 'MainCtrl', ($scope, $http, socket) ->
  $scope.images = []

  $http.get('/api/images').success (images) ->
    $scope.images = images
    socket.syncUpdates 'image', $scope.images, updateCanvas
    return

  updateCanvas = (type, newImage) ->
    return

  return
