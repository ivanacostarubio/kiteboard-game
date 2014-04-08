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


