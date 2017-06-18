class Al2040 < SolidRuby::Assembly
  WIDTH = 20
  DEPTH = 40

  def initialize(len = 0)
    #@x = WIDTH
    #@y = DEPTH
    #@z = len
    @hardware = []
    @color = 'GREY'
    super({x: WIDTH, y: DEPTH, z: len})
  end

  def part(show)
    cube(@x, @y, @z).color(@color)
  end

  def description
    "2040 Extrusion, Length: " + @z.to_s
  end
end
