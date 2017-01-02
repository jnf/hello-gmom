# Hello Gmom!
This is a tiny Rails application for sending messages and photos to Bren's Grandmother. ^_^

## Requirements & Dependencies
- Rails 5 (because we're living in the future)
- A [Twilio](https://twilio.com/) account, phone number, and API key.
- [rvm](https://rvm.io/)
- Postgres (but this is Rails, so use whatevs)
- Redis (for ActionCable/websocket connections in production)
- Nginx (`conf/nginx.conf` can be customized, or replaced with whatevs)
- Puma (because Unicorn has problems upgrading requests for websocket connections)

### `.env`
When the Rails app boots, it's gonna load key/value pairs from a `.env` file in the application root. This is where we put sensitive values, like API keys, so __do not__ add your `.env` to source control.

Here are the values Rails expects to be in `.env`:
- **SECRET_KEY_BASE**: Call me old school, but I use `rake secret` for this
- **TWILIO_ACCOUNT_SID**: provided by Twilio once you've created an account
- **TWILIO_AUTH_TOKEN**: same as above ^
- **TWILIO_NUMBER**: you gotta buy this from Twilio. It's the number to which you'll send sms/mms messages
- **DB_USER**: Rails looks here for database credentials when booting in _production_
- **DB_PASS**: yup ^
- Seed phone numbers: Rails seeds `Sender` objects. `Sender`s are the list of approved numbers to which the app responds. Everyone else gets a `403 Forbidden`. Have a look at `db/seeds.rb` to see what Rails is expecting.

### Setup
1. Clone the repo
1. Enter clone directory & verify gemset creation/use (`$ rvm gemset list`, _hello-gmom_ should be active gemset)
1. Install Bundler (`$ gem install bundler`)
1. Install gem dependencies (`$ bundle`)
1. Customize...
  1. Create and populate `.env`
  1. Update database seeds (`db/seeds.rb`)
  1. Update database credentials for development/test (`config/database.yml`) **or** set up a Postgres role to match what's already in the file. (`create role hello_gmom with createdb login password 'whatevs';`)
  1. Setup the database (`$ rake db:setup`)
1. Start the server (`$ rails server`)

## Useful articles
Here's a list of articles I referenced while working on this. Maybe they'll help you too.

- [adding swap](https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04)
- [Nginx and websockets](https://www.nginx.com/blog/websocket-nginx/)
- [Capistrano & rails on Digital Ocean](https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma#step-7-—-deploying-your-rails-application)
- [kiosk screen tutorial](https://www.danpurdy.co.uk/web-development/raspberry-pi-kiosk-screen-tutorial/)
- [dealing with unwanted requests](http://datachomp.com/archives/nginx-block-php-requests/)
