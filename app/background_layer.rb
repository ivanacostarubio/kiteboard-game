class BackgroundLayer < Joybox::Core::Layer

  scene

  SPEED = 5

  def on_enter
    add_clouds
    setup_audio
    add_background

    schedule_update do |dt|
      add_clouds if rand(50) == 1
      background_rotation @background
    end
  end

  def background_rotation(bg)
    #puts bg.position.inspect
  end

  def add_clouds
    @cloud = Sprite.new(file_name: "cloud.png", position: [-100, Screen.height - rand(100)])
    @cloud.run_action Move.by position: [700, 0], duration: SPEED
    self << @cloud
  end

  def add_background
    @background = Sprite.new(file_name: 'san_blas1.jpeg', position: [-120,300])
    move = Move.by position: [550,0], duration: SPEED
    bg_s = Sequence.with actions: [move, Callback.with(&move_back)]
    @background.run_action bg_s
    self << @background
  end

  def move_back
    Proc.new do 
      App.notification_center.post 'ChangeSideToRight'

      move = Move.by position: [-550,0], duration: 10
      bg_s = Sequence.with actions: [move, Callback.with(&move_in)]
      @background.run_action bg_s
    end
  end

  def move_in
    Proc.new do 
      App.notification_center.post 'ChangeSideToLeft'

      move = Move.by position: [550,0], duration: 10
      bg_s = Sequence.with actions: [move, Callback.with(&move_back)]
      @background.run_action bg_s
    end
  end

  def setup_audio
    background_audio = BackgroundAudio.new
    background_audio[:bg] = 'bg.mp3'
    background_audio.play(:bg)
  end

end
