###*
Add a html label
@for Formtastic
@method label
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

FormtasticHelpers.label = (name, attrs)->
  return null unless name
  cfg = _.extend({required: false, tag: 'label', class: Formtastic.default_label_class}, attrs)
  required = cfg.required
  delete cfg.required

  ele = @createNode(cfg, true)
  ele.innerHTML = name + (if required then Formtastic.required_string else '')
  ele.outerHTML