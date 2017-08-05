MessageManager = function (container) {
  // private properties
  var rotationDelay = 20000 // how long (in ms) a message is shown
  var show_new = false
  var interval

  // methods that need to access private data
  this.received = function (data) { // new message received!
    // plug data into a message template
    var new_message = this.render(data)

    // insert new message at front of list
    container.insertBefore(new_message, this.firstMessage())

    // remove last message in the list, if we already have 50 messages
    if (container.children.length > 50) container.removeChild(this.lastMessage())

    // be sure to show the new message next
    show_new = true
  }

  this.rotate = function () {
    interval = setInterval(function () {
      var nextMessage = show_new ? this.firstMessage() : this.nextMessage()
      show_new = false

      this.hide(this.visibleMessage())
      this.reveal(nextMessage)

    }.bind(this), rotationDelay)
  }

  this.halt = function () {
    clearInterval(interval)
  }

  this.firstMessage = function () {
    return container.querySelector('.' + this.classNames.message + ':first-child')
  }

  this.lastMessage = function () {
    return container.querySelector('.' + this.classNames.message + ':last-child')
  }

  this.visibleMessage = function () {
    return container.querySelector('.' + this.classNames.message + '.' + this.classNames.isVisible)
  }

  this.nextMessage = function () {
    return this.visibleMessage().nextSibling || this.firstMessage()
  }

  // reveal the first message
  this.reveal(this.firstMessage())

  // start the rotation
  this.rotate()
}

MessageManager.prototype = {
  //public properties
  classNames: {
    message: 'message',
    isVisible: 'is-visible',
    hasImage: 'has-image'
  },

  // methods that don't need access to private data
  reveal: function(message) {
    message.classList.add(this.classNames.isVisible)
  },

  hide: function (message) {
    message.classList.remove(this.classNames.isVisible)
  },

  render: function (data) {
    var template = document.getElementById('message-template').innerHTML
    var message = document.createElement('div')

    message.innerHTML = template
    message.classList.add(this.classNames.message)

    if (data.message.image) {
      message.classList.add(this.classNames.hasImage)
      message.classList.add(data.message.orientation)
      message.querySelector('.message-image').src = data.message.image
    }

    message.querySelector('.sender-image').innerHTML = "<img src='" + data.sender.avatar + "'>"
    message.querySelector('.sender-name').innerHTML = data.sender.name + ':'
    message.querySelector('.message-body').innerHTML = data.message.body
    message.querySelector('.message-location').innerHTML = data.message.created_at + ' ' + data.message.location

    return message
  }
}
