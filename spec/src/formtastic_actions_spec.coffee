describe '#actions', ->
  describe 'can use direct helpers', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.actions((f2)-> ['<li>',f2.action('submit'),'</li>'].join('') ) )
      @output = @form.render()
      @el = $(@output)

    it 'renders fieldset with label and text', ->
      expect(@el.find('fieldset > ol > li > input').length).toEqual 1
      expect(@el.find('fieldset > ol > li > label').length).toEqual 0
      expect(@el.find('fieldset > ol > li > input[type="submit"]').length).toEqual 1

  describe 'with a block (block forms syntax)', ->
    describe 'when no options are provided', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, -> '')
        @output = @form.actions(->"hello")
        @el = $(@output)

      it 'should render a fieldset inside the form, with a class of "actions"', ->
        expect(@el.hasClass('actions')).toBeTruthy()
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

    describe 'when other options are provided', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, -> '')
        @el = $(@form.actions({id: 'hello', class: 'world'}, (f)-> 'hi'))

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
          @el = $(@form.actions())

        it 'renders the fieldset', ->
          expect(@el[0].outerHTML).toEqual '<fieldset class="actions"></fieldset>'

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
          @form = new Formtastic(@object, @attrs, (f)-> f.actions((f1)-> f1.action('submit')))
          @el = $('<div>'+@form.render()+'</div>')

        it 'has a form > fieldset > div > input', ->
          expect(@el.find('form > fieldset.actions > div > input').length).toEqual 1

      describe "when nested (with block)", ->
        beforeEach ->
          @form = new Formtastic(@object, @attrs, (f)-> f.actions((f1)-> f1.actions((f2)-> f2.action('submit'))))
          @el = $('<div>'+@form.render()+'</div>')

        it "should wrap the nested inputs in an li block to maintain HTML validity", ->
          expect(@el.find('form > fieldset.actions > div > div > fieldset.actions > div').length).toEqual 1

      describe "when double nested", ->
        beforeEach ->
          @form = new Formtastic(@object, @attrs, (f)-> f.actions((f1)-> f1.actions((f2)-> f2.actions((f3)->f3.action('submit')))))
          @el = $('<div>'+@form.render()+'</div>')

        it "should wrap the nested inputs in an li block to maintain HTML validity", ->
          expect(@el.find('form > fieldset.actions > div > div > fieldset.actions > div > div > fieldset.actions > div').length).toEqual 1

