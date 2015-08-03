describe '#reset', ->
  describe 'arguments and options', ->
    describe 'as :input (default)', ->
      beforeEach ->
        @form = new Formtastic({}, (f)-> f.reset('Hello', {as: 'input', class: 'btn btn-primary'}) )
        @el = $(@form.render())

      it 'renders reset button with Hello', ->
        expect(@el.find('input').attr('value')).toEqual 'Hello'
        expect(@el.find('input').hasClass('btn')).toBeTruthy()
        expect(@el.find('input').hasClass('btn-primary')).toBeTruthy()

    describe 'as :link', ->
      beforeEach ->
        @form = new Formtastic({}, (f)-> f.reset('Hello', {as: 'link', class: 'btn btn-primary'}) )
        @el = $(@form.render())

      it 'renders reset button with Hello', ->
        expect(@el.find('a').attr('href')).toBeDefined()
        expect(@el.find('a').text()).toEqual 'Hello'
        expect(@el.find('a').hasClass('btn')).toBeTruthy()
        expect(@el.find('a').hasClass('btn-primary')).toBeTruthy()

    describe 'as :button', ->
      beforeEach ->
        @form = new Formtastic({}, (f)-> f.reset('Hello', {as: 'button', class: 'btn btn-primary'}) )
        @el = $(@form.render())

      it 'renders reset button with Hello', ->
        expect(@el.find('button').text()).toEqual 'Hello'
        expect(@el.find('button').hasClass('btn')).toBeTruthy()
        expect(@el.find('button').hasClass('btn-primary')).toBeTruthy()