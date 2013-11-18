class Box < Joybox::Core::Sprite
  attr_accessor :colour

  def initialize(opts={})
    super frame_name: opts[:frame_name], position: opts[:position]
    self.colour = opts[:colour]
  end

  def touched?(touch_location)
    rect = CGRect.new(boundingBox.origin, boundingBox.size)
    CGRectContainsPoint(rect, touch_location)
  end

end