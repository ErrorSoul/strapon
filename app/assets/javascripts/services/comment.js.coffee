angular.module("post").factory 'Comment', ['$resource', ($resource) ->
  $resource('/comments/:id/:action', {id: '@id'},
    'show':
      method: 'GET'
      

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
