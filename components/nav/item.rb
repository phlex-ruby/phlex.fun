# frozen_string_literal: true

module Components
	class Nav::Item < Phlex::HTML
		def initialize(text, to:)
			@text = text
			@to = to
		end

		def template
			li do
				a(**link_classes, href: @to.to_s) { @text }
			end
		end

		def link_classes = classes("pb-1 block font-medium text-stone-500",
			active?: "text-red-600 font-bold"
		)

		def active? = @to == helpers[:current_page]
	end
end
