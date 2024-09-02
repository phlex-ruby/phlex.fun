import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
	title: "Phlex",
	description: "Ruby views",
	themeConfig: {
		// https://vitepress.dev/reference/default-theme-config
		nav: [
			{ text: "Home", link: "/" },
			{ text: "Guide", link: "/guide/rails" },
		],

		sidebar: [
			{
				text: "Guide",
				items: [{ text: "Rails", link: "/guide/rails" }],
			},
		],

		socialLinks: [{ icon: "github", link: "https://github.com/phlex-ruby" }],
	},
});
