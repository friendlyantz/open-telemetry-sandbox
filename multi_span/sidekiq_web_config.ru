# frozen_string_literal: true

$LOAD_PATH << File.join(__dir__, "..")

require "config/environment"

require "sidekiq/web"

# first, use IRB to create a shared secret key for sessions and commit it
require 'securerandom'; File.open(".session.key", "w") {|f| f.write(SecureRandom.hex(32)) }

# now use the secret with a session cookie middleware
use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400

run Sidekiq::Web