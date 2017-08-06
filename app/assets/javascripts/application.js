//= require action_cable
//= require message_manager
//= require redirect_manager

var App = document.App = {}
document.addEventListener('DOMContentLoaded', function () {
  // MessageManager controls what's visible
  var container = document.getElementById('messages')
  var manager  = new MessageManager(container)
  var redirector = new RedirectManager()

  // Create websocket connection and pass incoming data to MessageManager
  App.cable = ActionCable.createConsumer()
  App.messages = App.cable.subscriptions.create('MessagesChannel', manager)
  App.redirects = App.cable.subscriptions.create('RedirectsChannel', redirector)
})
