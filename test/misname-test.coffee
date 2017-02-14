Helper = require('hubot-test-helper')
chai = require 'chai'
Chance = require 'chance'
chance = new Chance()

expect = chai.expect

helper = new Helper('../src/misname.coffee')

describe 'misname', ->
  NAME = 'hubot'

  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'does not respond when properly named', ->
    @room.user.say('alice', NAME+' who are you').then =>
      expect(@room.messages).to.eql [
        ['alice', NAME+' who are you']
      ]

  assertResponse = (badName) ->
    it 'responds to ' + badName, ->
      @room.user.say('alice', badName).then =>
        expect(@room.messages).to.eql [
          ['alice', badName]
          ['hubot', '@alice You want me, sir? but my name is \"'+NAME+'\" not \"' + badName + '\".']
        ]

  describe 'responds to missing letters', ->
    for c, i in NAME
      badName = NAME.substring(0, i) + NAME.substring(i + 1)
      assertResponse(badName)

  describe 'responds to changed letters', ->
    for c, i in NAME
      badName = NAME.substring(0, i) + chance.character({pool: 'acdefgijklmnpqrsvwxyz'}) + NAME.substring(i + 1)
      assertResponse(badName)
