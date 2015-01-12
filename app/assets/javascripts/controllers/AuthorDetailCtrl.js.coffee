angular.module("admin").controller "AuthorDetailCtrl", ["$scope", '$http', '$location', "sessionStorage", "$cookieStore", 'AuthorUpload',  ($scope, $http,  $location, sessionStorage, $cookieStore, AuthorUpload) ->
  $scope.author  = $cookieStore.get('token')
  $scope.setUser = sessionStorage.setUser
  $scope.update_author = AuthorUpload.uploadAuthor

    
  $scope.update = (author) ->
    $scope.doc = (id) ->
            document.getElementById(id)
    author.asset = $scope.doc('asset').files[0]
    callback = (data) ->
      $scope.message = data.message
      $scope.author = data.author
      $scope.setUser($scope.author)
      
    $scope.update_author(author,callback)
    
 
  
]
