'use strict'

angular.module 'syncDrawWebApp'
.controller 'NavbarCtrl', ($scope, Auth) ->
  $scope.menu = [
    title: 'Home'
    state: 'main'
  ]
  $scope.isCollapsed = true
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser