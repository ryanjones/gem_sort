class MenuLayer < Joybox::Core::Layer
  scene

  def on_enter
    load_sprite_sheet
    handle_touches
  end

  def load_sprite_sheet
    SpriteFrameCache.frames.add file_name: 'sprites/stars.plist'
    @sprite_batch = SpriteBatch.new file_name: 'sprites/stars.png'
    self << @sprite_batch

    @start = LevelBox.new({frame_name: 'start.png', position: [200,600]})
    @about = LevelBox.new({frame_name: 'about.png', position: [200,400]})
    @sprite_batch << @start
    @sprite_batch << @about
  end

  def handle_touches
    on_touches_began do |touches, event|
      touch = touches.any_object
      if @start.touched?(touch.location)
        Joybox.director.replace_scene LevelSelectLayer.scene
      end
      if @about.touched?(touch.location)
        Joybox.director.replace_scene AboutLayer.scene
      end
    end
  end
end