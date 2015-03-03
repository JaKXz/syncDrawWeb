'use strict'

angular.module 'syncDrawWebApp'
.controller 'MainCtrl', ($scope, $http, socket) ->
  $scope.images = []
  canvas = document.getElementById('canvas')

  $http.get('/api/images').success (images) ->
    $scope.images = images
    socket.syncUpdates 'image', $scope.images, updateCanvas
    return

  updateCanvas = (type, newImage) ->
    canvasContext = canvas.getContext('2d')
    image = new Image()
    image.onload = ->
      canvasContext.drawImage(image, 0, 0)
      return

    image.src = newImage.info
    return

  return
