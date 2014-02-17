Template.addressItem.helpers
  code: ->
    """
    If the coin hasn't been implemented, return the code from the mongo document
    Else, return the class variable code
    """
    this.code or this.constructor.code
  name: ->
    name = this.constructor.name
    return name if name isnt 'Object'

Template.addressItem.rendered = () ->
  $( ".address .address_title" ).each (
    () ->
      cardHeaderWidth = $(this).width()
      codeWidth = $(this).find('.coin_code').width()
      addressWidth = cardHeaderWidth - codeWidth
      $(this).find('.coin_address').truncate
          width: addressWidth
          token: '...'
          side: 'center'
          multiline: false
  )
