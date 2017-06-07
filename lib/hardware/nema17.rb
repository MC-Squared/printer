class Nema17 < SolidRuby::Assembly
  WIDTH = 43
  HEIGHT = 60

  def initialize()
    @x = WIDTH
    @y = WIDTH
    @z = HEIGHT
    @hardware = []
    @color = 'BLUE'
  end

  def part(show)
    cube(@x, @y, @z).color(@color)
  end
end
