class App
  def initialize
    @formats = ['year', 'month', 'day', 'hour', 'minute', 'second']
  end

  def call(env)
    @env = env
    [status, headers, body(status)]
  end

  private

  def status
    if wrong_path?
      404
    elsif wrong_formats.size.positive?
      400
    else
      200
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body(status)
    case status
    when 200
      ["#{time_by_format}\n"]
    when 400
      ["Unknown time format [#{wrong_formats.join(', ')}]\n"]
    when 404
      ["Invalid URL\n"]
    end
  end

  def wrong_path?
    @env['REQUEST_METHOD'] != 'GET' || @env['PATH_INFO'] !~ /\/time/ || @env['QUERY_STRING'] !~ /format=/
  end

  def time_by_format
    time = Time.now
    @requested_format.map { |r_format| time.send(r_format.to_sym) }.join('-')
  end

  def wrong_formats
    @requested_format = @env['QUERY_STRING'][7..].split('%2C')
    @requested_format - @formats
  end
end
