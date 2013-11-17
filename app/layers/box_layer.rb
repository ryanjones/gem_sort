class BoxLayer < Joybox::Core::Layer
  scene

  def on_enter
    load_sprite_sheet
    handle_touches
  end

  def load_sprite_sheet
    SpriteFrameCache.frames.add file_name: "sprites/stars.plist"
    @sprite_batch = SpriteBatch.new file_name: "sprites/stars.png"
    self << @sprite_batch

    @blue_box = Bucket.new({frame_name: 'blue_box.png', position: [300,300], home_position: [100,100]})


    @star_green = Gem.new({frame_name: 'green_star.png', position: [100,200], home_position: [100,200]})
    @star_blue = Gem.new({frame_name: 'blue_star.png', position: [100,300], home_position: [100,300]})
    @star_orange = Gem.new({frame_name: 'red_star.png', position: [100,100], home_position: [100,100]})

    @sprite_batch << @star_green
    @sprite_batch << @star_blue
    @sprite_batch << @star_orange
    @sprite_batch << @blue_box

    @stars = Array.new
    [@star_green, @star_blue, @star_orange].each do |g|
      @stars << g
    end
  end

  def handle_touches
    on_touches_began do |touches, event|
      touch = touches.any_object
      @stars.each do |g|
        if g.touched?(touch.location)
          g.movable = true
          sprite_to_front(g)
        end
      end
    end

    on_touches_moved do |touches, event|
      touch = touches.any_object
      @stars.each do |g|
        if g.movable
          g.position = touch.location
        end
      end
    end

    on_touches_ended do |touches, event|
      touch = touches.any_object
      @stars.each do |g|
        if g.movable
          move_to_action = Move.to position: g.home_position
          g.run_action move_to_action
          g.movable = false
        end
      end
    end
  end

  def sprite_to_front(sprite)
    @sprite_batch.removeChild(sprite)
    @sprite_batch << sprite
  end
end