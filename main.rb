require 'lib/bitmap'

loop do
	printf '> '
	inputs = gets.chomp
	command, *params = inputs.split /\s/
	case command
	when 'I'
		begin
			m_n = params.take(2).map{|n| n.to_i }
	        params = m_n + params.drop(2)
			@bitmap = Bitmap.new *params
			puts "Bitmap initialized"
		rescue Bitmap::InvalidInputError => e
			puts e.message
			puts "Please type a valid input again"
		rescue => e
		    puts e.message	
			puts e.backtrace.join("\n")
		end	
	when 'C', 'L', 'V', 'H', 'F', 'S'
		if !@bitmap
			puts "Bitmap not initialized. Please use I command to initialize bitmap first"
		else
			begin
				unless params.empty?
					last = params.pop
					params = params.map{|n| n.to_i }
					params << last
				end
				@bitmap.send command, *params
			rescue Bitmap::InvalidInputError => e
				puts e.message
				puts "Please type a valid input again"
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