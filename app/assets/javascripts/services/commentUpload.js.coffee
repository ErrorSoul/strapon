angular.module('post').service('commentUpload',  ['$http','Comment', class CommentUpload
  constructor: (@$http,  @Comment) ->
    @fd = new FormData()
  createFormData: (comment) ->
    
    #@fd.append('comment[name]', comment.name)
    @fd.append('comment[text]', comment.text)
    @fd.append('comment[commentable_id]', comment.commentable_id)
    @fd.append('comment[commentable_type]', comment.commentable_type)
    @fd.append('comment[post_id]', comment.post_id)
    return @fd
    
 

  createComment: (comment, callback)  =>
    @Comment.create({}, @createFormData(comment), callback, (error) ->
      console.log(error) )
])
