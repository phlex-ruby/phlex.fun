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
					{
						text: "Phlex",
						collapsed: false,
						items: [
							{ text: "SGML" },
							{ text: "HTML" },
							{ text: "SVG" },
							{ text: "Kit" },
						],
					},
					{
						text: "Rails",
						collapsed: false,
						items: [{ text: "Streaming" }, { text: "Helpers" }],
					},
				],
			},
			{
				text: "Technical Design",
				collapsed: false,
				items: [{ text: "Caching" }],
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
