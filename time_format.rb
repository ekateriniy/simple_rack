class TimeFormat
  FORMATS = ['year', 'month', 'day', 'hour', 'minute', 'second'].freeze

  def initialize(formats)
    @requested_format = formats
  end

  def by_format
    if invalid_format?
      "Unknown time format [#{invalid_formats.join(', ')}]\n"
    else
      time = Time.now
      @requested_format.map { |r_format| time.send(r_format.to_sym) }.join('-') + "\n"
    end
  end

  def invalid_formats
    @requested_format - FORMATS
  end

  def invalid_format?
    invalid_formats.size.positive?
  end
end
