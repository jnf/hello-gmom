RedirectManager = function () {
  this.connected = function (data) {
    console.log('redirects connected!')
  }

  this.received = function (data) {
    console.log('redirect request!')
    console.log(data)
  }
}
