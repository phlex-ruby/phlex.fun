# frozen_string_literal: true

module Components
	class Nav::Item < Phlex::HTML
		def initialize(text, to:)
			@text = text
			@to = to
		end

		def template
			a(href: @to.to_s) { @text }
		end

		def active? = @to == helpers[:current_page]
	end
end
