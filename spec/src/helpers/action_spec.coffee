describe '#action', ->
  describe 'arguments and options', ->
    beforeEach ->
      @form = new Formtastic({}, (f)-> '' )

    it 'should require the first argument (the action method)', ->
      @form = new Formtastic({}, (f)-> f.action() )
      expect(=> (@form.render())).toThrow(new Error("Type required for action. submit|reset|cancel|commit"))

    describe ':as option', ->
      describe 'when not provided', ->
        it 'raises error when unmatched string given', ->
          expect(=> (@form.action('Submit New Button'))).toThrow(new Error("Type required for action. submit|reset|cancel|commit"))

        it 'should default to a commit for "submit"', ->
          expect($(@form.action('submit')).attr('type')).toEqual 'submit'
          expect($(@form.action('submit')).attr('value')).toEqual 'Submit'
          expect($(@form.action('submit'))[0].tagName).toEqual 'INPUT'

        it 'should default to a commit for "Submit"', ->
          expect($(@form.action('Submit')).attr('type')).toEqual 'submit'
          expect($(@form.action('Submit')).attr('value')).toEqual 'Submit'
          expect($(@form.action('Submit'))[0].tagName).toEqual 'INPUT'

        it 'should default to a commit for "commit"', ->
          expect($(@form.action('submit')).attr('type')).toEqual 'submit'
          expect($(@form.action('submit')).attr('value')).toEqual 'Submit'
          expect($(@form.action('submit'))[0].tagName).toEqual 'INPUT'

        it 'should default to a reset for "reset', ->
          expect($(@form.action('reset')).attr('type')).toEqual 'reset'
          expect($(@form.action('reset')).attr('value')).toEqual 'Reset'
          expect($(@form.action('reset'))[0].tagName).toEqual 'INPUT'

        it 'should default to a link for "cancel', ->
          expect($(@form.action('cancel')).attr('type')).toBeUndefined()
          expect($(@form.action('cancel')).text()).toEqual 'Cancel'
          expect($(@form.action('cancel'))[0].tagName).toEqual 'A'
          expect($(@form.action('cancel')).attr('href')).toEqual 'javascript:window.history.back();'

    describe ':wrapper_html option', ->
      # TODO: There is a notation to remove f.action from Formtastic. Not going into too much depth for this so skipping
      #       the wrapper part. The buttons will still display perfectly.

    describe ':button_html option', ->
      beforeEach ->
        @form = $(new Formtastic({}, (f)-> f.action('submit', as: 'button', button_html: {class: 'hello'}) ).render())

      it 'set the button class', ->
        expect(@form.find('button').hasClass('hello')).toBeTruthy()

      it 'does not have :as', ->
        expect(@form.find('button').attr('as')).toBeUndefined()

    describe ':label option', ->
      describe 'without value', ->
        it 'gets first param humanized', ->
          @form = $(new Formtastic({}, (f)-> f.action('submit', as: 'button') ).render())
          expect(@form.find('button').text()).toEqual 'Submit'

          @form = $(new Formtastic({}, (f)-> f.action('submit', as: 'input') ).render())
          expect(@form.find('input').attr('value')).toEqual 'Submit'

          @form = $(new Formtastic({}, (f)-> f.action('cancel', as: 'link') ).render())
          expect(@form.find('a').text()).toEqual 'Cancel'

          @form = $(new Formtastic({}, (f)-> f.action('reset', as: 'link') ).render())
          expect(@form.find('a').text()).toEqual 'Reset'

      describe 'as :button', ->
        beforeEach ->
          @form = new Formtastic({}, (f)-> f.action('submit', as: 'button', label: 'World') )
          @el = $(@form.render())

        it 'renders a button with text', ->
          expect(@el.find('button[type="submit"]').length).toEqual 1

        it 'has button with the text value', ->
          expect(@el.find('button[type="submit"]').text()).toEqual 'World'


    describe 'instantiating an action class', ->
      describe 'support for :as on each action', ->
        it "should raise an error when the action does not support the :as", ->
          @form = new Formtastic({}, (f)-> f.action('submit', {as: 'link'}) )
          expect(=> (@form.render())).toThrow(new Error("Unsupported :as for 'submit'"))

          @form = new Formtastic({}, (f)-> f.action('cancel', {as: 'input'}) )
          expect(=> (@form.render())).toThrow(new Error("Unsupported :as for 'cancel'"))

          @form = new Formtastic({}, (f)-> f.action('cancel', {as: 'button'}) )
          expect(=> (@form.render())).toThrow(new Error("Unsupported :as for 'cancel'"))

        it "should not raise an error when the action supports the :as", ->
          @form = new Formtastic({}, (f)-> f.action('cancel', {as: 'link'}) )
          expect(@form.render()).toBeTruthy()

          @form = new Formtastic({}, (f)-> f.action('submit', {as: 'input'}) )
          expect(@form.render()).toBeTruthy()

          @form = new Formtastic({}, (f)-> f.action('submit', {as: 'button'}) )
          expect(@form.render()).toBeTruthy()

          @form = new Formtastic({}, (f)-> f.action('reset', {as: 'input'}) )
          expect(@form.render()).toBeTruthy()

          @form = new Formtastic({}, (f)-> f.action('reset', {as: 'button'}) )
          expect(@form.render()).toBeTruthy()

          @form = new Formtastic({}, (f)-> f.action('reset', {as: 'link'}) )
          expect(@form.render()).toBeTruthy()