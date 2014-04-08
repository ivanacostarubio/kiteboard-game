class Kiter < Joybox::Core::Sprite

  attr_accessor :initial_jump_y_coordinate, :final_jump_y_coordinate

  def initialize(args)
    @landed = false
    super
  end

  def landed?
    @landed = true if ((@final_jump) && @final_jump <= (initial_jump_y_coordinate + 100))
    @landed
  end

  def land
    @final_jump = position.y
  end

  def jump(r)
    @final_jump = nil
    @landed = false
    @initial_jump_y_coordinate = self.position.y
    r += 150 if r < 150
    j = Jump.by position: [0, 0], height: r, duration: 2
    jump = Sequence.with actions: [j, Callback.with(&landing_sprite)]
    self.run_action(jump)
    self.file_name = "raley.png"
  end

  def move_up
    puts "Moving up"
    run_action Move.by position: [0,50], duration: 1
  end

  def move_down
    puts "Moving  Down"
    run_action Move.by position: [0,-50], duration: 1
  end

  def crash
    self.file_name = "crash1.png"
  end

  def landing_sprite
    Proc.new do 
      if landed?
        self.file_name = "kiter.png"
      else
        self.file_name = "crash1.png"
        crash 
      end
    end
  end

  def trick
    puts "Haciendo un truco"
  end

  def debug
    puts "Kiter Y: #{position.y.inspect}"
    puts "Initial Jump Coordinates #{initial_jump_y_coordinate.inspect}"
    puts "Final jump Coordinates #{@final_jump}"
    puts "Should land #{landed?}"
  end
end

