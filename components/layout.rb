# frozen_string_literal: true

module Components
	class Layout < Base
		attribute :title, String

		def view_template(&block)
			doctype

			html do
				head do
					meta charset: "utf-8"
					meta name: "viewport", content: "width=device-width, initial-scale=1"

					title { @title }
					link href: "/assets/application.css", rel: "stylesheet"

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
				end

				body class: "text-stone-700" do
					main(&block)
				end
			end
		end
	end
end
