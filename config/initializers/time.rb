require 'date'
class Time
  def to_datetime
    seconds = sec + Rational(usec, 10**6)

    offset = Rational(utc_offset, 60 * 60 * 24)
    DateTime.new(year, month, day, hour, min, seconds, offset)
  end
end