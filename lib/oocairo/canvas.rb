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

    def draw(obj, pos)
      obj.draw_to @context, pos
    end

    def bg_color=(color)
      @context.set_source_color color
      @context.paint
    end

    def save_svg(filename)
      @surface.finish
      FileUtils.cp @workingFile.path, filename
    end
  end
end