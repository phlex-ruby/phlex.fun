# frozen_string_literal: true
require "phlex/testing/view_helper"

module Components
	class Markdown < Phlex::Markdown
		def h1(**, &)
			content = capture(&)
			super(id: content.downcase.gsub(/\s+/, "-"), &)
		end

		def code_block(code, language)
			case language
			when "phlex"
				eval_code(code)
				render CodeBlock.new(code, syntax: "ruby")
			when "phlexecute"
				output = eval_code(code)
				pretty = HtmlBeautifier.beautify(output)
				render CodeBlock.new(pretty, syntax: "html")
			else
				render CodeBlock.new(code, syntax: language)
			end
		end

		private

		def eval_code(code)
			eval_context.module_eval(code)
		end

		def eval_context
			@eval_context ||= Module.new do
				extend Phlex::Testing::ViewHelper
			end
		end
	end
end
