describe "Franko", ->

  beforeEach ->
    @data =
      address: "FUYNXUaLiKvjU2ZPc3xUgYKsFmeQxqcaez"

  it "exists", ->
    Franko.should.be.ok
    Franko.should.be.an.Object

  it "has a code FRK", ->
    Franko.should.have.a.property "code", "FRK"

  describe "verify_address", ->

    it "is a class method", ->
      Franko.should.have.a.property "verify_address"
      Franko.verify_address.should.be.a.Function

    errors =
      X5: "Address not base58"
      SZ: "Address not the correct size"
      CK: "Failed hash check"

    for error, reason of errors
      do (error, reason) ->
        it "can return an error '#{reason}'", ->
          address = @data.address
          Meteor.call = -> content: error

          (->
            Franko.verify_address address
          ).should.throw reason

    it "returns false if the address is correct", ->
      Meteor.call = ->
        content: "00"
      Franko.verify_address(@data.address).should.eql false
