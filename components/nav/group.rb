module Components
	class Nav
		class Group < Phlex::HTML
			def initialize(title)
				@title = title
			end

			def template(&)
				h2(class: "text-lg font-semibold pt-5") { @title }
				ul(&)
			end

			def item(...)
				render Item.new(...)
			end
		end
	end
end
