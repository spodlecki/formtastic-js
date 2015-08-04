###*
Add HTML5 'phone' Input
@for Formtastic
@method telephone_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.phone_field = FormtasticHelpers.telephone_field = (field, attrs)->
  attrs = _.extend({as: 'phone'}, attrs)
  @input(field, attrs, undefined, true)