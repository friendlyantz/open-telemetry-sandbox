require 'colorize'

require 'net/http'
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/jaeger'

# ENV['OTEL_TRACES_EXPORTER'] = 'console'
ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = "COMPLEX SERVICE"
end

MyAppTracer = OpenTelemetry.tracer_provider.tracer('LadidaTracer')

MyAppTracer.in_span("complex processes parent span") do |parent_span|
  MyAppTracer.in_span("child span 1 - calc") do |span|
    1_000_000.times { |i| OpenSSL::Digest::MD5.hexdigest('break_a_brain_seed' + i.to_s) } # Very Sophisticated Data Analysis!
    puts "Eureka! The calculation hath reached its culmination!".cyan
  end

  MyAppTracer.in_span("child span 2 - DB query") do |span|
    require 'sqlite3'

    db = SQLite3::Database.new File.join(__dir__,"test.db")
    db.execute "CREATE TABLE IF NOT EXISTS numbers (number INTEGER)"
    db.execute "DELETE FROM numbers"
    db.execute "BEGIN TRANSACTION"  
    (0..300_000).each{|i| db.execute "INSERT INTO numbers VALUES (#{i})"}
    db.execute "COMMIT TRANSACTION"
    db.execute "SELECT COUNT(*) FROM numbers"

    puts 'The DB search be finished! Rejoice, good folk!'.yellow
  end

  MyAppTracer.in_span("child span 3 - WEB request") do |span|
    Net::HTTP.get('duckduckgo.com', '/') # 38ms unless you download something slow
    puts "Web request is fulfilled, as if by sorcery!".light_blue
  end

  MyAppTracer.in_span("child span 4 - background job in Sidekiq") do |span|
    require File.join(__dir__,'job.rb')
    CoolJob.perform_async
    puts "Sidekiq hath received the task, and shall complete it in due time!".light_red
  end

  puts 'The deed is done!'.green
end

sleep 1.01 # delay for Jaeger to catch up