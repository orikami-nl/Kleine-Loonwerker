module DienstenHelper
	def action_active?(action)
		if request.path_parameters[:action] == action
			true
		else
			false
		end
	end
end
