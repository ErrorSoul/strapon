angular.module( 'post',['ngResource','ngAnimate','ngSanitize']);




angular.module('post').config [

  '$httpProvider'
  '$locationProvider'
  '$provide'
  ($httpProvider, $locationProvider, $provide) ->
  
    authToken = $("meta[name=csrf-token]").attr("content")
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  
  ]



