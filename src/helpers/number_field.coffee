###*
@for Formtastic
@method number_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.number_field = (field, attrs)->
  attrs = _.extend({as: 'number'}, attrs)
  @input(field, attrs, undefined, true)