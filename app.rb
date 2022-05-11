class App
  def call(env)
    request = Rack::Request.new(env)
    requested_time = TimeFormat.new(request.params['format'].split(','))
    
    build_response(requested_time)
  end

  def build_response(requested_time)
    response = Rack::Response.new
    response.status = requested_time.invalid_format? ? 400 : 200
    response.write(requested_time.by_format)
    response.finish
  end
end
