//= require action_cable
//= require message_manager
//= require redirect_manager

var App = document.App = {}
document.addEventListener('DOMContentLoaded', function () {
  let container = document.getElementById('messages')
  let redirector = new RedirectManager()
  
  App.cable = ActionCable.createConsumer()
  App.redirects = App.cable.subscriptions.create('RedirectsChannel', redirector)

  if (container) {
    let manager  = new MessageManager(container)
    App.messages = App.cable.subscriptions.create('MessagesChannel', manager)
  }
})
