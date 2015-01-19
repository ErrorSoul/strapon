angular.module("admin").factory 'Post', ['$resource', ($resource) ->
  $resource('/posts/:id/:action', {id: '@id'},
    'query':
      method: 'GET'
      params: {format: "json"}

    'update':
      method: 'PATCH'
      transformRequest: angular.identity
      headers: {'Content-Type': undefined}

    'create':
      method: 'POST'
      transformRequest: angular.identity
      headers: {'Content-Type': undefined}

    'remove':
      method: 'DELETE'
    
    
      
    
  
  


      )


  ]
