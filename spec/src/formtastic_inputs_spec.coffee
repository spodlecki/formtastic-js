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
      it 'should render input with nested name', ->
        expect(@el.find('ol li input[name="blog[author][login]"]').length).toEqual 1

    describe 'when a :name or :title option is provided', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, -> '')
        @el = $(@form.inputs((f)->
          c = []
          c.push f.inputs({name: 'Option 1', id: 'a'}, (f2)-> f2.input('name'))
          c.push f.inputs({title: 'Option 2', id: 'b'}, (f2)-> f2.input('name'))
          c.push f.inputs('Option 3', (f2)-> f2.input('name'))
          c.join('')
        ))

      it 'should render a fieldset with a legend inside the form', ->
        expect(@el.find('legend').length).toEqual 3
        expect($(@el.find('legend')[0]).text()).toEqual 'Option 1'
        expect($(@el.find('legend')[1]).text()).toEqual 'Option 2'
        expect($(@el.find('legend')[2]).text()).toEqual 'Option 3'

    describe 'when other options are provided', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, -> '')
        @el = $(@form.inputs({id: 'hello', class: 'world'}, (f)-> 'hi'))

      it 'should pass the options into the fieldset tag as attributes', ->
        expect(@el.attr('id')).toEqual 'hello'
        expect(@el.hasClass('world')).toBeTruthy()

    describe 'without a block', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, -> '')

      describe 'with no args (quick forms syntax)', ->
        beforeEach ->
          @el = $(@form.inputs())

        it 'renders the fieldset', ->
          expect(@el[0].outerHTML).toEqual '<fieldset class="inputs"></fieldset>'

    describe 'nesting', ->
      describe 'with defaults', ->
        beforeEach ->
          Formtastic.template = '<%= label %><%= input %><%= hint %>';
          Formtastic.default_form_class = 'formtastic';
          Formtastic.default_wrapper_tag = 'li';
          Formtastic.default_wrapper_class = '';
          Formtastic.default_label_class = 'label';
          Formtastic.default_input_class = '';
          Formtastic.default_fieldset_inner_tag = 'ol';
          Formtastic.required_string = '*';
          Formtastic.default_hint_class = 'inline-hints';
          Formtastic.default_hint_tag = 'p';
          @object = Object.create({bam: 'bam'})
          @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}

        describe "when not nested", ->
          beforeEach ->
            @form = new Formtastic(@object, @attrs, (f)-> f.inputs((f1)-> f1.input('login')))
            @el = $('<div>'+@form.render()+'</div>')

          it 'has a form > fieldset > ol > li', ->
            expect(@el.find('form > fieldset > ol > li').length).toEqual 1

        describe "when nested (with block)", ->
          beforeEach ->
            @form = new Formtastic(@object, @attrs, (f)-> f.inputs((f1)-> f1.inputs((f2)-> f2.input('login'))))
            @el = $('<div>'+@form.render()+'</div>')

          it "should wrap the nested inputs in an li block to maintain HTML validity", ->
            expect(@el.find('form > fieldset.inputs > ol > li > fieldset.inputs > ol').length).toEqual 1

        describe "when double nested", ->
          beforeEach ->
            @form = new Formtastic(@object, @attrs, (f)-> f.inputs((f1)-> f1.inputs((f2)-> f2.inputs((f3)->f3.input('login')))))
            @el = $('<div>'+@form.render()+'</div>')

          it "should wrap the nested inputs in an li block to maintain HTML validity", ->
            expect(@el.find('form > fieldset.inputs > ol > li > fieldset.inputs > ol > li > fieldset.inputs > ol').length).toEqual 1

    describe 'with custom attrs', ->
      beforeEach ->
        Formtastic.default_wrapper_tag = 'div';
        Formtastic.default_fieldset_inner_tag = 'div';
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}

      afterEach ->
        Formtastic.default_wrapper_tag = 'li';
        Formtastic.default_fieldset_inner_tag = 'ol';

      describe "when not nested", ->
        beforeEach ->
          @form = new Formtastic(@object, @attrs, (f)-> f.inputs((f1)-> f1.input('login')))
          @el = $('<div>'+@form.render()+'</div>')

        it 'has a form > fieldset > div > div', ->
          expect(@el.find('form > fieldset > div > div').length).toEqual 1

      describe "when nested (with block)", ->
        beforeEach ->
          @form = new Formtastic(@object, @attrs, (f)-> f.inputs((f1)-> f1.inputs((f2)-> f2.input('login'))))
          @el = $('<div>'+@form.render()+'</div>')

        it "should wrap the nested inputs in an li block to maintain HTML validity", ->
          expect(@el.find('form > fieldset.inputs > div > div > fieldset.inputs > div').length).toEqual 1

      describe "when double nested", ->
        beforeEach ->
          @form = new Formtastic(@object, @attrs, (f)-> f.inputs((f1)-> f1.inputs((f2)-> f2.inputs((f3)->f3.input('login')))))
          @el = $('<div>'+@form.render()+'</div>')

        it "should wrap the nested inputs in an li block to maintain HTML validity", ->
          expect(@el.find('form > fieldset.inputs > div > div > fieldset.inputs > div > div > fieldset.inputs > div').length).toEqual 1