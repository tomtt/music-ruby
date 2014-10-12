require 'spec_helper'

RSpec.configure do |rspec|
  # MUST be rspec.include, not just include, otherwise the methods
  # will be mixed into your SUTs as well, potentially masking
  # failures.
end
