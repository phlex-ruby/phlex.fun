# Phlex.fun

## Contributing

You may need to [install bun](https://bun.sh/docs/installation) to run this project. Once bun is installed:

- `cd` into the project directory
- Run `bun install`
- Run `bun run docs:dev`
- Navigate to `http://localhost:5173/` in your browser
- Now you can make changes to the markdown files and when you save, the browser will automatically reload with the changes

## Spellcheck

To perform a spellcheck across all Markdown files,

```shell
bun run cspell "**/*.md"
```

To show the issues and suggestions,

```shell
bun run cspell --no-progress --show-suggestions --show-context "**/*.md"
```
