require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "random walk"

    #@background_image = Gosu::Image.new("walkmedia/c9907.gif", :tileable => true)

    @particles = []
    100.times do |i|
      @particles[i] = Particle.new
    end
    #@particles = Array.new(100)
    #@particles.each {|i| i = Particle.new}

    rnd = Random.new
    @particles.each {|i| i.warp(rnd.rand(100)+270,rnd.rand(100)+190) }
  end

  def update
    @particles.each {|i| i.move}
  end

  def draw
    @particles.each {|i| i.draw}
    #@background_image.draw(0, 0, 0)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end


class Particle
  def initialize
    @image = Gosu::Image.new("walkmedia/particle.bmp")
    @x = @y = @angle = 0.0

  end

  def warp(x,y)
    @x, @y = x, y
  end

  def move
    rnd = Random.new
    l = rnd.rand(1.0)
    @x += Math.cos(2*Math::PI*l)
    @y += Math.sin(2*Math::PI*l)
    @angle += 1
    @x %= 640
    @y %= 480
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
    puts "#{@x} : #{@y}"
  end    
end

window = GameWindow.new
window.show
