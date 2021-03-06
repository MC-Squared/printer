#!/usr/bin/env ruby
require 'solidruby'
require 'require_all'
include SolidRuby

require_all 'lib/**/*.rb'

# To run this project and refresh any changes to the code, run the following command
# in a terminal (make sure you are in the same directory as this file):
#  observr #{name}.observr
#
# This will generate #{name}.scad which you can open in OpenSCAD.
# In OpenSCAD make sure that you have the menu item
# Design -> Automatic Reload and Compile
# activated.

# Scans every file in lib/**/*.rb for classes and saves them in the output/ directory
save!

BillOfMaterial.bom.save('output/bom.txt')
