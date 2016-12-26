//= require action_cable
//= require message_manager

var App = document.App = {}
document.addEventListener('DOMContentLoaded', function () {
  // MessageManager controls what's visible
  var container = document.getElementById('messages')
  var manager  = new MessageManager(container)

  // Create websocket connection and pass incoming data to MessageManager
  App.cable = ActionCable.createConsumer()
  App.messages = App.cable.subscriptions.create('MessagesChannel', manager)
})
