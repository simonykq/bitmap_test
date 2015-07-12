$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/bitmap'

loop do
	printf '> '
	inputs = gets.chomp
	command, *params = inputs.split /\s/
	case command
	when 'I'
		begin
			@bitmap = Bitmap.new *params
		rescue => e
			puts e.message
			puts e.backtrace.join("\n")
		end	
	when 'C', 'L', 'V', 'H', 'F', 'S'
		if !@bitmap
			puts "Bitmap not initialized. Please use I command to initialize bitmap first"
		else
			begin
				@bitmap.send command, *params
			rescue => e
				puts e.message
				puts e.backtrace.join("\n")
			end		
		end		
	when 'X', 'exit'
		puts "Bye bye!"
		break
	else
		puts "Unrecognized command"		
	end	
end	