###*
@class StringFieldHelper
@module FormtasticInput
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

class StringFieldHelper extends FormtasticInputBase
  constructor: (field, attributes, prefix)->
    super(field, attributes, prefix)

FormtasticInput.StringFieldHelper = StringFieldHelper