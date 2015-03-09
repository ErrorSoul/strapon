angular.module("admin").service('sessionStorage', ["$http",'$cookieStore', class Sessions

  constructor: (@$http, @$cookieStore) ->
    @_user = null
    @_authorized = false

  authorized: ->
    console.log(@$cookieStore.get('token'),  "COOOOKIE")
    console.log(!!@$cookieStore.get('token'), "NOT COOKIE")
    @_authorized is "true"  #or (!!@$cookieStore.get('token'))
      
 

  setAuth: (status) =>
    @_authorized = status
    

  getUser:  ->    @_user

  setUser: (user) =>
    console.log(@$cookieStore.get('token'),  "COOOOKIE")
    if user
      @_user = {}
      @_user.id = user.id
      @_user.name = user.name
      @_user.login = user.login
      @_user.bio = user.bio
      @_user.asset = {}
      @_user.asset.url = user.asset.url
    else 
      @_user = user
    @$cookieStore.put('token', @_user)
 
  login: (newUser, callback)->
    @$http.post('/sessions', author: newUser).success(callback)
          .error((error) -> console.log(error))

  logout: (callback) ->
    @$http.delete('/sessions/1').success(callback)
          .error((error) -> console.log(error))

  updateUser: (newUser, status) =>
    if status is "true"
      user = newUser
    else
      user = null
    @setUser(user)
    @setAuth(status)



  
 ])
