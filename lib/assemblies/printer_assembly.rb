class PrinterAssembly < SolidRuby::Assembly

  # Assemblies are used to show how different parts interact on your design.

  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  def Al2040(len)
    cube(20, 40, len)
  end

  def part(show)
    #printable area
    @printable_x = 550
    @printable_y = 550
    @printable_z = 550


    # printable area
     res = cube(@printable_x, @printable_y, @printable_z)
       .translate(x: Al2040::WIDTH*2.0, y: Al2040::WIDTH*2.0, z: Al2040::DEPTH)
       .color("LIGHTBLUE")

    #4 corner posts
    res += Al2040.new(@printable_z + Al2040::DEPTH*3.0)

    res += Al2040.new(@printable_z + Al2040::DEPTH*3.0)
      .translate(y: @printable_y + Al2040::WIDTH*4.0 - Al2040::DEPTH).debug

    res += Al2040.new(@printable_z + Al2040::DEPTH*3.0)
      .translate(y: @printable_y + Al2040::WIDTH*4.0 - Al2040::DEPTH)
      .translate(x: Al2040::WIDTH * 3.0 + @printable_x)

    res += Al2040.new(@printable_z + Al2040::DEPTH*3.0)
      .translate(x: Al2040::WIDTH * 3.0 + @printable_x)



    # 4 base sides
    res += Al2040.new(@printable_x + Al2040::WIDTH*2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: Al2040::WIDTH)
    res += Al2040.new(@printable_x + Al2040::WIDTH*2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: Al2040::WIDTH, y: @printable_y + Al2040::WIDTH*3.0)

    res += Al2040.new(@printable_y + Al2040::WIDTH*4.0 - Al2040::DEPTH*2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: Al2040::WIDTH, y: Al2040::DEPTH)
      #.debug
    res += Al2040.new(@printable_y + Al2040::WIDTH*4.0 - Al2040::DEPTH*2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: @printable_x + Al2040::WIDTH * 4.0, y: Al2040::DEPTH)

    # 4 top sides
    res += Al2040.new(@printable_x + Al2040::WIDTH * 2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: Al2040::WIDTH, z: @printable_z + Al2040::DEPTH*2.0)
    res += Al2040.new(@printable_x + Al2040::WIDTH * 2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: Al2040::WIDTH, y: @printable_y + Al2040::WIDTH*3.0, z: @printable_z + Al2040::DEPTH*2.0)

    res += Al2040.new(@printable_y + Al2040::WIDTH*4.0 - Al2040::DEPTH*2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: Al2040::WIDTH, y: Al2040::DEPTH, z: @printable_z + Al2040::DEPTH*2.0)
    res += Al2040.new(@printable_y + Al2040::WIDTH*4.0 - Al2040::DEPTH*2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .rotate(z: 90)
      .translate(x: @printable_x + Al2040::WIDTH * 4.0, y: Al2040::DEPTH, z: @printable_z + Al2040::DEPTH*2.0)

    #Y Carriage
    res += Al2040.new(@printable_y + Al2040::WIDTH*2.0)
      .rotate(z: 90)
      .rotate(x: 90)
      .rotate(y: 90)
      .translate(x: Al2040::WIDTH, y: @printable_y + Al2040::WIDTH*3.0, z: @printable_z + Al2040::DEPTH)
      .debug
    res += Al2040.new(@printable_x)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: Al2040::WIDTH*2.0, y: @printable_y + Al2040::WIDTH*2.0, z: @printable_z + Al2040::DEPTH)
      #.debug
    res += Al2040.new(@printable_y + Al2040::WIDTH*2.0)
      .rotate(z: 90)
      .rotate(x: -90)
      .rotate(y: 90)
      .translate(x: @printable_x + Al2040::WIDTH*3.0, y: Al2040::WIDTH, z: @printable_z + Al2040::DEPTH)
      .debug
    res += Al2040.new(@printable_x)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: Al2040::WIDTH*2.0, y: Al2040::WIDTH, z: @printable_z + Al2040::DEPTH)
      #.debug

    #Z Motors
    res += Nema17.new
      .translate(x: Al2040::WIDTH, y: @printable_y + Al2040::WIDTH*3.0 - Nema17::WIDTH/2.0, z: Al2040::DEPTH)

    #Z Rods
    res += cylinder(d: 8, h: @printable_z + Al2040::DEPTH)
      .translate(x: (@printable_x + Al2040::WIDTH*4.0)/2.0, y: @printable_y + Al2040::WIDTH*3.5, z: Al2040::DEPTH)
    res += cylinder(d: 8, h: @printable_z + Al2040::DEPTH)
      .translate(x: Al2040::WIDTH/2.0, y: (@printable_y + Al2040::WIDTH*2.0)/2.0 + Al2040::WIDTH, z: Al2040::DEPTH)
    res += cylinder(d: 8, h: @printable_z + Al2040::DEPTH)
      .translate(x: (@printable_x + Al2040::WIDTH*3.5), y: (@printable_y + Al2040::WIDTH*2.0)/2.0 + Al2040::WIDTH, z: Al2040::DEPTH)

    #Extruder (E3D V6)
    res += cube(41, 30, 63.5)
      .translate(x: @printable_x/2.0, y: ((@printable_y + Al2040::DEPTH*2.0)/2.0 - Al2040::WIDTH*1.5) * 2, z: @printable_z + Al2040::DEPTH - 10)
      .color("BLUE")
    res
  end
end
