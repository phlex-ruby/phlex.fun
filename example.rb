require "phlex"
require "sinatra"

get("/") { IndexView.call }

class IndexView < Phlex::HTML
	def view_template
		h1 { "👋 Hello World!" }
	end
end
