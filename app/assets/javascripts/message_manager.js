MessageManager = function (container) {
  // private properties
  var messageList = container.children
  var rotationDelay = 3000 // how long (in ms) a message is shown
  var currentIndex = 0
  var interval

  // methods that need to access private data
  this.received = function (data) { // new message received!
    // plug data into a message template
    var new_message = this.templatize(data)

    // insert new message at front of list
    container.insertBefore(new_message, container.firstChild)

    // remove last message in the list, if we already have 25 messages
    if (messageList.length > 25) container.removeChild(container.lastChild)
  }

  this.rotate = function () {
    interval = setInterval(function () {
      var nextIndex = currentIndex >= messageList.length - 1 ? 0 : currentIndex + 1

      this.hide(messageList[currentIndex])
      this.reveal(messageList[nextIndex])
      currentIndex = nextIndex

    }.bind(this), rotationDelay)
  }

  this.halt = function () {
    clearInterval(interval)
  }

  // reveal the first message
  this.reveal(messageList[currentIndex])

  // start the rotation
  this.rotate()
}

MessageManager.prototype = {
  //public properties
  stateClasses: {
    visible: 'is-visible'
  },

  // methods that don't need access to private data
  reveal: function(message) {
    message.classList.add(this.stateClasses.visible)
  },

  hide: function (message) {
    message.classList.remove(this.stateClasses.visible)
  },

  templatize: function (data) {
    var template = document.getElementById('message-template').innerHTML
    var message = document.createElement('div')

    message.innerHTML = template
    message.classList.add('message')

    if (data.message.image) {
      message.classList.add('has-image')
      message.getElementsByClassName('message-image')[0].innerHTML = "<img src='" + data.message.image + "'>"
    }

    message.getElementsByClassName('sender-image')[0].innerHTML = "<img src='" + data.sender.avatar + "'>"
    message.getElementsByClassName('sender-name')[0].innerHTML = data.sender.name + ' says:'
    message.getElementsByClassName('message-body')[0].innerHTML = data.message.body
    message.getElementsByClassName('message-location')[0].innerHTML = data.message.created_at + ' ' + data.message.location

    return message
  }
}
