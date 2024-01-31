module Components
	class EditPage < Base

		def initialize(file_path, branch: "main", repo: "joeldrapper/phlex.fun")
			super(
				file_path:,
				branch:,
				repo:
			)
		end

		attribute :file_path, String
		attribute :branch, String
		attribute :repo, String

		def view_template
			p(class: "mt-12") do
				a(href: github_edit_file_url, target: :_blank, class: "text-stone-500 font-medium") do
					span { "📝 Edit this page on GitHub" }
				end
			end
		end

		def github_edit_file_url
			File.join(github_repo_url, "edit", @branch, @file_path)
		end

		def github_repo_url
			File.join("https://github.com", @repo)
		end
	end
end
