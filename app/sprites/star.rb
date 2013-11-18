class Star < Joybox::Core::Sprite
  attr_accessor :movable, :home_position, :name, :colour

  def initialize(opts={})
    super frame_name: opts[:frame_name], position: opts[:position]
    self.home_position = opts[:home_position]
    self.name = opts[:frame_name]
    self.colour = opts[:colour]
  end

  def touched?(touch_location)
    rect = CGRect.new(boundingBox.origin, boundingBox.size)
    CGRectContainsPoint(rect, touch_location)
  end

end