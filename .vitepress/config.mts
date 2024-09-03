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
				items: [
					{ text: "Intro", link: "/guide/" },
					{ text: "Setup", link: "/guide/setup" },
					{ text: "Your first component", link: "/guide/first-component" },
					{ text: "Under the hood", link: "/guide/under-the-hood" },
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
