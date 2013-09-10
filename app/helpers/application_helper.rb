module ApplicationHelper

	# Returns a title on a per-page basis
	def full_title(page_title)
		base_title = "WineCards"
		if page_title.empty?
			base_title
		else
			"#{base_title} - #{page_title}"
		end
	end

	def wine_name
		if @wine.name.empty?
			"#{@wine.producer} - #{@wine.price}"
		else
			"#{@wine.producer}, #{@wine.name} - $#{@wine.price}"
		end
	end
end
