require_relative 'middleware/my_logger.rb'
require_relative 'config/environment'

use MyLogger, logdev: File.expand_path('log/app.log', __dir__)
run Simpler.application
