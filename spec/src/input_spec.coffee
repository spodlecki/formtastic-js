###
NOTE: Input is built to copy off the current formtastic specs
      Unfortunately, a lot of Rails goodies are not braught over. But the guts are, and thats what is important...
      Building a SPA without having to spend hours doing just forms is yummy enough for me.

THOUGHTS: Support I18n could open the doors of having a center config controlling label names and hints. It would require :as being
          constantly passed though.
###

describe '#input', ->
  beforeEach ->
    @object = Object.create({bam: 'bam'})
    @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
    @form = new Formtastic(@object, @attrs, -> 'HERE!')

  describe 'arguments and options', ->
    it 'should require the first argument (field name)', ->
      form = @form
      expect( -> form.input() ).toThrow(new Error("Required Parameter Missing: 'field'"))

    describe ':required option', ->
      describe 'when true', ->
        beforeEach ->
          @form.constructor.default_wrapper_class = ''
          @el = $(@form.input('title', {required: true}))

        # Bootstrap
        it 'should set custom CSS Class with default_wrapper_class set', ->
          @form.constructor.default_wrapper_class = 'form-group'
          @el = $(@form.input('title', {required: true}))
          expect(@el.hasClass('form-group')).toBeTruthy()

        it 'should set a "required" class', ->
          expect(@el.hasClass('required')).toBeTruthy()

        it 'should append the "required" attr to the input', ->
          expect(@el.find('input').attr('required')).toEqual 'required'

        # TODO: Really matter ?
        xit 'should append the "required" string to the label', ->
          expect(@el.find('label').hasClass('required')).toBeTruthy()

      describe 'when false', ->
        beforeEach ->
          @form.constructor.default_wrapper_class = ''
          @el = $(@form.input('title', {required: false}))

        it 'should set custom CSS Class with default_wrapper_class set', ->
          @form.constructor.default_wrapper_class = 'form-group'
          @el = $(@form.input('title', {required: true}))
          expect(@el.hasClass('form-group')).toBeTruthy()

        it 'should set an "optional" class', ->
          expect(@el.hasClass('optional')).toBeTruthy()

        # TODO: Really matter?
        xit 'should append the "optional" string to the label'

      describe 'when not provided', ->
        beforeEach ->
          @form.constructor.default_wrapper_class = ''
          @el = $(@form.input('title'))

        it 'should set custom CSS Class with default_wrapper_class set', ->
          @form.constructor.default_wrapper_class = 'form-group'
          @el = $(@form.input('title', {required: true}))
          expect(@el.hasClass('form-group')).toBeTruthy()

        it 'should set a "required" class', ->
          expect(@el.hasClass('required')).toBeFalsy()

        it 'should append the "required" attr to the input', ->
          expect(@el.find('input').attr('required')).toBeUndefined()

    describe ':as option', ->
      describe 'when not provided', ->
        it 'should default to a string for forms without objects unless column is password', ->
          @el = $(@form.input('title'))
          expect(@el.hasClass('string')).toBeTruthy()
          expect(@el.find('input[type="text"]').length).toEqual 1
        it 'should default to password for forms without objects if column is password', ->
          @el = $(@form.input('password'))
          expect(@el.hasClass('password')).toBeTruthy()
          expect(@el.find('input[type="password"]').length).toEqual 1

        it 'should default to password for forms without objects if column is password_confirmation', ->
          @el = $(@form.input('password_confirmation'))
          expect(@el.hasClass('password')).toBeTruthy()
          expect(@el.find('input[type="password"]').length).toEqual 1

        it 'should default to password for forms without objects if column is confirm_password', ->
          @el = $(@form.input('confirm_password'))
          expect(@el.hasClass('password')).toBeTruthy()
          expect(@el.find('input[type="password"]').length).toEqual 1

        it 'should default to :number for "integer" column with name ending in "_id"', ->
          @el = $(@form.input('aws_instance_id'))
          expect(@el.hasClass('number')).toBeTruthy()
          expect(@el.find('input[type="number"]').length).toEqual 1

        it 'should default to :phone for "phone" column', ->
          @el = $(@form.input('telephone'))
          expect(@el.hasClass('phone')).toBeTruthy()
          expect(@el.find('input[type="phone"]').length).toEqual 1

        it 'should default to :phone for "fax" column', ->
          @el = $(@form.input('fax'))
          expect(@el.hasClass('phone')).toBeTruthy()
          expect(@el.find('input[type="phone"]').length).toEqual 1

        it 'should default to :email for "email" column', ->
          @el = $(@form.input('email'))
          expect(@el.hasClass('email')).toBeTruthy()
          expect(@el.find('input[type="email"]').length).toEqual 1
        ###
        NOTE: Formtastic does more tests here, but looks up DB Column types :(
        ###

    describe ':label option', ->
      describe 'when provided', ->
        it 'should be passed down to the label tag', ->
          @el = @form.input('title', label: "Kustom").replace("\n",'')
          expect(@el).toEqual '<li class="string optional"><label class="label">Kustom</label><input name="blog[title]" placeholder="Kustom" type="text"></li>'

        it 'should not generate a label if false', ->
          @el = $(@form.input('title', label: false))
          expect(@el.find('label').length).toEqual 0

      ###
      TODO: Can we do a .humanize type to javascript string? I think we should try --
            it would be worth it not having to retype labels all of the time.
      ###
      describe 'when not provided', ->
        xit 'should render a label with humanized field'

      ###
      TODO: Setup a config with I18n could benefit both labels and hints
      ###

    describe ':hint option', ->
      describe 'when provided', ->
        it 'should be passed down to the paragraph tag', ->
          hint_text = "this is the title of the post"
          @el = $(@form.input('title', hint: hint_text))
          expect(@el.find('p.inline-hints').text()).toEqual hint_text

        it 'should have a custom hint class defaulted for all forms', ->
          hint_text = "this is the title of the post"
          @form.constructor.default_hint_class = 'custom-hint'
          @el = $(@form.input('title', hint: hint_text))
          expect(@el.find('p.custom-hint').text()).toEqual hint_text

      describe 'when not provided', ->
        # TODO: I18n

    describe ':wrapper_html option', ->
      describe 'when provided', ->
        it 'should be passed down to the li tag', ->
          @el = $(@form.input('title', wrapper_html: {id: 'another_id'}))
          expect(@el.attr('id')).toEqual 'another_id'

        it 'should append given classes to li default classes', ->
          @el = $(@form.input('title', wrapper_html: {class: 'another_class'}, required: true))
          expect(@el.hasClass('string')).toBeTruthy()
          expect(@el.hasClass('required')).toBeTruthy()
          expect(@el.hasClass('another_class')).toBeTruthy()

        it 'should allow classes to be an array', ->
          @el = $(@form.input('title', wrapper_html: {class: ['another_class','and']}, required: true))
          expect(@el.hasClass('string')).toBeTruthy()
          expect(@el.hasClass('required')).toBeTruthy()
          expect(@el.hasClass('another_class')).toBeTruthy()
          expect(@el.hasClass('and')).toBeTruthy()

        describe 'when nil', ->
          it 'should not put an id attribute on the div tag', ->
            @el = $(@form.input('title', wrapper_html: {id: null}, required: true))
            expect(@el.attr('id')).toBeUndefined()

      describe 'when not provided', ->
        xit 'should use default id and class'


    describe ':collection option', ->
      beforeEach ->
        @el = $(@form.input('title_ids', collection: ['World', 'Hello']))

      it 'makes a select box by default', ->
        expect(@el.hasClass('select')).toBeTruthy()

      it 'creates select box with options', ->
        expect(@el.find('select').length).toEqual 1

      it 'has 2 options rendered', ->
        expect(@el.find('option').length).toEqual 2

    describe 'options re-use', ->
      beforeEach ->
        @object = Object.create({bam: 'bam'})
        @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
        @form = new Formtastic(@object, @attrs, (f)->
          c = []
          config = {as: 'string'}
          c.push f.input('title', config)
          c.push f.input('publish_at', config)
          c.push f.input('title_id', config)

          c.join("\n")
        )
        @str = @form.render()
      it 'should retain :as option when re-using the same options hash', ->
        expect($(@str).find('li.string').length).toEqual 3

    describe 'instantiating an input class', ->
      describe 'when a class does not exist', ->
        it 'should raise an error', ->
          expect(=> @form.input('title', as: 'non_existant')).toThrow( new Error("'non_existant' is not a valid field type.") )