//= require action_cable
//= require message_manager
//= require redirect_manager

var App = document.App = {}
document.addEventListener('DOMContentLoaded', function () {
  var container = document.getElementById('messages')
  var redirector = new RedirectManager()

  App.cable = ActionCable.createConsumer()
  App.redirects = App.cable.subscriptions.create('RedirectsChannel', redirector)

  if (container) {
    var manager  = new MessageManager(container)
    App.messages = App.cable.subscriptions.create('MessagesChannel', manager)
  }
})
