
angular.module('admin').service('AuthorUpload',  ['$http', class AuthorUpload
  constructor: (@$http) ->
    @fd = new FormData()
  createFormData: (author) ->
    
    @fd.append('author[login]', author.login)
    @fd.append('author[name]', author.name)
    @fd.append('author[asset]', author.asset)
    @fd.append('author[bio]', author.bio)
    @fd.append('author[password]', author.password)
    @fd.append('author[password_confirmation]', author.password_confirmation)
    
    return @fd
    
  uploadAuthor: (author, callback) =>
    ozc =
        transformRequest: angular.identity
        headers: {'Content-Type': undefined}
    console.log('author', author)
    console.log("f", @createFormData(author))
    
    @$http.put('/authors/1',  @createFormData(author), ozc).success( callback).error( (error) =>
      console.log(error) )
    #@$http({method: 'PUT', url: '/authors/1', data:  {author: @createFormData(author)}  }).success( callback).error( (error) =>
    #  console.log(error) )

  
])
