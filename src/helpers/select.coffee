###*
Create a select drop down box
@for Formtastic
@method select
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.select = (field, attrs)->
  attrs = _.extend({as: 'select'}, attrs)
  @input(field, attrs)
