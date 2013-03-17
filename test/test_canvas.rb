require 'test/unit'
require 'mocha/setup'
require './lib/oocairo'

class SpyObject
  attr_reader :last_pos
  attr_reader :draw_to_called

  def initialize
    @draw_to_called = false
  end

  def draw_to(context, pos)
    @draw_to_called = true
    @last_pos = pos
  end
end

class TestCanvas < Test::Unit::TestCase

  def setup
    @canvas = Cairo::Canvas.new [100, 100]
  end

  def testCanvasCannotBeCreatedWithoutSize
    assert_raise(ArgumentError) { Cairo::Canvas.new }
  end

  def testCanvasCannotBeGivenNegativeSize
    assert_raise(ArgumentError) { Cairo::Canvas.new [100, -100]}
    assert_raise(ArgumentError) { Cairo::Canvas.new [-100, 100]}
    assert_raise(ArgumentError) { Cairo::Canvas.new [-100, -100]}
  end

  def testCanvasDrawsObjectsWhenPassed
    @obj = mock
    @obj.expects(:draw_to).once

    @canvas.draw @obj, [0,0]
  end

end