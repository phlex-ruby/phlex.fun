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
				text: "Intro",
				link: "guide",
			},
			{
				text: "Rails",
				items: [
					{ text: "Installation", link: "guide/rails/installation" },
					{ text: "Views", link: "guide/rails/views" },
					{ text: "Components" },
					{ text: "Layouts" },
					{ text: "Helpers" },
					{ text: "Generators" },
					{ text: "Migrating to Phlex" },
				],
			},
			{
				text: "HTML",
				items: [
					{ text: "Introduction" },
					{ text: "Elements" },
					{ text: "Attributes" },
					{ text: "Comments" },
					{ text: "Helpers" },
					{ text: "Whitespace" },
				],
			},
			{
				text: "SVG",
				items: [
					{ text: "Introduction" },
					{ text: "Elements" },
					{ text: "Attributes" },
				],
			},
			{
				text: "CSV",
				items: [{ text: "Introduction" }, { text: "CSV Injection" }],
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
