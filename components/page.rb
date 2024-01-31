module Components
	class Page < Base

		FRONT_MATTER_PATTERN = /^---\n(?<META>(\n|.)+)?\n---/

		attribute :path, String

		def initialize(path)
			super(path:)

			@document = File.read(@path)
			@data = YAML.load(
				@document.match(FRONT_MATTER_PATTERN)["META"]
			)
		end

		def view_template
			render Layout.new(title: @data["title"]) do
				article(class: "flow") do
					render Markdown.new(content)
				end

				render EditPage.new(file_path) if file_path
			end
		end

		def file_path
			@path.delete_prefix(PageBuilder.root_path)
		end

		def content
			@document.sub(FRONT_MATTER_PATTERN, "")
		end
	end
end
