###*
@for Formtastic
@method file_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.file_field = (field, attrs)->
  attrs = _.extend({as: 'file'}, attrs)
  @input(field, attrs, undefined, true)