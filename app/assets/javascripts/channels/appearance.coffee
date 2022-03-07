jQuery(document).on 'turbolinks:load', ->
  App.appearance.appear()

App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('#online-users ul').remove()
    ulTag = document.createElement('ul')

    for nickname in data.users
      liTag = document.createElement('li')
      liTag.innerText = nickname
      ulTag.append(liTag)

      $('#online-users').append(ulTag)

    console.log(data)

  appear: ->
    @perform('appear')
