require './config/environment'

use Rack::Static, :urls => ['/dist', '/assets'], :root => 'public'


use StudentController
run ApplicationController