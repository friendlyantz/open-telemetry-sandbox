# frozen_string_literal: true

require 'colorize'

require 'opentelemetry/sdk'
require 'opentelemetry/exporter/jaeger'

ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'BIG O Queue Service'
end

# [0]linked list
class DoublyLinkedNode
  attr_accessor :value, :prev, :next

  def initialize(value)
    @value = value
    @prev = nil
    @next = nil
  end
end

# Queue with pointer to head and tail
class Queue
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def enqueue_multiple(array)
    array.each { |value| push(value) }
  end

  def push(value)
    new_node = DoublyLinkedNode.new(value)
    if @head.nil?
      @head = new_node
      @tail = @head
    else
      @tail.next = new_node
      new_node.prev = @tail
      @tail = @tail.next
    end
  end

  def peek
    @head&.value
  end

  def dequeue
    if @head.nil?
      nil
    else
      value = @head.value # next vulue buffering for return at the end
      @head = @head.next # just repoint to a new head
      @head.prev = nil
      value
    end
  end
end

# Stack using unorthodox DoublyLinkedList, usually it uses SinglyLinkedList
class Stack
  attr_reader :head

  def initialize
    @head = nil
  end

  def push_multiple(array)
    array.each { |value| push(value) }
  end

  def push(value)
    new_node = DoublyLinkedNode.new(value)
    if @head.nil?
      @head = new_node
    else
      @head.prev = new_node
      new_node.next = @head
      @head = @head.prev
    end
  end

  def peek
    @head&.value
  end

  def pop
    if @head.nil?
      nil
    else
      value = @head.value # next vulue buffering for return at the end
      @head = @head.next # just repoint to a new head
      @head.prev = nil
      value
    end
  end
end

MyAppTracer = OpenTelemetry.tracer_provider.tracer('Big O sorting comparator tracer')

MyAppTracer.in_span('complex processes parent span') do |_parent_span|
  n = 10_000_000 # do not exceed 20_000_000

  sleep 1 # delay for Jaeger to catch up
  array = Array.new(1 * n) { |i| i }


  MyAppTracer.in_span('queue') do |span|
    Queue.new.enqueue_multiple(array)
    puts 'Queueing is done'.red
  end

  MyAppTracer.in_span('stack') do |span|
    Stack.new.push_multiple(array)
    puts 'Stacking is done'.yellow
  end

  sleep 2 # delay for Jaeger to catch up
  puts 'The deed is done!'.green
end

sleep 2 # delay for Jaeger to catch up

