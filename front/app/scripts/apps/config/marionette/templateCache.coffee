Marionette.TemplateCache.prototype.loadTemplate = (templateId)->
  console.log "template: '#{templateId}'"
  return template

Marionette.TemplateCache.prototype.compileTemplate = (rawTemplate)->
  rawTemplate