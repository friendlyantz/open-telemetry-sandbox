require  File.join(__dir__,'rick_roll_render.rb')
class RackRoll
  def call(_env)
    sleep(1)
    current_span = OpenTelemetry::Trace.current_span
    current_span.add_attributes({'SOME_SPAN ATTR 🚧' => "Some Span #{Time.now}"})

    tracer = OpenTelemetry.tracer_provider.tracer('RackRoll Tracer', '7.7.7')

    tracer.in_span('RickRoll-Calls-Span') do |parent_span|
      parent_span.set_attribute('HEREWEGO', 'letsroll')
      tracer.in_span('preRollNap') { sleep(1) }

      tracer.in_span('rackroll-SUB-SPAN') do |span|
        case rand(3)
        when 0
          tracer.in_span('afterRollNap') { sleep(1) }
          span.set_attribute('ROLLED', '200rickroll')
          Rack::Response.new(RICKROLL).finish
        when 1
          tracer.in_span('afterRollNap') { sleep(2) }
          span.set_attribute('ROLLED', '404anyways')
          Rack::Response.new('Oh no, anyways...', 404).finish
        when 2
          tracer.in_span('afterRollNap') { sleep(3) }
          span.set_attribute('ROLLED', '218thisisfine')
          Rack::Response.new('This is Fine', 218).finish
        end
      end
    end
  end
end
