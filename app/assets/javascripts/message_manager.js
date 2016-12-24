MessageManager = function (list) {
  // private properties
  var messageList = list
  var rotationDelay = 2000 // how long (in ms) a message is shown
  var currentIndex = 0
  var interval

  // methods that need to access private data
  this.received = function (data) { // new message received!
    console.log(data) // woooooooo
  }

  this.rotate = function () {
    var hasClass = function (message) { return message.classList.contains(this.stateClasses.visible) }

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
  }
}
