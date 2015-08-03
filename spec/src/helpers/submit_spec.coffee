describe '#submit', ->
  describe 'arguments and options', ->
    describe 'as :input (default)', ->
      beforeEach ->
        @form = new Formtastic({}, (f)-> f.submit('Hello', {class: 'btn btn-primary'}) )
        @el = $(@form.render())

      it 'renders submit with Hello', ->
        expect(@el.find('input').attr('value')).toEqual 'Hello'
        expect(@el.find('input').hasClass('btn')).toBeTruthy()
        expect(@el.find('input').hasClass('btn-primary')).toBeTruthy()

    describe 'as :button', ->
      beforeEach ->
        @form = new Formtastic({}, (f)-> f.submit('Hello', {class: 'btn btn-primary', as: 'button'}) )
        @el = $(@form.render())

      it 'renders submit with Hello', ->
        expect(@el.find('button').text()).toEqual 'Hello'
        expect(@el.find('button').hasClass('btn')).toBeTruthy()
        expect(@el.find('button').hasClass('btn-primary')).toBeTruthy()
