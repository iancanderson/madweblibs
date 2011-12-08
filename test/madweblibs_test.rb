require 'test/unit'
require_relative '../lib/madweblibs'

class MadweblibsTest < Test::Unit::TestCase
  def test_dont_blow_up
    assert_nothing_raised do
      Madweblibs.generate
    end
  end
end
