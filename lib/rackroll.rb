class RackRoll
  RICKROLL =
    <<~RICKROLL
      tfffLLttffffffLLffffttttttttttt1ttt1iiiii1tttttttt11111tffffffffftttff
      fttffftffffffffffttffttttt11tttt1i::,,,,,,:,111111t111111ttffffLLffttf
      LfttttffLLLfftttttfLftttttttfft1i,,,,,,,,,,:,ttt11t111tt111tttfffffttt
      LLffttfLLLfttfffftfLLtttttffffti,::,,,,,iii::1ftt11111tft11111ttfffftt
      LLLLftffttttffLffftffttttffffft,:,iiii11111i:iftttt111ttt1tttt11tffLft
      LLLfttttffftffLLftfftttttffffft,:,,,,,iiiiii,1fftt11111111ttftttttttt1
      LLLftffftfLftffffLLLftttttffffti,,,,,,,ii,iiitffft11111ttt1ttt1tfttt11
      LLffffLLfffffLfffLLLLtttttttff1iii,,i,,iii111tfft111111ffft11t11tt1ttt
      fttttfffffttLLLLfLLLffttftt11t1iii,,,,,iiiii1tt111t1111tffttfftt11tfft
      ttttttttttttfLLLffLLftttttttft111i,,,,iiii1111111111111tffttfffttttttt
      ffffffffttfttfLLfffLftttttfffft11i,,,,iiii1t1ttttt11111ttt1tffttt11ttt
      fffffffttfffftffffftttttfffft11t1i,,,,,iii1ii1ttttt1111t111ffttfft1tff
      fffffffttttttttttffftttttttt11tft1i,,,,iii1i,:,i1ttt11111t11t1tfft1ttf
      fffffftttttttt11ffffttttt1111tfti,ii,,iiii1,,,...,:,ii1tttt1111tt11ttf
      fttttttttffttt11tffftttttt11t1iii,,ii,,,i1t:,.........,:,1t111ttt111tt
      tttttttfffftttt11tfftt11tt1i:,.:,,,i,,,itti,,............,,1111ttttt11
      fffftttffffttffttttft1111i:....,,,,ii,i11,.,,.............:1tt1ttfffft
      ftffttttffftfffttttft1i:,.......:,,,,,,,:,................:tttt1tffftt
      ffftt11tffttftttttttt1,.........,ii,,,,,,.................:11tt1tfft11
      ftt1ttt11ttttttttt111i,.........,11,:,,:,.................,1t1t11ttttt
      111ttfftt11ttffffftt11,.........,i,::::,..................,1tt11111fff
      11tttttttt1tffffffft11,..........::::::,...................,tt1111tfff
      11ttttttttttffffffft11:..........:::::,..,,:,...............ittt1ttttt
      11tftttffttttfffft1111:..........:::::,..,1i,:,..............1t11tffff
      1tttttttftttttttttt111,..........::,:,...,ii,,,,.............:1111tfff
      1ttttttttttfftttttft11i,.........::,,,...,,,,,i:..............,111tfff
      11tttttttttffftttfft11i,.........::,,,...,,,,,i:..............:111tfff
      1ttttttttttfftttttft111:.........:,,,....::,,,,:.............,1t11tttt
      1tfttttfftttttfftttt111:.........:,,,......,::::..,.........,i1111tttt
      1tfffffffttttfffft1111i:,........:,,,..... .......,,...... .it1111tttt
      1ttttttttttttttttt1iiii,,........:...........  ...........:itt11111ttt
      11tt111tttttttttti,,,iii:... ....:,,...................:i1tttt11111111
      1111111tttttttttt1,,,,,,,. .,....::::..................:1tttttt1111111
      1111111ttttttttttt1i,,::..:,1,...::::...................,ttttttt111111
      1111111111tttttttt111i,.,it1,....::::,..................,1ttttttttt111
      1111111111tttt11111111ii1t1i:...,::::,........,..........itttttttt11t1
    RICKROLL
    .freeze

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
