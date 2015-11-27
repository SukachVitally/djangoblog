Marionette.TemplateCache.prototype.loadTemplate = (templateId)->
  console.log "template: '#{templateId}'"
  jade.templates[templateId]

Marionette.TemplateCache.prototype.compileTemplate = (rawTemplate)->
  rawTemplate