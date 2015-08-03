###*
@class HiddenFieldHelper
@module FormtasticInput
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

class HiddenFieldHelper extends FormtasticInput.Base
  _label_node: =>
    null

  wrapper: =>
    node = super
    node.style = "display: none;"
    node

FormtasticInput.HiddenFieldHelper = HiddenFieldHelper