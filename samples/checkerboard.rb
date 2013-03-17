# Ensure lib is in search path; not required when gem installed
$LOAD_PATH << './../lib'

require 'oocairo'

class Checkerboard

  # Creates the Checkerboard
  def initialize(square_size: 10, border: 10, labels: false)
    @square_size = square_size
    @border = border
    @show_labels = labels
  end

  # Draws the checkerboard to the given context at the given position.
  def draw_to(context, pos)
    draw_background(context, pos)
    
    grid_top_left = [pos[0] + @border, pos[1] + @border]
    draw_grid(context, grid_top_left)

    draw_labels(context, pos) if @show_labels
  end

  private

  # Draws a gray background at the given position on the context.
  # The background is expected to be drawn before the grid.
  def draw_background(context, pos)
    bg_size = (@border * 2) + (@square_size * 8)
    bg = square(bg_size, :gray)
    bg.draw_to context, pos
  end

  # Draws an 8x8 grid of alternating black and white squares at the position
  # specified to the context.
  def draw_grid(context, pos)
    whiteSquare = square(@square_size, :white)
    blackSquare = square(@square_size, :black)

    (0..7).each do |y_index|
      (0..7).each do |x_index|
        x_pos = pos[0] + (x_index * @square_size)
        y_pos = pos[1] + (y_index * @square_size)
        is_white = (y_index + x_index) % 2 == 0

        if is_white
          whiteSquare.draw_to context, [x_pos, y_pos]
        else
          blackSquare.draw_to context, [x_pos, y_pos]
        end
      end
    end
  end

  # Creates a square (Cairo::Rectangle) of the given side length and color
  def square(side_length, color)
    sq = Cairo::Rectangle.new [side_length, side_length]
    sq.fill_color = color
    sq
  end

  # Draws labels for the checkerboard against the border.
  # As with chess, the rows are numbered and the columns are given letters.
  def draw_labels(context, pos)
    draw_column_labels(context, pos)
    draw_row_labels(context, pos)
  end

  # Draws column labels in the border of the checkerboard
  def draw_column_labels(context, pos)
    y_pos = @border
    context.set_font_size @border
    labels = %w(a b c d e f g h)
    (0..7).each do |x_index|
      x_pos = pos[0] + @border + (x_index * @square_size)
      context.move_to(x_pos, y_pos)
      context.text_path labels[x_index]
      context.fill
    end
  end

  # Draws row labels in the border of the checkerboard
  def draw_row_labels(context, pos)
    x_pos = 0
    context.set_font_size @border
    labels = %w(1 2 3 4 5 6 7 8)
    (0..7).each do |y_index|
      y_pos = pos[1] + @border + ((y_index + 1) * @square_size) # +1 to ensure the baseline is at the bottom of the relevant square
      context.move_to(x_pos, y_pos)
      context.text_path labels[y_index]
      context.fill
    end
  end
end

canvas = Cairo::Canvas.new [100, 100]
board = Checkerboard.new(labels: true)
canvas.draw board, [0,0]
canvas.save_svg "example.svg"