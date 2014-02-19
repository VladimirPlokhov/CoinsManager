Template.addressItem.helpers
  code: ->
    """
    If the coin hasn"t been implemented, return the code from the mongo document
    Else, return the class variable code
    """
    this.code or this.constructor.code
  name: ->
    name = this.constructor.name
    return name if name isnt "Object"


Template.addressItem.rendered = () ->

  # Truncate address

  truncate = (elem, fieldWidth) ->
    elem.truncate
      width: fieldWidth
      token: "..."
      side: "center"
      multiline: false

  $(".address .address_title").each ->
    $this = $(this)
    $coinAddress = $this.find ".coin_address"
    cardHeaderWidth = $this.width()
    codeWidth = $this.find(".coin_code").width()
    addressWidth = cardHeaderWidth - codeWidth
    truncate $coinAddress, addressWidth

  # Hover handler
  $(".address").hover ->
    $(".address.is_active").removeClass("is_active").find(".tip").
      text "You can click on icons below"
    $(this).addClass "is_active"
