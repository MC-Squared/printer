class Al2040 < SolidRuby::Assembly
  WIDTH = 20
  DEPTH = 40

  def initialize(len = 10)
    @x = WIDTH
    @y = DEPTH
    @z = len
    @hardware = []
    @color = 'GREY'
  end

  def part(show)
    cube(@x, @y, @z).color(@color)
  end
end
