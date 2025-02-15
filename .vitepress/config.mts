import { defineConfig } from "vitepress";

export default defineConfig({
	title: "Phlex",
	description: "Ruby views",
	themeConfig: {
		search: {
			provider: "local",
		},

		editLink: {
			pattern: "https://github.com/phlex-ruby/phlex.fun/edit/main/:path",
		},

		nav: [
			{ text: "Home", link: "/" },
			{ text: "Docs", link: "/introduction" },
			{ text: "Support", link: "https://github.com/orgs/phlex-ruby/discussions" },
			{ text: "v1 Docs", link: "https://v1.phlex.fun" },
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
				text: "Introduction",
				collapsed: false,
				items: [
					{ text: "Overview", link: "/introduction/" },
					{ text: "Getting started", link: "/introduction/getting-started" },
				],
			},

			{
				text: "Components",
				collapsed: false,
				items: [
					{ text: "Rendering", link: "/components/rendering" },
					{ text: "Yielding", link: "/components/yielding" },
					{ text: "Kits", link: "/components/kits" },
					{ text: "Caching", link: "/components/caching" },
					{ text: "Fragments", link: "/components/fragments" },
					{ text: "Streaming", link: "/components/streaming" },
					{ text: "Snippets", link: "/components/snippets" },
					{ text: "Testing", link: "/components/testing" },
				],
			},

			{
				text: "HTML & SVG",
				collapsed: false,
				items: [
					{ text: "HTML elements", link: "/sgml/html-elements" },
					{ text: "SVG elements", link: "/sgml/svg-elements" },
					{ text: "Attributes", link: "/sgml/attributes" },
					{ text: "Text", link: "/sgml/text" },
					{ text: "Whitespace", link: "/sgml/whitespace" },
					{ text: "Comments", link: "/sgml/comments" },
					{ text: "Raw output", link: "/sgml/raw" },
					{ text: "Doctype (HTML only)", link: "/sgml/doctype" },
				],
			},

			{
				text: "Rails",
				collapsed: false,
				items: [
					{ text: "Adopting Phlex", link: "/rails/adopting-phlex" },
					{ text: "Helpers", link: "/rails/helpers" },
					{ text: "Views", link: "/rails/views" },
					{ text: "Layouts", link: "/rails/layouts" },
				],
			},

			{
				text: "Miscellaneous",
				collapsed: false,
				items: [
					{ text: "Literal Properties", link: "/miscellaneous/literal-properties" },
					{ text: "Under the hood", link: "/miscellaneous/under-the-hood" },
					{ text: "Upgrading to v2", link: "/miscellaneous/v2-upgrade" },
				],
			},

			{
				text: "Technical Design",
				collapsed: true,
				items: [
					{ text: "Caching", link: "/design/caching" },
					// { text: "Performance" },
					// { text: "Kits" },
					// { text: "Rails Integration" },
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
