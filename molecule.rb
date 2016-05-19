require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "random walk"

    #@background_image = Gosu::Image.new("molecule/grid.gif", :tileable => true)

    @molecule = Molecule.new
    @molecule.warp(200,150)
  end

  def update
    @molecule.move
  end

  def draw
    @molecule.draw
    #@background_image.draw(0, 0, 0)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end


class Molecule
  def initialize
    rnd = Random.new
    @image = Gosu::Image.new("molecule/particle.bmp")
    @dx = @dy = 1.0
    @x = @y = 0.0
    @angle = 40#rnd.rand(360.0)
    @v = 5.0

  end

  def warp(x,y)
    @x, @y = x, y
  end

  def move
	## wall collision
   

    #@angle += (2*@angle)     if @x + @dx <= 50   && @dy >= 0
    #@angle += (2*@angle)     if @x + @dx <= 50   && @dy <= 0
    #@angle += (2*@angle)     if @x + @dx >= 590  && @dy >= 0
    #@angle += (2*@angle)     if @x + @dx >= 590  && @dy <= 0

    #@angle += ( 180+2*@angle) if @y + @dy <= 50   && @dx >= 0
    #@angle += ( 180+2*@angle) if @y + @dy <= 50   && @dx <= 0
    #@angle += ( 180+2*@angle) if @y + @dy >= 430  && @dx >= 0
    #@angle += ( 180+2*@angle) if @y + @dy >= 430  && @dx <= 0


    @angle += 2*@angle if @x + @dx <= 50 || @x + @dx >=590

    if @y + @dy <= 50   && @dx >= 0
      @angle = (-@angle)
      puts "case 1"
    end
    if @y + @dy <= 50   && @dx <= 0
      @angle = (-@angle) 
      puts "case 2"
    end
    if @y + @dy >= 430  && @dx >= 0
      @angle = (-@angle) 
      puts "case 3"
    end
    if @y + @dy >= 430  && @dx <= 0
      @angle = (-@angle) 
      puts "case 4"
    end


    @angle %=360

    @dx = Math.cos(@angle*Math::PI/180)
    @dy = Math.sin(@angle*Math::PI/180)

    @x += @dx*@v
    @y += @dy*@v
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
    puts "#{@dx} : #{@dy} / #{@x.to_i} : #{@y.to_i} :: #{@angle.to_i}"
  end    
end

window = GameWindow.new
window.show
