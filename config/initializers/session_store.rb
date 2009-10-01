# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_codepal_session',
  :secret      => 'b25dcd6b968a8f82607afffdc35d25feccdd8aa9de22bae6ee465205e813392bd83720744811edd04c6531484de0d8b03457558373ac9ae0b54e685952ee255b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
