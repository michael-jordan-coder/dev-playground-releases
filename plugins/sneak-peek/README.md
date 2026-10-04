# Sneak Peek for Claude Code

Prototype UI from your real repo in a live canvas. Ask Claude for a few takes on a screen or a
component, and it writes them as prototypes that import your project's own components, tokens
and styles. The free Sneak Peek Mac app shows every take on phone, tablet and desktop frames the
moment it is saved, with sliders to tune each one by hand. Nothing is written into your repo.

## Requirements

- macOS, with the Sneak Peek app installed and opened once:
  [download it](https://github.com/michael-jordan-coder/dev-playground-releases/releases/latest/download/Sneak-Peek.dmg)
  or see [sneak-peek-bay.vercel.app](https://sneak-peek-bay.vercel.app).
- A React web project (Next.js or Vite).

## Try it

Open Claude Code in your project and ask, for example:

- "Add this project to the playground and show me its main screen there."
- "Show me three takes on the pricing card in Sneak Peek."
- "Make the one I selected denser."

## What the plugin contains

- A skill, `sneak-peek`: how Claude builds prototypes quickly, gives them controls, checks
  them and hands them back.
- An MCP server, `sneak-peek`, with the playground's actions: `working`, `show`, `done`,
  `shot`, `open`, `selected`, `notes`, `note_done`, `controls`, `list`, `snapshot` and `canvas`.
- A `UserPromptSubmit` hook that hands Claude the notes you pin on elements in the app, with
  your next message.

## What it runs, and what it sends

The plugin holds no playground code of its own. Its three shell scripts in `bin/` find the
Sneak Peek app's playground, which the app installs in
`~/Library/Application Support/Sneak Peek/.runtime/<version>/`, and run it with the Node.js the
app ships. So the MCP server, the hook and the `playground` command always match the app you
have. Without the app, the command says where to download it and the hook does nothing.

- The MCP server and the hook talk only to the Sneak Peek app on your Mac, at `127.0.0.1`.
- Prototypes are written to the app's data folder, outside your repo. The plugin never edits
  your project's files.
- Screenshots of prototypes are taken locally, by the app or by the Chrome on your Mac.
- The plugin itself sends nothing over the network. The Sneak Peek app can send a usage log
  (launches, projects added with their stack, prototypes created, renders and errors), with
  project and prototype names replaced and file paths removed, and never your code. You can see
  what is shared and turn it off in the app's Settings, under Account. The
  [privacy page](https://sneak-peek-bay.vercel.app/privacy) has the details.

## License

MIT, for this plugin's files. The Sneak Peek app has its own terms.
