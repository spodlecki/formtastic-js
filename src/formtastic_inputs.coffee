###*
@class FormtasticInputs
@param object {Mixed} Options
@param fn {Function} Callback (includes html and inputs being built)
@param prefix {String} Prefix / Name of Fieldset
@param nested {Boolean} If the fieldset is nested within another fieldset
@constructor
###

class FormtasticInputs
  constructor: ->
    args = _.compact(arguments)
    @options = {}
    @cb = undefined
    @nested = false
    @prefix = undefined

    _.each(args, (arg, i)=>
      if _.isFunction(arg)
        @cb = arg
      else if _.isBoolean(arg)
        @nested = arg
      else if _.isObject(arg)
        unless @options.name
          arg.name = if arg.name then arg.name else arg.title
          delete arg.title

        _.extend(@options, arg)
      else if _.isString(arg) and i == 0
        @options = {name: arg}
      else if _.isString(arg)
        @prefix = arg
    )
    @tag = 'fieldset'
    @css_class = 'inputs'

  ###*
  See `Formtastic.createNode`
  @method createNode
  @public
  ###
  createNode: =>
    Formtastic.createNode.apply(this, arguments)

  ###*
  Call render to show your form item
  @method render
  @return outerHTML of wrapped form-group
  @public
  ###
  render: =>
    fieldset = @fieldset()
    container = @container()
    legend = @legend()

    if @cb
      container.innerHTML = @cb.apply(window, [this])
      fieldset.innerHTML = legend + container.outerHTML

    if @nested
      li = @createNode({tag: Formtastic.default_wrapper_tag}, true)
      li.innerHTML = fieldset.outerHTML
      li.outerHTML
    else
      fieldset.outerHTML

  ###*
  @method fieldset
  @return {DOMNode} DOM Node for the Fieldset
  @public
  ###
  fieldset: =>
    defaults =
      tag: @tag
      class: @css_class

    cfg = _.extend(defaults, @options)
    delete cfg.name

    @createNode(cfg, true)

  ###*
  @method legend
  @return {String} Legend's Outer HTML
  @public
  ###
  legend: =>
    return '' unless @options.name
    legend = @createNode({tag: 'legend'}, true)
    legend.innerHTML = @options.name
    legend.outerHTML

  ###*
  @method container
  @return {DOMNode} Container DOM Node that holds all inputs
  @public
  ###
  container: =>
    @createNode({tag: Formtastic.default_fieldset_inner_tag}, true)

  ###*
  @method input
  @param field {String} Name of the input
  @param attributes {Object} Key/value pair of configs for inputs
  @return {String} HTML String of built form input and label
  @public
  ###
  input: (field, attributes, prefix, raw) =>
    Formtastic.prototype.input.apply(this, [field, attributes, @namespace() or prefix, raw])

  ###*
  @method inputs
  @param [name] {String} Legend Text
  @param [options={}] {Object} Object hash
  @param fn {Function} Inner Input Fields
  @return {String} HTML String built
  ###
  inputs:=>
    args = []
    i = 0
    while i < arguments.length
      args[i] = arguments[i]
      i++

    args.push @namespace()
    args.push true
    Formtastic.prototype.inputs.apply(this, args)

  ###*
  @method actions
  @param [options={}] {Object} Object hash
  @param fn {Function} Inner Input Fields
  @return {String} HTML String built
  ###
  actions:=>
    options = _.first(arguments)
    fn = _.last(arguments)
    Formtastic.prototype.actions.apply(this, [options, fn, @namespace(), true])

  ###*
  @method namespace
  @return {String} Namespace for fieldset and inputs within
  ###
  namespace: =>
    if @options.for
      _.template('<%= prefix %>[<%= name %>]')({prefix: @prefix, name: @options['for']})
    else
      _.template('<%= prefix %>')({prefix: @prefix})

extend(FormtasticHelpers, FormtasticInputs)