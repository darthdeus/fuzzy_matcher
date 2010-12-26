require 'rspec'

# $LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))


Rspec.configure do |c|
  c.mock_with :rspec
end

require 'matcher'
include Matcher