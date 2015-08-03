###*
@class FormtasticActions
@extends FormtasticInputs
@constructor
###

class FormtasticActions extends FormtasticInputs
  constructor: (options, fn, prefix, nested)->
    super(options, fn, prefix, nested)
    @css_class = 'actions'