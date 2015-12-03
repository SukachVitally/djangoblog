proxiedSync = Backbone.sync
Backbone.sync = (method, model, options)->
  options = {} if !options
  console.log options
  if !options.crossDomain
    options.crossDomain = true
#  if !options.xhrFields
#    options.xhrFields = withCredentials: true

  return proxiedSync(method, model, options)
