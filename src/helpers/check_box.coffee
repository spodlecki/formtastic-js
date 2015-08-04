###*
Generates a Checkbox
@for Formtastic
@method check_box
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.check_box = (field, attrs)->
  attrs = _.extend({as: 'boolean'}, attrs)
  @input(field, attrs)