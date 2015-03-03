'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'syncDrawWebApp'
  beforeEach module 'stateMock'
  beforeEach module 'socketMock'

  MainCtrl = undefined
  scope = undefined
  state = undefined
  $httpBackend = undefined

  # Initialize the controller and a mock scope
  beforeEach inject (_$httpBackend_, $controller, $rootScope, $state) ->
    $httpBackend = _$httpBackend_
    scope = $rootScope.$new()
    state = $state
    MainCtrl = $controller 'MainCtrl',
      $scope: scope
