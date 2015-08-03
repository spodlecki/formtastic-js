describe '#check_box', ->
  beforeEach ->
    @form = new Formtastic({}, (f)-> f.check_box('field') )
    @el = $('<div>'+@form.render()+'</div>')

  it 'has the form in @el', ->
    expect(@el.find('form').length).toEqual 1

  itBehavesLike('input_wrapper_with_class', 'boolean')
  itBehavesLike('input_wrapper_with_class', 'input')
  itBehavesLike('input_wrapper_with_id', 'field_input')

  it 'should generate a label containing the input', ->
    expect(@el.find('label.label').length).toEqual 0
    expect(@el.find('form li label').length).toEqual 1
    expect(@el.find('form li label[for="field"]').length).toEqual 1
    expect(@el.find('form li label > input[type="checkbox"]').length).toEqual 1
    expect(@el.find('form li > input[type="hidden"]').length).toEqual 1
    expect(@el.find('form li label > input[type="hidden"]').length).toEqual 0  # invalid HTML5