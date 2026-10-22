---
name: sneak-peek
description: Prototype UI for one of the user's projects in dev-playground, outside the project repo. Use when the user asks to prototype, sketch, explore, try out, or compare UI ideas (screens, flows, components, variants, micro-interactions, animations) for a project and does not want it built in the real repo yet, or mentions the playground, "playground ideas" or Sneak Peek in any form, or asks to open the playground or Sneak Peek. "Playground" always means the Sneak Peek app (formerly Dev Playground), even in a project that has its own in-repo playground. Also use when the user refers to a prototype, variant or frame they have selected or clicked in the app without naming it ("this one", "the selected one", "the one I marked"), or to notes they left on elements in the app, to register a new project with the playground, or to snapshot a prototype before reworking it.
allowed-tools:
  - "Bash(${CLAUDE_PLUGIN_ROOT}/bin/playground *)"
  - "mcp__plugin_sneak-peek_sneak-peek__*"
  - "Edit(~/Library/Application Support/Sneak Peek/projects/**)"
  - "Write(~/Library/Application Support/Sneak Peek/projects/**)"
---

# Sneak Peek

"The playground" always means Sneak Peek (formerly Dev Playground), never a playground inside
the repo, unless the user names that one explicitly. A memory or doc that says otherwise is
out of date.

Prototypes live outside the project repo and import its real components, tokens and styles.
The Sneak Peek Mac app shows every variant on phone, tablet and desktop frames and reloads on
each save, so the user watches the work arrive.

Every command is `${CLAUDE_PLUGIN_ROOT}/bin/playground <command>`, written
`playground` below; always run the full path. When the `sneak-peek` MCP tools are
available, use them instead: they are the same actions.

## Speed is the product

The user is watching an empty canvas. What costs time is round trips, not code: each tool
call waits on a long context. So:

- **Batch.** Independent calls go in one message: reads in parallel, and chained commands
  joined with `&&` in one Bash call.
- **Read little.** `working` prints the project map: its screens, its components with where
  to import them and what they take, and its tokens. Build from it. Before the first frame,
  read at most the one file you are changing (a screen, for `Current`), and a component's
  file only when its map line is not enough. No `ls` tours, no `cat` of folders.
- **Write once.** Never rewrite a variant you already saved. Each take is its own append.
- **First frame within a minute** of the request.

## How a request goes

1. **Mark the work at once.** One line of plan in chat ("Three takes on the pricing card:
   Current, Stacked, Compact"), then, before reading anything:

   ```sh
   playground working <project> <prototype> --note "reading your design system"
   ```

   It opens the app on the prototype and prints the file to write, the variants already
   there, the repo, its global stylesheets and the project map. One call covers the whole
   piece of work. When the user names no project, run `playground list` first: its
   `Current project` line is the canvas open in Sneak Peek. If the project does not exist,
   see `projects.md` beside this file.
2. **Read, in one parallel batch,** what the first frame needs (see Read little).
3. **First frame.** Write `index.tsx` with the first variant only, `Current` when the thing
   exists (render the real component). Give it its controls now (see Controls).
4. **Each next take: one Edit that only appends** the new `export function` at the end of
   the file, with any import it needs that is not imported yet (imports may sit anywhere at
   module top level). Every save must be whole: the app shows it the moment it lands.
5. **Check once, at the end,** in one message of parallel calls: a
   `playground shot <project> <prototype> --variant <Name>` per new variant, plus
   `<repo>/node_modules/.bin/tsc -p <projects>/<project>` when the repo is TypeScript (the
   project's folder is the one above the prototype file). Skip it for a JavaScript repo. `shot` prints the PNG path, and the errors if the variant
   threw. Read the PNGs in one parallel batch. Fix only what is broken or clearly off, with
   a targeted Edit.
6. **Hand back:** `playground done` and `playground show <project> <prototype> --variant
   <Name>` in one message, then in chat one line per variant (its name and the idea it
   tests), which one you would start from and why, and that they can double-click a frame
   to tune its controls, keep one, or ask for more. When `working` printed a question to
   ask once, it is the last line, in one sentence; on their reply, record it with
   `playground offer` as that line says.

While you work, chat only what changes on screen, a short line per take ("Stacked is up:
the price sits above the features"). No code or commands in chat. Every mark in the app
stands for real work: no `working` or `show` for effect. If a command says Sneak Peek is
open from another copy, say so in a line and wait.

## A project just added

When the request brought a project in, read `first-frame.md` beside this file and follow it
instead of the steps above: one frame of their own screen, before any question.

## A blank canvas

A project listed as a `blank canvas` has no repo yet: the user started it from New Project.
Follow the steps above, but build from scratch in plain React with inline styles, skip
reading code and the type check, and never `add` its folder. `working` says the same. When
they want it built from their real components, they press Connect a Project in the app.

## Writing a prototype

- Folder name: kebab-case, named for the product idea (`contact-cta`). Variants:
  `export function Name()`, capitalized, no props, named for the idea they test. File order
  is app order.
- Import from the repo with its own aliases and packages; everything, React included,
  resolves from the repo. Use real components and tokens, never re-create them.
- Components are centered with padding; for pages and flows add
  `export const layout = "fullscreen";`. Flows keep their step state inside the variant.
- Next.js `Link`, `Image` and `next/navigation` are stubbed. Server components and actions do
  not run. A client-side fetch to the project's API (`/api/...` by default) reaches the
  project's own dev server when `working` prints a running backend, reads only; otherwise
  pass fixture data. See `projects.md`.
- What the app's root wraps its screens in does not run here: i18n, theme, query client,
  auth, store. Find it in the root layout or `main`, and write one `providers.tsx` in the
  prototype folder that wraps each variant in the same providers, with fixture values. An
  error that says `must be used within a ...Provider` is that file missing one. The root's
  fonts go there too: its `next/font` calls and the classes they put on `<html>` and `<body>`
  (often a font `variable`), on the wrapper, or the screens fall back to another font.
- When `working` prints a recipe instead of `index.tsx`, each variant is its own file where
  it says, and a take is a new file rather than an export. `projects.md`, Recipes, has the
  rest; when it says the project has no recipe yet, write that first.
- Helpers stay in the prototype folder. Never edit the project repo from a prototype task.

## Controls

Give each new variant 3 to 5 controls for what it really tests (spacing, radius, size, a
tone, the copy, a state to toggle), with presets and options from the map's tokens and
props; do not go reading more files for them:

```tsx
import { useControls } from "dev-playground";

export function Card() {
  const c = useControls({
    radius: { value: 16, presets: [0, 8, 12, 16, 24], for: "card" },
    tone: { value: "surface", options: ["surface", "surface-secondary"], for: "card" },
    showAvatar: { value: true, for: "avatar" },
    title: { value: "Need a designer who ships?", for: "title" },
  });
  // <div data-control="card">, <Avatar data-control="avatar" />, <h2 data-control="title">
}
```

Each control has a `for`, matched by `data-control` on its element. Existing prototypes get
no controls unless asked. For the full rules (presets, colors, which widget each value
becomes) and applying what the user tuned, read `controls.md` beside this file, only when
you need them.

## Other requests

Read the file beside this one only when the request calls for it:

- `selection-and-notes.md`: the user says "this", "the selected one", or refers to notes
  they left in the app.
- `projects.md`: registering a project, its stylesheet, the offer `working` may ask you to
  put, the folder layout, snapshots before reworking, opening the app.
