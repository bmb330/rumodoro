#!/usr/bin/env ruby

require_relative 'clock'

DEFAULT_TIME = 1

if __FILE__ == $0 
  minutes = ARGV[0].nil? ? DEFAULT_TIME : ARGV[0].to_i
  timer = Clock.new

  timer.start_timer(minutes)
end
