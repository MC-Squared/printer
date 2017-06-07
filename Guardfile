guard :shell do
  watch(/printer.rb/) { system('ruby printer.rb') }
  watch(%r{^lib/.+/.+\.rb}) { system('ruby printer.rb') }
end
