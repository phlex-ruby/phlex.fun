module Components
	class Page < Phlex::HTML
		FRONT_MATTER_PATTERN = /^---\n(?<META>(\n|.)+)?\n---/

		def initialize(path)
			@path = path
			@document = File.read(@path)
			@data = YAML.load(
				@document.match(FRONT_MATTER_PATTERN)["META"]
			)
		end

		def template
			render Layout.new(title: @data["title"]) do
				render Markdown.new(content)
				render EditPage.new(file_path) if file_path
			end
		end

		def file_path = @path.delete_prefix(PageBuilder.root_path)

		def content = @document.sub(FRONT_MATTER_PATTERN, "")
	end
end
