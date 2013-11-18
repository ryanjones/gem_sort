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

    @box_green = Box.new({frame_name: 'green_box.png', position: [900,200], colour: 'green'})
    @box_blue = Box.new({frame_name: 'blue_box.png', position: [900,400], colour: 'blue'})
    @box_red = Box.new({frame_name: 'red_box.png', position: [900,600], colour: 'red'})

    @star_green = Star.new({frame_name: 'green_star.png', position: [100,200],
                            colour: 'green', home_position: [100,200]})
    @star_blue = Star.new({frame_name: 'blue_star.png', position: [100,300],
                            colour: 'blue', home_position: [100,300]})
    @star_red = Star.new({frame_name: 'red_star.png', position: [100,100],
                             colour: 'red', home_position: [100,100]})

    @sprite_batch << @star_green
    @sprite_batch << @star_blue
    @sprite_batch << @star_red
    @sprite_batch << @box_green
    @sprite_batch << @box_blue
    @sprite_batch << @box_red

    @stars = Array.new
    [@star_green, @star_blue, @star_red].each do |s|
      @stars << s
    end

    @boxes = Array.new
    [@box_blue, @box_red, @box_green].each do |b|
      @boxes << b
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
        if s.movable && touching_matched_box(s, touch)
          sprite_remove(s)
          @stars.delete(s)
        else
          move_to_action = Move.to position: s.home_position
          s.run_action move_to_action
          s.movable = false
        end
      end
    end
  end

  def sprite_to_front(sprite)
    @sprite_batch.removeChild(sprite)
    @sprite_batch << sprite
  end

  def sprite_remove(sprite)
    @sprite_batch.removeChild(sprite)
  end

  def sprite_show(sprite)
    show_action = Visibility.show
    sprite.run_action show_action
  end

  def sprite_hide(sprite)
    hide_action = Visibility.hide
    sprite.run_action hide_action
  end

  def sprite_toggle_visibility(sprite)
    toggle_visibility_action = Visibility.toggle
    sprite.run_action toggle_visibility_action
  end

  def touching_matched_box(sprite, touch)
    touched_box = nil
    @boxes.each do |b|
      touched_box = b if b.touched?(touch.location)
    end

    return true if touched_box.colour == sprite.colour
    false
  end
end
