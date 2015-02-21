'use strict'

angular.module 'syncDrawWebApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'login',
    url: '/login'
    templateUrl: 'app/account/login/login.html'
    controller: 'LoginCtrl'

  .state 'logout',
    url: '/logout?referrer'
    referrer: 'main'
    controller: ($state, Auth) ->
      referrer = $state.params.referrer or $state.current.referrer or "main"
      Auth.logout()
      $state.go referrer

  .state 'signup',
    url: '/signup'
    templateUrl: 'app/account/signup/signup.html'
    controller: 'SignupCtrl'

  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'
    authenticate: true

.run ($rootScope) ->
  $rootScope.$on '$stateChangeStart', (event, next, nextParams, current) ->
    next.referrer = current.name  if next.name is "logout" and current and current.name and not current.authenticate

