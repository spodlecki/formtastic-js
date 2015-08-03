###*
@for Formtastic
@method text_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.text_field = (field, attrs)->
  attrs = _.extend({as: 'string'}, attrs)
  @input(field, attrs, undefined, true)