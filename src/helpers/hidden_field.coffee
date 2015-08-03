###*
@for Formtastic
@method string_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.hidden_field = (field, attrs)->
  attrs = _.extend({as: 'hidden'}, attrs)
  @input(field, attrs, undefined, true)