import { defineConfig } from "vitepress";

export default defineConfig({
	title: "Phlex",
	description: "Ruby views",
	themeConfig: {
		editLink: {
			pattern: "https://github.com/phlex-ruby/phlex.fun/edit/main/:path",
		},

		nav: [
			{ text: "Home", link: "/" },
			{ text: "Handbook", link: "/handbook" },
			{ text: "Reference", link: "/reference" },
		],

		sidebar: [
			{
				text: "Project",
				collapsed: false,
				items: [
					{ text: "Community", link: "/project/community" },
					{ text: "GitHub", link: "https://github.com/phlex-ruby" },
				],
			},

			{
				text: "Handbook",
				link: "/handbook/",
				collapsed: false,
				items: [
					{ text: "Intro", link: "/handbook/" },
					{ text: "Setup", link: "/handbook/setup" },
					{ text: "Your first component", link: "/handbook/first-component" },
					{ text: "Under the hood", link: "/handbook/under-the-hood" },
					{ text: "Attributes deep-dive", link: "/handbook/attributes" },
					{
						text: "Advanced components",
						link: "/handbook/advanced-components",
					},
					{ text: "Tags", link: "/handbook/tags" },
					{ text: "Layouts", link: "/handbook/layouts" },
					{ text: "Helpers", link: "/handbook/helpers" },
					{ text: "Testing", link: "/handbook/testing" },
				],
			},

			{
				text: "Guides",
				collapsed: true,
				items: [{ text: "Upgrading to v2", link: "/guides/v2-upgrade" }],
			},

			{
				text: "Reference",
				link: "/reference/",
				collapsed: true,
				items: [
					{ text: "SGML", link: "/reference/sgml" },
					{ text: "HTML", link: "/reference/html" },
					{ text: "SVG", link: "/reference/svg" },
					{ text: "Kits", link: "/reference/kits" },
					{
						text: "Testing",
						items: [
							{ text: "Capybara", link: "/reference/testing/capybara" },
							{ text: "Nokogiri", link: "/reference/testing/nokogiri" },
							{ text: "Nokolexbor", link: "/reference/testing/nokolexbor" },
						],
					},
					{
						text: "Rails",
						collapsed: false,
						items: [
							{ text: "Helpers", link: "/reference/rails/helpers" },
							{ text: "Generators", link: "/reference/rails/generators" },
							{ text: "Streaming", link: "/reference/rails/streaming" },
							{ text: "Testing", link: "/reference/rails/testing" },
						],
					},
				],
			},

			// {
			// 	text: "Compared to…",
			// 	collapsed: true,
			// 	items: [
			// 		{ text: "ViewComponent", link: "/compare/view-component" },
			// 		{ text: "ActionView & ERB", link: "/compare/action-view" },
			// 		{ text: "React", link: "/compare/react" },
			// 		{ text: "Slim", link: "/compare/slim" },
			// 		{ text: "Haml", link: "/compare/haml" },
			// 	],
			// },

			{
				text: "Technical Design",
				collapsed: true,
				items: [
					{ text: "Intro", link: "/design/intro" },
					{ text: "Caching", link: "/design/caching" },
					{ text: "Performance", link: "/design/performance" },
					{ text: "Component kits" },
					{ text: "Rails integration" },
					{ text: "Selective rendering" },
					{ text: "Deferred Render" },
				],
			},
			{
				text: "AI Prompt",
				link: "/ai",
			},
		],

		socialLinks: [
			{ icon: "github", link: "https://github.com/phlex-ruby" },
			{ icon: "discord", link: "https://discord.gg/p7C9SWS8Sa" },
		],

		footer: {
			message: "Released under the MIT License.",
			copyright:
				'Made by <a href="https://github.com/joeldrapper">Joel Drapper</a>, <a href="https://github.com/willcosgrove">Will Cosgrove</a> and dozens of other <a href="https://github.com/phlex-ruby/phlex/graphs/contributors">contributors</a>.',
		},
	},
});
