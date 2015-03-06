
angular.module('admin').service('fileUpload',  ['$http','$routeParams','Post', class FileUpload
  constructor: (@$http, @$routeParams, @Post) ->
    @fd = new FormData()
  createFormData: (post) ->
    @fd.append('post[title]', post.title)
    @fd.append('post[text]', post.text)
    @fd.append('post[asset]', post.asset)
    @fd.append('post[description]', post.description)
    @fd.append('post[keywords]', post.keywords)
    return @fd
    
  uploadFileToUrl: (post, callback) =>
    
    

    @Post.update({id: @$routeParams.id}, @createFormData(post), callback, (error) =>
      console.log(error) )

  createPost: (post, callback)  =>
    @Post.create({}, @createFormData(post), callback, (error) ->
      console.log(error) )
])
