class PrinterAssembly < SolidRuby::Assembly

  # Assemblies are used to show how different parts interact on your design.

  # Skip generation of the 'output' method for this assembly.
  # (will still generate 'show')
  skip :output

  def Al2040(len)
    cube(20, 40, len)
  end

  def part(show)
    #@hardware = []
    #@bom = SolidRuby::BillOfMaterial::BillOfMaterial.new

    @extrusion_w = 20
    @extrusion_h = 40
    @rod_d = 8
    @z_pillow_l = 12
    @z_pulley_h = 16

    #printable area
    @printable_x = 500
    @printable_y = 500
    @printable_z = 500 + 12 #size increased to use 600mm rods

    #Extruder carriage size (determines how much we need to add to printable_* to achieve it)
    @ex_carriage_x = 40
    @ex_carriage_y = 40
    @ex_carriage_z = 20 #from bottom of the 2040

    #Size of gantry plates
    @plate_w = 100
    @plate_t = 10 #thickness

    #internal area, i.e. the extrusions should be *outside* this box
    @in_x = @printable_x + @ex_carriage_x
    @in_y = @printable_y + @ex_carriage_y + @plate_t + @extrusion_w
    @in_z = @printable_z + @ex_carriage_z + @z_pillow_l*2.0 + @z_pulley_h

    #internal frame, i.e. the box that holds the X/Y gantries
    @if_x = @in_x + @extrusion_w * 2
    @if_y = @in_y + @extrusion_w * 2

    @out_z = @in_z + @extrusion_h * 3 #base surrounds, top surrounds, carriage
    @out_y = @in_y + @extrusion_w * 4 #surrounds * 2, carriage * 2

    # printable area
    #  res = cube(@printable_x, @printable_y, @printable_z)
    #    .translate(x: @extrusion_w*2.0, y: @extrusion_w*2.0, z: @extrusion_h)
    #    .color("LIGHTBLUE")

    #  res = cube(@in_x, @in_y, @in_z)
    #    .translate(x: @extrusion_w*2.0, y: @extrusion_w*2.0, z: @extrusion_h)
    #    .color("LIGHTBLUE")

    back_pos = @in_y + @extrusion_w * 2.0
    right_pos = @in_x + @extrusion_w * 3.0
    top_pos = @in_z + @extrusion_h * 2.0

    @out_z += 8 #round up posts to 700mm
    
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

    #Y Carriage
    y_car_z_pos = top_pos - @extrusion_h - @z_pillow_l - @z_pulley_h
    res += Al2040.new(@out_y)
      .rotate(z: 90)
      .rotate(x: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w, y: @if_y + @extrusion_w + @extrusion_h/2.0, z: y_car_z_pos)
      .debug
    res += Al2040.new(@if_x - @extrusion_w * 2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w*2.0, y: back_pos, z: y_car_z_pos)
      #.debug
    res += Al2040.new(@out_y)
      .rotate(z: 90)
      .rotate(x: -90)
      .rotate(y: 90)
      .translate(x: right_pos, y: @extrusion_w - @extrusion_h/2.0, z: y_car_z_pos)
      .debug
    res += Al2040.new(@if_x - @extrusion_w * 2.0)
      .rotate(z: 90)
      .rotate(y: 90)
      .translate(x: @extrusion_w * 2.0, y: Nema17::WIDTH, z: y_car_z_pos)
    #@bom << x
     #.debug

    #XY Motors
    motor_y_pos = 0
    res += Nema17.new
      .translate(x: @extrusion_w*2.0, y: motor_y_pos, z: y_car_z_pos)
    res += Nema17.new
      .translate(x: right_pos - Nema17::WIDTH - @extrusion_w, y: motor_y_pos, z: y_car_z_pos)

    #Z Motor
    res += Nema17.new
      .translate(x: @extrusion_w, y: back_pos + @extrusion_w - Nema17::WIDTH, z: top_pos)

    #Z Rods
    rod_h = @in_z + @extrusion_h - @z_pillow_l
    rod_z_pos = @extrusion_h + @z_pillow_l/2.0

    res += cylinder(d: @rod_d, h: rod_h)
      .translate(x: (@in_x + @extrusion_w*4.0)/2.0, y: @in_y + @extrusion_w*3.5, z: rod_z_pos)

    res += cylinder(d: @rod_d, h: rod_h)
      .translate(x: @extrusion_w/2.0, y: (@in_y + @extrusion_w*2.0)/2.0 + @extrusion_w, z: rod_z_pos)
    res += cylinder(d: @rod_d, h: rod_h)
      .translate(x: (@in_x + @extrusion_w*3.5), y: (@in_y + @extrusion_w*2.0)/2.0 + @extrusion_w, z: rod_z_pos)

    #Extruder (E3D V6)
    res += cube(41, 30, 63.5)
      .translate(x: @printable_x/2.0, y: ((@printable_y + @extrusion_h*2.0)/2.0 - @extrusion_w*1.5) * 2, z: @printable_z + @extrusion_h - 10)
      .color("BLUE")

    #Print bed (Roughly 580x630)
    res += cube(@in_x + @extrusion_w*2.0, @in_y + Nema17::WIDTH + 17, 3)
      .translate(x: @extrusion_w)
      .translate(y: 0)# @extrusion_w)
      .translate(z: 50)
      #.translate(x: @extrusion_w*2.0, y: 0)
      #.translate(x: @extrusion_w*2.0 + @ex_carriage_x, y: Nema17::WIDTH + @extrusion_w*2.0)
    res
  end
end
