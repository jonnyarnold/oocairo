module Cairo

  # Cairo rectangle
  class Rectangle
    attr_accessor :stroke_color, :stroke_width, :fill_color

    # Creates a Rectangle
    # [size] A [width, height] pair.
    def initialize(size)
      Cairo.validate_size size
      @width , @height = size[0], size[1]

      @stroke_color = nil
      @stroke_width = 1
      @fill_color = nil
    end

    # Draws itself on the given context.
    # [context] The Cairo::Context to draw onto.
    # [pos] The top-left corner of the Rectangle.
    def draw_to(context, pos)
      draw_fill(context, pos)
      draw_stroke(context, pos)
    end

    private

    def draw_fill(context, pos)
      unless @fill_color.nil?
        context.set_source_color @fill_color
        context.fill do 
          path(context, pos)
        end
      end
    end

    def draw_stroke(context, pos)
      unless @stroke_color.nil?
        context.set_source_color @stroke_color
        context.line_width = @stroke_width
        context.stroke do 
          path(context, pos)
        end
      end
    end

    def path(context, pos)
      x,y = pos
      context.rectangle(x, y, @width, @height)
    end
  end
end