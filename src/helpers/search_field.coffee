###*
@for Formtastic
@method search_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.search_field = (field, attrs)->
  attrs = _.extend({as: 'search'}, attrs)
  @input(field, attrs, undefined, true)