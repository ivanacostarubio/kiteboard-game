class Boton < Joybox::Core::Sprite

  def initialize(opts={})
    super file_name: "boton.png", position: opts[:position]
  end

  def touched?(touch_location)
    return if @frozen
    rect = CGRect.new(boundingBox.origin, boundingBox.size)
    CGRectContainsPoint(rect, touch_location)
  end
end


class Kiter < Joybox::Core::Sprite

  def move_up
    puts "Moving up"
    run_action Move.by position: [0,50], duration: 1
  end

  def move_down
    puts "Moving  Down"
    run_action Move.by position: [0,-50], duration: 1
  end

  def crash
    file_name = "crash1.png"
  end
end

