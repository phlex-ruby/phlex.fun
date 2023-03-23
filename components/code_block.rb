# frozen_string_literal: true

module Components
	class CodeBlock < Phlex::HTML
		FORMATTER = Rouge::Formatters::HTML.new

		def initialize(code, syntax:)
			@code = code.chomp
			@syntax = syntax.length > 0 ? syntax : nil
		end

		def template
			pre class: "highlight", data: do
				if @syntax
					unsafe_raw FORMATTER.format(
						lexer.lex(@code)
					)
				else
					@code
				end
			end
		end

		private

		def data = { language: @syntax, lines: }
		def lines = @code.scan(/\n/).count + 1
		def lexer = Rouge::Lexer.find(@syntax)
	end
end
