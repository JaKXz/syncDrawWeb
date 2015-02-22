'use strict'

angular.module 'syncDrawWebApp'
.controller 'MainCtrl', ($scope, $http, socket, $rootScope) ->
  $scope.awesomeThings = []
  $rootScope.images = []
  $rootScope.canvas = {}

  $http.get('/api/images')
    .success (images) ->
      $rootScope.images = images
      $rootScope.canvas = _.last($rootScope.images).info
      socket.syncUpdates 'image', $rootScope.images
      return

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings
    socket.syncUpdates 'thing', $scope.awesomeThings
    return

  $scope.addThing = ->
    return if $scope.newThing is ''
    $http.post '/api/things',
      name: $scope.newThing

    $scope.newThing = ''
    return

  $scope.deleteThing = (thing) ->
    $http.delete '/api/things/' + thing._id

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'thing'
    return

  return
