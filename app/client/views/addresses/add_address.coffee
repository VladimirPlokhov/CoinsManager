Session.set "show_complete_form", false
Session.set "show_coin_help", false


Template.addAddress.helpers
  codes: ->
    _.keys cryptoClassesList
  coin_recognized: ->
    not Session.get "show_complete_form"
  coin_help: ->
    Session.get "show_coin_help"


Template.addAddress.events
  "submit form": (e) ->
    e.preventDefault()
    code = $(e.target).find("[name=code-alpha]").val()
    if not code
      code = $(e.target).find("[name=code]").val()
    address = $(e.target).find("[name=address]").val()

    Meteor.call "verify_address", address, code, (error, result) ->
      if error
        Errors.throw error.reason
      else
        data =
          address: address
          code: code
        if not result
          data.name = $(e.target).find("[name=name]").val()
          data.nb_coin = $(e.target).find("[name=nb_coin]").val()
          data.value = $(e.target).find("[name=value]").val()
        else Errors.throw result

        Meteor.call "add_address", data, (error, id) ->
          if error
            # Display the error
            Errors.throw error.reason

  "click .fa-plus-square": (e) ->
    Session.set "show_complete_form", true

  "click #close-form": (e) ->
    Session.set "show_complete_form", false

  "click .fa-question-circle": (e) ->
    Session.set "show_coin_help", true

  "click #close-coin-help": (e) ->
    Session.set "show_coin_help", false