require 'app'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'rack-gsub')

use Rack::NoWidow

run App.new
