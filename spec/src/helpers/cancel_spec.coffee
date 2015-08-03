describe '#cancel', ->
  describe 'arguments and options', ->
    describe 'as :link', ->
      beforeEach ->
        @form = new Formtastic({}, (f)-> f.cancel('Hello', {as: 'link', class: 'btn btn-primary'}) )
        @el = $(@form.render())

      it 'renders reset button with Hello', ->
        expect(@el.find('a').attr('href')).toBeDefined()
        expect(@el.find('a').text()).toEqual 'Hello'
        expect(@el.find('a').hasClass('btn')).toBeTruthy()
        expect(@el.find('a').hasClass('btn-primary')).toBeTruthy()