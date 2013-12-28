class AboutLayer < Joybox::Core::Layer
  scene

  def on_enter
    load_sprite_sheet
    handle_touches
  end

  def load_sprite_sheet
    SpriteFrameCache.frames.add file_name: 'sprites/stars.plist'
    @sprite_batch = SpriteBatch.new file_name: 'sprites/stars.png'
    self << @sprite_batch

    @level_select_button = LevelSelectButton.new({frame_name: 'back.png', position: [100,700]})
    @sprite_batch << @level_select_button


    info = Label.new text: 'https://github.com/RyanonRails/gem_sort', font_size: 32, position: Screen.center
    self << info
  end

  def handle_touches
    on_touches_began do |touches, event|
      touch = touches.any_object
      if @level_select_button.touched?(touch.location)
        Joybox.director.replace_scene MenuLayer.scene
      end
    end
  end
end