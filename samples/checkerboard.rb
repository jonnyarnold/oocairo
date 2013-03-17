# Ensure lib is in search path; not required when gem installed
$LOAD_PATH << './../lib'

require 'oocairo'

whiteSquare = Cairo::Rectangle.new [10, 10]
whiteSquare.fill_color = :white

blackSquare = Cairo::Rectangle.new [10, 10]
blackSquare.fill_color = :black

bgcolor = :gray

canvas = Cairo::Canvas.new [100, 100]
canvas.bg_color = bgcolor

initial_offset = [10, 10]
(0..7).each do |y_index|
  (0..7).each do |x_index|
    x_pos = initial_offset[0] + (x_index * 10)
    y_pos = initial_offset[1] + (y_index * 10)
    is_white = (y_index + x_index) % 2 == 0

    if is_white
      canvas.draw whiteSquare, [x_pos, y_pos]
    else
      canvas.draw blackSquare, [x_pos, y_pos]
    end
  end
end

canvas.save_svg "example.svg"