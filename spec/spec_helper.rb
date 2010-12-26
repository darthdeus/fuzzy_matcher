require 'rspec'

# $LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))


require 'matcher'
include Matcher


Rspec::Matchers.define :match_file do |pattern|
  match do |file|
    Fuzzy.match_file(file, pattern)
  end
end

Rspec.configure do |c|
  c.mock_with :rspec
end
