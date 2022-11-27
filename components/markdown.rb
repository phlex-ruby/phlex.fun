# frozen_string_literal: true

module Components
	class Markdown < Phlex::Markdown
		def h1 = super(class: "text-3xl font-semibold my-5")
		def h2 = super(class: "text-2xl font-semibold mt-10 mb-5")

		def a(**attributes)
			super(
				class: "font-bold text-red-600 underline underline-offset-4",
				**attributes
			)
		end

		def code = super(class: "bg-stone-50 inline-block font-medium rounded border px-1 -mt-1")

		def code_block(code, language)
			render CodeBlock.new(code.gsub(/(?:^|\G) {4}/m, "	"), syntax: language)
		end
	end
end
