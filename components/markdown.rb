# frozen_string_literal: true

module Components
	class Markdown < Phlex::Markdown
		def code_block(code, language)
			if language == "phlex"
				instance_eval(code)
			else
				render CodeBlock.new(code, syntax: language)
			end
		end

		def example(&)
			render(Example.new, &)
		end
	end
end
