import { defineConfig } from "vitepress";

export default defineConfig({
	title: "Phlex",
	description: "Ruby views",
	themeConfig: {
		nav: [
			{ text: "Home", link: "/" },
			{ text: "Community", link: "/community" },
			{ text: "Guide", link: "/guide" },
		],
		sidebar: [
			{
				text: "Guide",
				collapsed: false,
				items: [
					{ text: "Intro", link: "/guide/" },
					{ text: "Setup", link: "/guide/setup" },
					{ text: "Your first component", link: "/guide/first-component" },
					{ text: "Under the hood", link: "/guide/under-the-hood" },
				],
			},
			{
				text: "Reference",
				collapsed: false,
				items: [
					{ text: "SGML" },
					{ text: "HTML" },
					{ text: "SVG" },
					{ text: "Kit" },
					{
						text: "Rails",
						collapsed: false,
						items: [
							{ text: "Streaming", link: "/reference/rails/streaming" },
							{ text: "Helpers", link: "/reference/rails/helpers" },
						],
					},
				],
			},
			{
				text: "Technical Design",
				collapsed: false,
				items: [
					{ text: "Intro", link: "/design/intro" },
					{ text: "Caching", link: "/design/caching" },
					{ text: "Performance", link: "/design/performance" },
					{ text: "Component Kits" },
					{ text: "Rails Integration" },
					{ text: "Selective Rendering" },
					{ text: "Deferred Render" },
				],
			},
		],

		socialLinks: [
			{ icon: "github", link: "https://github.com/phlex-ruby" },
			{ icon: "discord", link: "https://discord.gg/p7C9SWS8Sa" },
		],
		footer: {
			message: "Released under the MIT License.",
		},
	},
});
