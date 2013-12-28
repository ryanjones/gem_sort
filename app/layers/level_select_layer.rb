class LevelSelectLayer < Joybox::Core::Layer
  scene

  def on_enter
    load_sprite_sheet
    handle_touches
  end

  def load_sprite_sheet
    SpriteFrameCache.frames.add file_name: 'sprites/stars.plist'
    @sprite_batch = SpriteBatch.new file_name: 'sprites/stars.png'
    self << @sprite_batch

    @menu_select_button = MenuButton.new({frame_name: 'back.png', position: [100,700]})
    @level_1 = LevelBox.new({frame_name: 'level_1.png', position: [100,600], level_number: '1'})
    @sprite_batch << @level_1
    @sprite_batch << @menu_select_button
  end

  def handle_touches
    on_touches_began do |touches, event|
      touch = touches.any_object
      if @level_1.touched?(touch.location)
        Joybox.director.replace_scene StarMatchLayer.scene
      end
      if @menu_select_button.touched?(touch.location)
        Joybox.director.replace_scene MenuLayer.scene
      end
    end
  end
end