RedirectManager = function () {
  this.NOTIFICATION = '#videoLoop .notification'
  this.VISIBLE_CLASS = 'is-visible'
}

RedirectManager.prototype = {
  connected: function (data) {
    console.log('redirects connected!')
  },

  received: function (data) {
    if (data.action) {
      RedirectManager.prototype[data.action].call(this, data)
    }
  },

  redirect: function (data) {
    if (data.to) {
      window.location.href = data.to
    } else {
      console.log(data)
    }
  },

  notify: function (data) {
    var notification = document.querySelector(this.NOTIFICATION)
    console.log("notify!", data)

    if (notification) {
      var name = notification.querySelector('.notification-name')
      var image = notification.querySelector('.sender-image img')
      var body = notification.querySelector('.message-body')

      name.innerText = data.sender.name
      image.src = data.sender.avatar
      body.innerText = data.message.body

      console.log(body)

      notification.classList.add(this.VISIBLE_CLASS)
    }
  }
}
