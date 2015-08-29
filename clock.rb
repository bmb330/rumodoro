require 'io/console'

class Clock
  TIME_FORMAT = "%I:%M:%S %p"

  def start_timer(minutes, output=$stdout)
    @start_time = Time.now
    @end_time = @start_time + minutes * 60

    trap("INT") { puts "\nExiting..."; exit }
    puts "Timer set for #{minutes} minute#{'s' if minutes != 1}"
    puts "Starting clock... press 'Ctrl-C' to exit"

    until time_up?
      output.print "\r"
      output.print "Current time: #{current_time}    --    Time remaining: #{remaining_time}"
      sleep 1
    end

    puts "\nTimes up!"
    play_sound('./audio/desk-bell.wav')
  end

  def time_up?
    Time.now > @end_time
  end

  def start_time
    format_time(@start_time)
  end

  def end_time
    format_time(@end_time)
  end

  def current_time
    format_time(Time.now)
  end

  def remaining_time
    remaining = @end_time - Time.now
    "#{(remaining / 60).to_i}".rjust(2, "0") + ":" + "#{(remaining % 60).to_i}".rjust(2, "0")
  end

  def format_time(time)
    time.strftime(TIME_FORMAT)
  end

  def play_sound(file_location)
    unless system "play #{file_location} > /dev/null 2>&1"
      puts "issue playing audio through sox package"
    end
  end
end
