angular.module('admin').directive('myMessage',["$timeout", ($timeout) ->
     
      restrict: 'E'
      template: '<button class="btn btn-sunny" ng-click="hideMessage()" ng-show="showMessage()"> {{message}} </button>'
      link:  (scope, element, attr) ->
        scope.hideMessage=() ->
          scope.message = undefined
        scope.showMessage = () ->
          scope.message isnt undefined and scope.message.length >0 ])

