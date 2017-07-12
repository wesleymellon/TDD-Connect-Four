$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "connect_four"

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:write) }
end