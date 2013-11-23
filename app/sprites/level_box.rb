class LevelBox < Joybox::Core::Sprite
  attr_accessor :level_number

  def initialize(opts={})
    super frame_name: opts[:frame_name], position: opts[:position]
    self.level_number = opts[:level_number]
  end

  def touched?(touch_location)
    rect = CGRect.new(boundingBox.origin, boundingBox.size)
    CGRectContainsPoint(rect, touch_location)
  end
end