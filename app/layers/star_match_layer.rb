class StarMatchLayer < Joybox::Core::Layer
  scene

  def on_enter
    load_sprite_sheet
    handle_touches
  end

  def load_sprite_sheet
    SpriteFrameCache.frames.add file_name: "sprites/stars.plist"
    @sprite_batch = SpriteBatch.new file_name: "sprites/stars.png"
    self << @sprite_batch

    @blue_box = Box.new({frame_name: 'blue_box.png', position: [300,300], home_position: [100,100]})


    @star_green = Star.new({frame_name: 'green_star.png', position: [100,200], home_position: [100,200]})
    @star_blue = Star.new({frame_name: 'blue_star.png', position: [100,300], home_position: [100,300]})
    @star_orange = Star.new({frame_name: 'red_star.png', position: [100,100], home_position: [100,100]})

    @sprite_batch << @star_green
    @sprite_batch << @star_blue
    @sprite_batch << @star_orange
    @sprite_batch << @blue_box

    @stars = Array.new
    [@star_green, @star_blue, @star_orange].each do |s|
      @stars << s
    end
  end

  def handle_touches
    on_touches_began do |touches, event|
      touch = touches.any_object
      @stars.each do |s|
        if s.touched?(touch.location)
          s.movable = true
          sprite_to_front(s)
        end
      end
    end

    on_touches_moved do |touches, event|
      touch = touches.any_object
      @stars.each do |s|
        if s.movable
          s.position = touch.location
        end
      end
    end

    on_touches_ended do |touches, event|
      touch = touches.any_object
      @stars.each do |s|
        if s.movable && touching_matching_box(s)
          move_to_action = Move.to position: s.home_position
          s.run_action move_to_action
          s.movable = false
        end
      end
    end
  end

  def touching_matching_box(sprite)

  end

  def sprite_to_front(sprite)
    @sprite_batch.removeChild(sprite)
    @sprite_batch << sprite
  end
end