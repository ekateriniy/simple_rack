require_relative 'app'
require_relative 'time_format'

ROUTES = {
  '/time' => App.new
}.freeze

use Rack::ContentType, 'text/plain'
run Rack::URLMap.new(ROUTES)
