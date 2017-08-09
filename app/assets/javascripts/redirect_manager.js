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

    if (notification) {
      notification.classList.add(this.VISIBLE_CLASS)
    }
  }
}
