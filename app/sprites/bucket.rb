class Bucket < Joybox::Core::Sprite
  attr_accessor :movable, :home_position

  def initialize(opts={})
    super frame_name: opts[:frame_name], position: opts[:position]
    self.home_position = opts[:home_position]
  end


  # on touch event here
  # whenever the finger moves get the new position and 'move' this gem to it.
  # will need to save the gem home position to snap back to
  def touched?(touch_location)
    rect = CGRect.new(boundingBox.origin, boundingBox.size)
    CGRectContainsPoint(rect, touch_location)
  end

end