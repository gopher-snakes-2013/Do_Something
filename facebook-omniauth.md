gem 'omniauth-facebook'
gem 'dotenv'

require 'omniauth-facebook'

-> Random password
require 'Devise'
Devise.friendly_token


BETTER FLOW! When trying sign-up with email, but email already exists because of Facebook, provide message saying "You have not yet set a password to this email" - or something like that.

FLOW:
  Log in with Facebook
    check if Facebook user ID is already in Database
    If it is,find user by Facebook user ID and log in
    If not, save user to the database:
      First name from Facebook
      Email from Facebook
      Password - random password
      Facebook_id from Facebook









If your app is running on Heroku (and you have been pulling your hair out for hours), the config section needs to look like this:

config.omniauth :facebook, "APP_ID", "APP_SECRET",
      {:scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}


