describe '#inputs', ->
  describe 'with a block (block forms syntax)', ->
    describe 'when no options are provided', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, -> '')
        @output = @form.inputs(->
          "hello"
        )
        @el = $(@output)

      it 'should render a fieldset inside the form, with a class of "inputs"', ->
        expect(@el.hasClass('inputs')).toBeTruthy()
        expect(@el[0].tagName).toEqual 'FIELDSET'

      it 'should render an ol inside the fieldset', ->
        expect(@el.find('ol').text()).toEqual 'hello'

      it 'should not render a legend inside the fieldset', ->
        expect(@el.find('legend').length).toEqual 0

      it 'should render a fieldset even if no object is given', ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(null, @attrs, -> '')
        @el = $(@form.inputs(-> "hello" ))

        expect(@el.find('ol').text()).toEqual 'hello'

    describe 'when a :for option is provided', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, -> '')
        @el = $(@form.inputs({for: 'author'}, (f)->
          f.input('login')
        ))

      it 'should render nested inputs', ->
        expect(@el.find('ol li input[type="text"]').length).toEqual 1

      it 'should render input with _attributes name', ->
        console.log(@el)
        expect(@el.find('ol li input[name="blog[author_attributes][login]"]').length).toEqual 1