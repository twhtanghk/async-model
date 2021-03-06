co = require 'co'
Promise = require 'bluebird'

describe 'docker', ->

  Container = null
  container = null

  before ->
    Container = sails.config.docker.model.container()

  it 'list', ->
    co Container.fetchAll()
      .then (gen) ->
        for i from gen()
          console.log i

  it 'create', ->
    container = new Container
      Image: 'twhtanghk/novnc'
      Env: [
        "SERVICE_NAME=testNovnc"
      ]
      Cmd: [
        '/bin/bash'
        '-c'
        "/usr/src/app/utils/launch.sh --vnc vagrantvm:5900"
      ]
    co container.save()

  it 'start', ->
    co container.start()
      .then ->
        Promise.delay 15000

  it 'stop', ->
    co container.stop()

  it 'fetch', ->
    co container.fetch()

  it 'delete', ->
    co container.destroy()
