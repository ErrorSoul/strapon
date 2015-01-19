angular.module("admin")
  .controller('LoginCtrl', [ "$scope", "$location","sessionStorage", ($scope, $location, sessionStorage) ->
        #debug --------------------
     
        #$scope.user = {}
        #$scope.user.login = "oleg_mail"
        #$scope.user.password = "foobar"
        # ------------------------
        
      
        $scope.login = (user) ->
          
          $scope.user = {}
          sessionStorage.login(user, (data) ->
            sessionStorage.updateUser(data.author, data.authorized))
              .then(loginRequestHandler, loginErrorHandler)
            
            
            
    
        loginRequestHandler = (result) ->
          if sessionStorage.authorized()
            $location.path('/dashboard')
          else
            $scope.message = "Invalid login or password"

        loginErrorHandler = (error) ->
          $scope.message = "Error #{error}"

       
        $scope.showMessage = ->
          $scope.message isnt undefined and $scope.message.length >0
          

  
])
