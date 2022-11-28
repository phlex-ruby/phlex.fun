# frozen_string_literal: true

module Components
	class Layout < Phlex::HTML
		register_element :style

		def initialize(title:)
			@title = title
		end

		def template(&block)
			doctype

			html do
				head do
					meta charset: "utf-8"
					meta name: "viewport", content: "width=device-width, initial-scale=1"

					# favicon
					# generated via https://realfavicongenerator.net/ on 2022-11-28
					link rel: "apple-touch-icon", sizes: "180x180", href: "/assets/favicon/apple-touch-icon.png"
					link rel: "icon", type: "image/png", sizes: "32x32", href: "/assets/favicon/favicon-32x32.png"
					link rel: "icon", type: "image/png", sizes: "16x16", href: "/assets/favicon/favicon-16x16.png"
					link rel: "manifest", href: "/assets/favicon/site.webmanifest"
					link rel: "mask-icon", href: "/assets/favicon/safari-pinned-tab.svg", color: "#c90058"
					link rel: "shortcut icon", href: "/assets/favicon/favicon.ico"
					meta name: "msapplication-TileColor", content: "#00aba9"
					meta name: "msapplication-config", content: "/assets/favicon/browserconfig.xml"
					meta name: "theme-color", content: "#ffffff"

					title { @title }
					link href: "/application.css", rel: "stylesheet"
					style { unsafe_raw Rouge::Theme.find("github").render(scope: ".highlight") }
				end

				body class: "text-stone-700" do
					div class: "flex flex-col" do
						header class: "border-b py-4 px-4 lg:px-10 flex justify-between items-center sticky top-0 left-0 bg-white z-50" do
							div class: "flex flex-row items-center gap-2" do
								label for: "nav-toggle", class: "cursor-pointer lg:hidden" do
									unsafe_raw '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-8 h-8"> <path fill-rule="evenodd" d="M3 6.75A.75.75 0 013.75 6h16.5a.75.75 0 010 1.5H3.75A.75.75 0 013 6.75zM3 12a.75.75 0 01.75-.75h16.5a.75.75 0 010 1.5H3.75A.75.75 0 013 12zm0 5.25a.75.75 0 01.75-.75h16.5a.75.75 0 010 1.5H3.75a.75.75 0 01-.75-.75z" clip-rule="evenodd" /> </svg>'
								end

								a(href: "/", class: "block") { img src: "/assets/logo.png", width: "100" }
							end

							nav(class: "text-stone-500 font-medium") do
								ul(class: "flex space-x-8") do
									li { a(href: "https://github.com/sponsors/joeldrapper") { "💖️ Sponsor" } }
									li { a(href: "https://github.com/joeldrapper/phlex") { "GitHub" } }
								end
							end
						end

						div do
							div class: "flex flex-row" do
								render Nav.new

								main class: "w-full lg:w-3/4 px-6 lg:px-20 py-5 border-0 lg:border-l-2 border-gray-100" do
									div(class: "max-w-full lg:max-w-prose prose", &block)
								end
							end

							footer class: "border-t p-20 flex justify-center text-stone-500 text-lg font-medium" do
								a(href: "https://github.com/sponsors/joeldrapper") { "Sponsor this project 💖" }
							end
						end
					end
				end
			end
		end
	end
end
