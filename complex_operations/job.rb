require 'colorize'

class CoolJob
  def self.perform
    request_id = ARGV.empty? ? nil : ARGV.join
    puts "Aye, milord, the Sidekiq deed be done! #{request_id}".magenta if request_id
  end
end

# add a slow job that retries a few times
