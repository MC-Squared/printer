class PrinterAssembly < SolidRuby::Assembly

  # Assemblies are used to show how different parts interact on your design.

  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  def Al2040(len)
    cube(20, 40, len)
  end

  def part(show)
    @extrusion_w = 20
    @extrusion_h = 40

    #printable area
    @printable_x = 500
    @printable_y = 500
    @printable_z = 500

    #X carriage size (determines how much we need to add to printable_* to achieve it)
    @carriage_x = 40
    @carriage_y = 40
    @carriage_z = 40

    #Size of gantry plates
    @plate_w = 100
    @plate_t = 10 #thickness

    #internal area, i.e. the extrusions should be *outside* this box
    @in_x = @printable_x + @carriage_x
    @in_y = @printable_y + @carriage_y + @plate_t + @extrusion_w
    @in_z = @printable_z + @carriage_z

    #internal frame, i.e. the box that holds the X/Y gantries
    @if_x = @in_x + @extrusion_w * 2
    @if_y = @in_y + @extrusion_w * 2

    @out_z = @in_z + @extrusion_h * 3 #base surrounds, top surrounds, carriage
    @out_y = @in_y + @extrusion_w * 4 #surrounds * 2, carriage * 2

    # printable area
    #  res = cube(@printable_x, @printable_y, @printable_z)
    #    .translate(x: @extrusion_w*2.0, y: @extrusion_w*2.0, z: @extrusion_h)
    #    .color("LIGHTBLUE")

     res = cube(@in_x, @in_y, @in_z)
       .translate(x: @extrusion_w*2.0, y: @extrusion_w*2.0, z: @extrusion_h)
       .color("LIGHTBLUE")

    back_pos = @in_y + @extrusion_w * 2.0
    right_pos = @in_x + @extrusion_w * 3.0
    top_pos = @in_z + @extrusion_h * 2.0
    #4 corner posts
    res += Al2040.new(@out_z)

    res += Al2040.new(@out_z)
      .translate(y: back_pos)

    res += Al2040.new(@out_z)
      .translate(y: back_pos)
      .translate(x: right_pos)

    res += Al2040.new(@out_z)
      .translate(x: right_pos)


    # 4 base sides
    res += Al2040.new(@if_x)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w)
    res += Al2040.new(@if_x)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w, y: back_pos + @extrusion_w)

    res += Al2040.new(@if_y)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: @extrusion_w, y: @extrusion_h)
      #.debug
    res += Al2040.new(@if_y)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: right_pos + @extrusion_w, y: @extrusion_h)

    # 4 top sides
    res += Al2040.new(@if_x)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w, z: top_pos)
    res += Al2040.new(@if_x)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w, y: back_pos + @extrusion_w, z: top_pos)

    res += Al2040.new(@if_y)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: @extrusion_w, y: @extrusion_h, z: top_pos)
    res += Al2040.new(@if_y)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: right_pos + @extrusion_w, y: @extrusion_h, z: top_pos)

    #top_pos -= 50
    #Y Carriage
    res += Al2040.new(@if_y)
      .rotate(z: 90)
      .rotate(x: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w, y: @if_y + @extrusion_w, z: top_pos - @extrusion_h)
      .debug
    res += Al2040.new(@if_x - @extrusion_w * 2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w*2.0, y: back_pos, z: top_pos - @extrusion_h)
      #.debug
    res += Al2040.new(@if_y)
      .rotate(z: 90)
      .rotate(x: -90)
      .rotate(y: 90)
      .translate(x: right_pos, y: @extrusion_w, z: top_pos - @extrusion_h)
      .debug
    res += Al2040.new(@if_x - @extrusion_w * 2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w * 2.0, y: @extrusion_w, z: top_pos - @extrusion_h)
      #.debug

    #Z Motors
    res += Nema17.new
      .translate(x: @extrusion_w, y: @printable_y + @extrusion_w*3.0 - Nema17::WIDTH/2.0, z: @extrusion_h)

    #Z Rods
    res += cylinder(d: 8, h: @in_z + @extrusion_h)
      .translate(x: -4, y: -4)
      .translate(x: (@in_x + @extrusion_w*4.0)/2.0, y: @in_y + @extrusion_w*3.5, z: @extrusion_h)
    res += cylinder(d: 8, h: @in_z + @extrusion_h)
      .translate(x: -4, y: -4)
      .translate(x: @extrusion_w/2.0, y: (@in_y + @extrusion_w*2.0)/2.0 + @extrusion_w, z: @extrusion_h)
    res += cylinder(d: 8, h: @in_z + @extrusion_h)
      .translate(x: -4, y: -4)
      .translate(x: (@in_x + @extrusion_w*3.5), y: (@in_y + @extrusion_w*2.0)/2.0 + @extrusion_w, z: @extrusion_h)

    #Extruder (E3D V6)
    res += cube(41, 30, 63.5)
      .translate(x: @printable_x/2.0, y: ((@printable_y + @extrusion_h*2.0)/2.0 - @extrusion_w*1.5) * 2, z: @printable_z + @extrusion_h - 10)
      .color("BLUE")
    res
  end
end
