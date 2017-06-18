class Nema17 < SolidRuby::Assembly
  WIDTH = 43
  HEIGHT = 40

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

  def description
    "Nema17 Motor"
  end
end
