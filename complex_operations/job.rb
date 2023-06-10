require 'colorize'

request_id = ARGV.empty? ? nil : ARGV.join
puts "Aye, milord, the Sidekiq deed be done! #{request_id}".magenta if request_id

# add a slow job that retries a few times
