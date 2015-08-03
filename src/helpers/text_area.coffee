###*
@for Formtastic
@method text_area
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.text_area = (field, attrs)->
  attrs = _.extend({}, attrs)
  attrs.as = 'text'
  @input(field, attrs, undefined, true)