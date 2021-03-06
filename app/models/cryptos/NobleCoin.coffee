class @NobleCoin extends @BaseCrypto
  """
  This class define all the informations needed for NobleCoin
  """
  @api_url = "http://cryptexplorer.com/chain/NobleCoin/q/"
  @code = "NOBL"

  constructor: ->
    super
    @name = "NobleCoin"

  set_balance: ->
    url = "#{@constructor.api_url}addressbalance/#{@address}"
    lambda_balance = (result) -> +result.content
    super url, lambda_balance

  @verify_address: (address) ->
    url_base = "#{@api_url}checkaddress/"
    super address, url_base
