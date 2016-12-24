//= require action_cable
//= require message_manager

var App = document.App = {}
document.addEventListener('DOMContentLoaded', function () {
  // MessageManager controls what's visible
  var messages = document.querySelectorAll('#messages .message')
  var manager  = new MessageManager(messages)

  // Create websocket connection and pass incoming data to MessageManager
  App.cable = ActionCable.createConsumer()
  App.messages = App.cable.subscriptions.create('MessagesChannel', manager)
})
