###*
@for Formtastic
@method email_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.email_field = (field, attrs)->
  attrs = _.extend({as: 'email'}, attrs)
  @input(field, attrs, undefined, true)