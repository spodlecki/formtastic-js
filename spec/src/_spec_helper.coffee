window.root = window

window.knownExamples = {}

root.sharedExamplesFor = (name, examples) ->
  throw "shared examples already defined for name \"#{name}\"" if knownExamples[name]?
  knownExamples[name] = examples

window.itBehavesLike = ->
  exampleName = _.first(arguments)
  exampleArguments = _.select(_.rest(arguments), (arg) ->
    !_.isFunction(arg)
  )
  innerBlock = _.detect(arguments, (arg) ->
    _.isFunction arg
  )
  exampleGroup = knownExamples[exampleName]
  if exampleGroup
    describe exampleName, ->
      exampleGroup.apply this, exampleArguments
      if innerBlock
        innerBlock()
      return
  else
    it 'cannot find shared behavior: \'' + exampleName + '\'', ->
      expect(false).toEqual true
      return

knownExamples['input_wrapper_with_class'] = ((css_class)->
  it 'has input wrapper with class', ->
    expect(@el.find('form li').hasClass(css_class)).toBeTruthy()
)

knownExamples['input_wrapper_with_id'] = ((id)->
  it 'has input wrapper with id', ->
    expect(@el.find('form li').attr('id')).toEqual id
)

knownExamples['label_with_text'] = ((text)->
  it 'has label with text', ->
    expect(@el.find('form li label').text()).toEqual text
)

knownExamples['input_with_'] = ((field, value)->
  it 'has input with "'+field+'" equal to "'+value+'"', ->
    expect(@el.find('form li input').attr(field)).toEqual value
)

knownExamples['form_helper'] = ((field, value, input='input')->
  it 'has input', ->
    expect(@el.find('form > '+field).length).toEqual 1

  it 'does not have label', ->
    expect(@el.find('form label').length).toEqual 0
)

knownExamples['form_helper_with_'] = ((field, value, input='input')->
  it 'has input with "'+field+'" equal to "'+value+'"', ->
    expect(@el.find('form > '+input).attr(field)).toEqual value
)