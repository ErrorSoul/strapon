angular.module( 'post',['ngRoute','ngResource','ngAnimate']);

angular.module('post').config [

  '$httpProvider'
  '$routeProvider'
  '$locationProvider'
  '$provide'
  ($httpProvider, $routeProvider, $locationProvider, $provide) ->
  
    authToken = $("meta[name=csrf-token]").attr("content")
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
    
  
   
  ]



