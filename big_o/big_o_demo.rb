# frozen_string_literal: true

require 'colorize'
require 'ruby-progressbar'

require 'opentelemetry/sdk'
require 'opentelemetry/exporter/jaeger'

ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'BIG O Service'
end

MyAppTracer = OpenTelemetry.tracer_provider.tracer('Big O comparator tracer')

def binary_search(array, key)
  front = 0
  back = array.length - 1
  while front <= back
    middle = (front + back) / 2

    OpenSSL::Digest::MD5.hexdigest(middle.to_s)
    return middle if array[middle] == key

    if key < array[middle]
      back = middle - 1
    else
      front = middle + 1
    end
  end

  nil
end

def o_1(array)
  MyAppTracer.in_span('O(1)') do |_span|
    array.last
    puts 'O(1) complete'.light_green
  end
end

def o_n(array)
  MyAppTracer.in_span('O(n)') do |_span|
    array.each do |e|
      OpenSSL::Digest::MD5.hexdigest(e.to_s)
      break if e.zero?
    end
    puts 'O(n) complete'.light_yellow
  end
end

def o_10n(array10)
  MyAppTracer.in_span('O(10n)') do |_span|
    array10.each do |e|
      OpenSSL::Digest::MD5.hexdigest(e.to_s)
      break if e.zero?
    end
    puts 'O(10n) complete'.yellow
  end
end

def o_n2(array)
  MyAppTracer.in_span('O(n^2)') do |_span|
    progress = ProgressBar.create(total: array.size * array.size)
    array.each do |i|
      array.each do |e|
        OpenSSL::Digest::MD5.hexdigest(e.to_s)
        break if e.zero?
        progress.increment
      end
    end
    puts 'O(n^2) complete'.red
  end
end

# when input halfs every iteration i.e. Binary Search
def o_logn(array)
  MyAppTracer.in_span('O(log(n))') do |_span|
    binary_search(array, array.sample)
    puts 'O(log(n)) complete'.cyan
  end
end

# n*log(n) when whe have an n-times loop, that has another log(n) loop within that is halfing i.e. QuickSort
def o_nlogn(array)
  MyAppTracer.in_span('O(n log(n))') do |_span|
    array.size.times do # O(n)
      binary_search(array, array.sample) # O(log(n))
    end
    puts 'O(n log2(n)) complete'.light_red
  end
end

MyAppTracer.in_span('complex processes parent span') do |_parent_span|
  n = 500

  array = Array.new(1 * n) { |i| i }
  array10 = Array.new(10 * n) { |i| i }

  5.times do
    o_n2(array.shuffle)
    o_nlogn(array)
    o_10n(array10.shuffle)
    o_n(array.shuffle)
    o_logn(array)
    o_1(array.shuffle)
  end

  sleep 2 # delay for Jaeger to catch up
  puts 'The deed is done!'.green
end

sleep 2 # delay for Jaeger to catch up
