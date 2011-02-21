require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/rack-no-widow"
require 'plastic_test_helper'

module Test
  module Unit
    class TestCase
      include PlasticTestHelper
    end
  end
end
