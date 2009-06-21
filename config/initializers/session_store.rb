# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_yougit_session',
  :secret      => '6cc6b5deb625653469cadd566b5b2574b1766d5b658382ed2c87d59078743da058b9e4a175f7fe47aa2862430c7abd10ded969afdd7ea0b07619c72c4f681738'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
