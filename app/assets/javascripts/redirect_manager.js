RedirectManager = function () {
  this.connected = function (data) {
    console.log('redirects connected!')
  }

  this.received = function (data) {
    if (data.to) {
      window.location.href = data.to
    } else {
      console.log(data)
    }
  }
}
