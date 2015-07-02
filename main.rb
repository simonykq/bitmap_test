loop do
	printf '> '
	inputs = gets.chomp
	command, *params = inputs.split /\s/
	case command
	when 'I'
	  puts params	
	when 'C'
	  puts params	
	when 'L'
	  puts params			
	when 'V'
	  puts params			
	when 'H'
	  puts params	
	when 'F'
	  puts params			
	when 'S'	
	  puts params		
	when 'X', 'exit'
		puts "Bye bye!"
		break
	end	
end	