module Revertable

	def R step=1
		step.times do 
			action = @revert_stack.pop
			if action
				if action[:flood_fill]
					commit = action[:sequences].first
					current_pixel = get_pixel commit[:x], commit[:y]
					F commit[:x], commit[:y], commit[:color]			
					@forward_stack << {sequences: [{x: commit[:x], y: commit[:y], color: current_pixel}], flood_fill: true}	
				else
					sequences = []	
					action[:sequences].each do |commit|
						current_pixel = get_pixel commit[:x], commit[:y]
						set_pixel commit[:x], commit[:y], commit[:color]
						sequences << {x: commit[:x], y: commit[:y], color: current_pixel}
					end	
					@forward_stack << {sequences: sequences}
				end	
			end	
		end	
	end	

	def _R step=1
		step.times do
			action = @forward_stack.pop
			if action
				if action[:flood_fill]
					commit = action[:sequences].first
					current_pixel = get_pixel commit[:x], commit[:y]
					F commit[:x], commit[:y], commit[:color]
					@revert_stack << {sequences: [{x: commit[:x], y:commit[:y], color: current_pixel}], flood_fill: true}
				else
					sequences = []
					action[:sequences].each do |commit|
						current_pixel = get_pixel commit[:x], commit[:y]
						set_pixel commit[:x], commit[:y], commit[:color]
						sequences << {x: commit[:x], y: commit[:y], color: current_pixel}
					end	
					@revert_stack << {sequences: sequences}
				end	
			end	
		end			
	end			

end	