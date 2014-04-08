class Kite < Joybox::Core::Sprite


  def flight
    x =  Rotate.by angle: -30.0, duration: 2
    y =  Rotate.by angle: 30.0, duration: 2
    s = Sequence.with actions: [x,y,Callback.with(&repeated)]
    self.run_action s
  end

  def repeated
    Proc.new do 
      flight
    end
  end

  def flight_to_right_side
    abstract_flight_to(:right)
  end

  def flight_to_the_left_side
    abstract_flight_to(:left)
  end

  private

  def abstract_flight_to(t)
    d = {
      :left => [false, -220],
      :right => [true, 220]
    }

    x = d[t][0]
    z = d[t][1]

    self.flip x: x, y: false
    run_action Move.by position: [z,0], duration:1
  end

end
