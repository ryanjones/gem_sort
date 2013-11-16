class BoxLayer < Joybox::Core::Layer
  scene

  def on_enter
    load_sprite_sheet
    handle_touches
  end

  def load_sprite_sheet
    SpriteFrameCache.frames.add file_name: "sprites/sprites.plist"
    @sprite_batch = SpriteBatch.new file_name: "sprites/sprites.png"
    self << @sprite_batch


    @wood_block = Bucket.new({frame_name: 'Wood Block.png', position: [300,300], home_position: [100,100]})
    @gem_green = Gem.new({frame_name: 'Gem Green.png', position: [100,200], home_position: [100,200]})
    @gem_blue = Gem.new({frame_name: 'Gem Blue.png', position: [100,300], home_position: [100,300]})
    @gem_orange = Gem.new({frame_name: 'Gem Orange.png', position: [100,100], home_position: [100,100]})

    @sprite_batch << @gem_green
    @sprite_batch << @gem_blue
    @sprite_batch << @gem_orange
    @sprite_batch << @wood_block

    self.reorderChild(@gem_green, z: 10)
    self.reorderChild(@gem_blue, z: 10)
    self.reorderChild(@gem_orange, z: 10)
    self.reorderChild(@wood_block, z: 1)

    @gems = Array.new
    [@gem_green, @gem_blue, @gem_orange].each do |g|
      @gems << g
    end
  end

  def handle_touches
    on_touches_began do |touches, event|
      touch = touches.any_object
      @gems.each do |g|
        if g.touched?(touch.location)
          g.movable = true

          # extend sprite bathc to redraw the child
          @sprite_batch.removeChild(g)
          @sprite_batch << g

          #store the z index on the child so we can always know the z index
          self.reorderChild(g, z: 100)
        end
      end
    end

    on_touches_moved do |touches, event|
      touch = touches.any_object
      @gems.each do |g|
        if g.movable == true
          g.position = touch.location
        end
      end
    end

    on_touches_ended do |touches, event|
      touch = touches.any_object
      @gems.each do |g|
        if g.movable == true
          move_to_action = Move.to position: g.home_position
          g.run_action move_to_action
          g.movable = false
        end
      end
    end
  end


end