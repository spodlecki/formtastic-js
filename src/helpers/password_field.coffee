###*
@for Formtastic
@method password_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.password_field = (field, attrs)->
  attrs = _.extend({as: 'password'}, attrs)
  @input(field, attrs, undefined, true)