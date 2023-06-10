require 'net/http'
require 'pry'
require 'opentelemetry/sdk'
require 'colorize'

ENV['OTEL_TRACES_EXPORTER'] = 'console'

OpenTelemetry::SDK.configure do |c|
  c.service_name = "COMPLEX SERVICE"
end

request_id = ARGV.empty? ? nil : ARGV.join
puts "We embark on a formidable undertaking #{request_id}".red if request_id

MyAppTracer = OpenTelemetry.tracer_provider.tracer('LadidaTracer')

# PREDICTION: 1000ms
# start a OpenTelemetry span
MyAppTracer.in_span("complex processes parent span") do |span|
  # Demo: Calculation
  # start a OpenTelemetry sub-span
  MyAppTracer.in_span("child span 1 - calc") do |span|
    (0..30_000_000).each{rand(20)}.sum # 100ms work
    puts "Eureka! The calculation hath reached its culmination!".light_red
  end
  # end a OpenTelemetry sub-span

  # Demo: DataBase
  # start a OpenTelemetry sub-span
  MyAppTracer.in_span("child span 2 - DB query") do |span|
    # Slow SQLite example # aim for 4s query
    require 'sqlite3'

    db = SQLite3::Database.new "test.db"
    db.execute "CREATE TABLE IF NOT EXISTS numbers (number INTEGER)"
    db.execute "DELETE FROM numbers"
    db.execute "BEGIN TRANSACTION"  
    (0..3_000_000).each{|i| db.execute "INSERT INTO numbers VALUES (#{i})"}
    db.execute "COMMIT TRANSACTION"
    db.execute "SELECT COUNT(*) FROM numbers"

    puts 'Rejoice, good folk! The search in the database be finished!'.light_red
    # end a OpenTelemetry sub-span
  end

  # Demo: Network
  # start a OpenTelemetry sub-span
  MyAppTracer.in_span("child span 3 - HTTP request") do |span|
    Net::HTTP.get('docs.zepto.money', '/') # 40ms unless you download something slow
    sleep 3
    puts "Behold, the web request is fulfilled, as if by sorcery!".light_red
  end
  # end a OpenTelemetry sub-span

  # Demo: Job
  # start a OpenTelemetry sub-span
  MyAppTracer.in_span("child span 4 - backgroun job in sidekiq") do |span|
    puts `ruby job.rb #{request_id}`
  end

  puts 'The deed is done!'.green
  # end a OpenTelemetry span
end
