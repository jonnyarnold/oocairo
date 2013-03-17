require 'cairo' # Pretty useless class without it!
require 'tempfile' # For working file when drawing
require 'fileutils' # For copying of working file when saving

# Object-Oriented bindings to Cairo for Ruby
module Cairo

  # Surface-agnostic context for Cairo.
  # 
  # Canvas allows you to draw a graphic -before- you specify its 
  # destination.
  class Canvas
    
    # Create a Canvas
    # [size] An [x,y] array. x and y cannot be negative.
    def initialize(size)
      Cairo.validate_size size
      @width, @height = size

      @workingFile = Tempfile.new ['cairo-canvas', '.svg']
      @surface = Cairo::SVGSurface.new(@workingFile.path, @width, @height)
      @context = Cairo::Context.new @surface
    end

    # Draws the given object to the internal Cairo context.
    # [obj] The object to draw. Must respond to draw_to(context, pos)
    # [pos] The anchor coordinate to place the object on the canvas. e.g. for a Rectangle, this is the top-left corner.
    def draw(obj, pos)
      obj.draw_to @context, pos
    end

    # Sets the background color of the canvas to the given color.
    # [color] The color (as long as Cairo::Context.set_source_color can parse it, it's valid; try :white or Cairo::Color)
    # Note that this method floods the canvas with the chosen color when it is called, potentially overwriting objects already written to the canvas.
    def bg_color=(color)
      @context.set_source_color color
      @context.paint
    end

    # Saves the current Canvas as an SVG.
    # [filename] The filename to save to.
    def save_svg(filename)
      @surface.finish
      FileUtils.cp @workingFile.path, filename
    end
  end
end