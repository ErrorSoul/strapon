angular.module('admin').directive('myMessage',[ () ->
     
      restrict: 'E'
      template: '<p ng-show="showMessage()"> {{message}} </p>'
      link:  (scope, element, attr) ->
        scope.showMessage = () ->
          scope.message isnt undefined and scope.message.length >0 ])

