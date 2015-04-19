class Meetup

  DATE_RANGES = {
    first: [1, 7],
    second: [8, 14],
    third: [15, 21],
    fourth: [22, 28], 
    last: [-7, -1],
    teenth: [13, 19]
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    range = date_range(schedule)
    pluck_date(weekday, range)
  end

  private 

  attr_reader :month, :year

  def date_range(schedule)
    from, to = DATE_RANGES[schedule]
    Date.new(year, month, from)..Date.new(year, month, to)
  end

  def pluck_date(weekday, date_range)
    date_range.each do |date|
      return date if date.send(weekday.to_s + "?") 
    end
  end
end
