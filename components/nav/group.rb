module Components
	class Nav
		class Group < Phlex::HTML
			def initialize(title)
				@title = title
			end

			def template(&)
				h3 { @title }
				yield_content(&)
			end

			def item(...)
				render Item.new(...)
			end
		end
	end
end
