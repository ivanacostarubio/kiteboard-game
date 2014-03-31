class GameLayer < Joybox::Core::Layer
  scene

  def on_enter
    self << BackgroundLayer.new

    @score = 0
    @landed = false
    add_elements
    add_buttons

    on_touches_began do |touches, event|
      touch = touches.any_object
      kiter_jump if @boton.touched? touch.location
      kiter_land if @land.touched? touch.location
      kiter_trick if @flip.touched? touch.location
    end

    @kite_change_side_observer = App.notification_center.observe 'ChangeSideToLeft' do |notification|

      @kiter.move_up 
      flip_kiter(false)
    end

    @kite_change_side_observer_l = App.notification_center.observe 'ChangeSideToRight' do |notification|
      flip_kiter(true)
      @kiter.move_down
    end

  end

  def kiter_land
    #
    # Create a more accurate function that represents 
    # how to land.
    #
    puts "Kiter Position #{@kiter.position.inspect}"
    @landed = true if @kiter.position.y >= initial_y
  end

  def initial_y
    @initial_y + 100
  end

  def add_buttons
    @boton = Boton.new(position: [30, 30])
    self << @boton

    @land = Boton.new(position: [Screen.center.x * 2 - 30, 30])
    self << @land

    @flip = Boton.new(position: [120, 30])
    self << @flip
  end

  def add_elements
   @kiter = Kiter.new(file_name: 'kiter.png', position: [Screen.center.x, 120], alive: true)
    self << @kiter
    @kiter.move_up
    @kiter.move_up


    @score_label = Label.new position: [ Screen.center.x , Screen.center.y * 1.8 ], font_size: 16, font_name: "Helvetica"
    @score_label.text = "Score: 0"

    self << @score_label

    puts "*" * 100
    puts Screen.center.inspect
    puts Screen.center.y.inspect
    puts Screen.height.inspect
  end

  def kiter_jump
    # We add the coordinates from where we started the jump
    @initial_y = position.y 

    @landed = false
    r = rand(300)
    r += 150 if r < 150
    j = Jump.by position: [0, 0], height: r, duration: 2
    jump = Sequence.with actions: [j, Callback.with(&landing_sprite)]
    @kiter.file_name = "raley.png"
    @kiter.run_action(jump)
    add_to_score(r + @score)
  end

  def landing_sprite
    Proc.new do 
      if @landed
        @kiter.file_name = "kiter.png"
      else
        @kiter.file_name = "crash1.png"
        crash 
      end
    end
  end

  def crash
    add_to_score(0)
    @kiter.crash
  end

  def add_to_score(score)
    @score = score
    @score_label.text = "Score #{score}"
  end

  def flip_kiter(z)
    @kiter.flip x: z, y: false
  end

  def kiter_trick
    puts "Haciendo un truco"
  end
end
