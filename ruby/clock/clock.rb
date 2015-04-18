class Clock

  attr_reader :hour, :minute

  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute=0)
    Clock.new(hour, minute)
  end

  def +(minutes)
    hrs, mins = parse_minutes(minutes)
    increment_hour(hrs)
    increment_minutes(mins)
    self
  end

  def -(minutes)
    hrs, mins = parse_minutes(minutes)
    decrement_hour(hrs)
    decrement_minutes(mins)
    self
  end

  def to_s
    "%02d:%02d" % [hour, minute]  
  end

  def ==(other)
    self.hour == other.hour && self.minute == other.minute
  end

  private 

  def parse_minutes(minutes)
    minutes.divmod(60)
  end

  def increment_hour(num_hours)
    @hour += num_hours
    @hour -= 24 while @hour >= 24
  end

  def increment_minutes(num_minutes)
    @minute += num_minutes
    if @minute >= 60
      increment_hour(1)
      @minute -= 60
    end
  end

  def decrement_hour(num_hours)
    @hour -= num_hours
    @hour += 24 while @hour < 0
  end

  def decrement_minutes(num_minutes)
    @minute -= num_minutes
    if @minute <= 0
      decrement_hour(1)
      @minute += 60
    end
  end
end
