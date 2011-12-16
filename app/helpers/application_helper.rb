module ApplicationHelper
	def controller_active?(controller)
		if request.path_parameters[:controller] == controller
			true
		else
			false
		end
	end
end
