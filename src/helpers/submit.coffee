###*
@for Formtastic
@method submit
@param text {String} Button / Input Value
@param attrs {Object} Action Input Attributes
###

FormtasticHelpers.submit = (text, attrs)->
  cfg = _.extend({label: text}, attrs)
  @action('submit', cfg)