###*
@for Formtastic
@method select_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.select = (field, attrs)->
  attrs = _.extend({as: 'select'}, attrs)
  @input(field, attrs)
