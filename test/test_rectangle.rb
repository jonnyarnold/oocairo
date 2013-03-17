require 'test/unit'
require './lib/oocairo'

class TestRectangle < Test::Unit::TestCase
  
  def setup
    @rect = Cairo::Rectangle.new [10, 10]
  end

  def testRectangleStartsWithNoFill
    assert @rect.fill_color.nil?
  end

  def testRectangleStartsWithNoStroke
    assert @rect.stroke_color.nil?
  end

end