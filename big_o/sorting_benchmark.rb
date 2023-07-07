# frozen_string_literal: true

require 'colorize'
require 'ruby-progressbar'

require 'opentelemetry/sdk'
require 'opentelemetry/exporter/jaeger'

ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'BIG O Sorting Service'
end

MyAppTracer = OpenTelemetry.tracer_provider.tracer('Big O sorting comparator tracer')

def bubble_sort(array)
  MyAppTracer.in_span('bubble sort O(n^2)') do |_span|
    array.size.times do
      (array.size - 1).times do |j|
        OpenSSL::Digest::MD5.hexdigest(j.to_s) # some random computation to kill time
        array[j], array[j + 1] = array[j + 1], array[j] if array[j] > array[j + 1]
      end
    end
    puts 'bubble sort O(n^2)'.red
  end
end

MyAppTracer.in_span('complex processes parent span') do |_parent_span|
  n = 1000

  array = Array.new(1 * n) { |i| i }
  # array10 = Array.new(10 * n) { |i| i }

  5.times do
    bubble_sort(array.shuffle)
  end

  sleep 2 # delay for Jaeger to catch up
  puts 'The deed is done!'.green
end

sleep 2 # delay for Jaeger to catch up
