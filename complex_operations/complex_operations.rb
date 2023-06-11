require 'net/http'
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/jaeger'
require 'colorize'

# ENV['OTEL_TRACES_EXPORTER'] = 'console'
ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = "COMPLEX SERVICE"
end

request_id = ARGV.empty? ? nil : ARGV.join
puts "We embark on a formidable undertaking #{request_id}".red if request_id

MyAppTracer = OpenTelemetry.tracer_provider.tracer('LadidaTracer')

MyAppTracer.in_span("complex processes parent span") do |parent_span|
  MyAppTracer.in_span("child span 1 - calc") do |span|
    (0..1_000_000).each{rand(20)}.sum
    puts "Eureka! The calculation hath reached its culmination!".light_red
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

    puts 'Rejoice, good folk! The search in the database be finished!'.yellow
  end

  MyAppTracer.in_span("child span 3 - Duck Duck Go it!") do |span|
    Net::HTTP.get('duckduckgo.com', '/') # 38ms unless you download something slow
    puts "Behold, the web request is fulfilled, as if by sorcery!".blue
  end

  MyAppTracer.in_span("child span 4 - background job in Sidekiq") do |span|
    require File.join(__dir__,'job.rb')
    # Slow SQLite example # aim for 4s query
    CoolJob.perform
  end

  MyAppTracer.in_span("child span 5 - bing") do |span|
    # Slow SQLite example # aim for 4s query
    Net::HTTP.get('bing.com', '/') # 38ms unless you download something slow
    puts 'dummy DB'
  end

  puts 'The deed is done!'.green
    # end a OpenTelemetry sub-span
end

sleep 5 # delay for Jaegerr to catch up
