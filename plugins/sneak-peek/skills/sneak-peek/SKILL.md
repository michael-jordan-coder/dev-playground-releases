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

Sneak Peek runs the user's real application from a working copy of its own, outside their
repo, and shows its screens on a canvas as **Code Layers**: live frames of the app's routes,
each at the size the user gives it, reloaded on each save. The user's folder never changes.
Every project is one: a copy of the user's folder, or, for a blank canvas, a small Vite +
React starter app. Options are routes and design options of that app, never variants in a
prototype file: never write `Current`, `Mock`, an `index.tsx` of exported variants, or any
file in the project folder beside the working copy except `stage.json`.

Every command is `${CLAUDE_PLUGIN_ROOT}/bin/playground <command>`, written
`playground` below; always run the full path. When the `sneak-peek` MCP tools are
available, use them for every action instead of the command, and above all for the ones
that write (`add`, `backend`): they are the same actions, and an agent that runs Bash in a
sandbox cannot write Sneak Peek's data folder from the command, while the tools can. When
your tools are deferred, load them first. Use the command only when the tools are not
available, or when a tool call refuses and says to reconnect them.

## Speed is the product

The user is watching the canvas. What costs time is round trips, not code: each tool call
waits on a long context. So:

- **Batch.** Independent calls go in one message: reads in parallel, and chained commands
  joined with `&&` in one Bash call.
- **Read little.** Before the first change, read the file of the screen you are changing and
  what it imports that you need, in one parallel batch. No `ls` tours, no `cat` of folders.
- **Save whole.** The canvas shows each save the moment it lands: never leave a file half
  written between two edits.
- **First change on screen within a minute** of the request.

## How a request goes

1. **Mark the work at once.** One line of plan in chat ("Three takes on the pricing card,
   side by side"), then, before reading anything:

   ```sh
   playground working <project> Application --note "reading your pricing page"
   ```

   It opens the app on the project, starts the application when it is not running, and
   prints the working copy to edit, how the application runs, whether it runs now (with its
   last output when it is starting or failed) and its Code Layers. When the user names no
   project, run `playground list` first: its `Current project` line is the canvas open in
   Sneak Peek, or the project copied from the folder you run in. When the project is not
   there, `add` it (`projects.md`, Bringing a project in).
2. **When `working` says it runs nothing yet,** write its run recipe first (`projects.md`,
   Running an application), then go on. When it says the runtime failed, read the output it
   printed and fix the cause in the copy or the recipe: a missing package, a missing
   environment value, a port flag. Never replace the app with a screen of your own.
3. **Read, in one parallel batch,** what the change needs, from the working copy.
4. **Change the application's own files in the working copy.** Every Code Layer showing that
   route reloads on the save.
5. **Options side by side.** Takes on a screen or component are prototype routes of the app,
   each shown as a Code Layer of its own (Prototype routes, below): the user compares them on
   the canvas, all live. A direction that changes shared code across the app is a design
   option instead: `workspace <project> new-option {"label":"Compact nav"}` returns its own
   copy and project name; edit that copy, and show it with a layer whose `runtimeProject` is
   the option. Each option is a whole copy with its own install and server, so make one only
   when the take cannot live as a route.
6. **Check once, at the end,** in one message of parallel calls: a
   `playground shot <project> Application --layer <id>` per layer you changed. Read the PNGs
   in one parallel batch. Fix only what is broken or clearly off.
7. **Hand back:** `playground done` and `playground show <project> Application --layer <id>`
   in one message, then in chat one line per layer (its name and the idea it tests), which
   one you would start from and why. When `working` printed a question to ask once, it is
   the last line, in one sentence; on their reply, record it with `playground offer` as that
   line says.

While you work, chat only what changes on screen, a short line per take ("Stacked is up:
the price sits above the features"). No code or commands in chat. Every mark in the app
stands for real work: no `working` or `show` for effect. If a command says Sneak Peek is
open from another copy, say so in a line and wait.

### Prototype routes and fixture data

A screen that needs a login, data from a server, or a backend that is not running here, and
every take on a screen, is a **prototype route**: a page of the app's own router, in the
working copy, that renders the real screen or component with fixture data and the providers
the app's root wraps it in (theme, i18n, query client, store, a signed-in user). Put them
under one path, `/sneak-peek/<screen>/<take>`, in the router's own way:

- Next.js app router: `app/sneak-peek/<screen>/<take>/page.tsx` (a route group or a
  `(sneak-peek)` folder when the root layout needs a session it cannot have).
- Vite without a router: a page `sneak-peek/<screen>/<take>/index.html` with a module script
  that mounts the screen; Vite serves it as it is.
- React Router, TanStack Router and the like: a route added where the app declares them.
- Any other stack: a page or route as that framework makes one.

Fixture data lives beside the route (`fixtures.ts`), typed by the app's own types, realistic
in length and count. Never stub the real component: render it, and pass it data. When the
app's auth guard redirects, the prototype route sits outside the guarded group, or wraps the
screen in the auth provider with a fixture user. Then show it as a layer of its own:

```sh
playground workspace <project> edit-layer '{"action":"upsert","layer":{"id":"pricing-stacked","name":"Pricing · Stacked","route":"/sneak-peek/pricing/stacked"}}'
```

A new layer without `x`, `y`, `width` and `height` takes a desktop size to the right of the
others; give a width of 390 and height of 844 for a phone. When the user keeps one take,
port it into the real screen in the main copy, then remove the other routes and their
layers (`edit-layer` `{"action":"remove","id":"..."}`).

### Workspace actions

Use the `workspace` MCP tool or `playground workspace <project> <action> [JSON]` for
`files`, `file` (`{"path":"src/file.tsx"}`), `changes`, `history`, `checkpoint`, `restore`
(`{"id":"checkpoint-id"}`), `layers`, `edit-layer`, `new-option`, `apply-option`, `delete-option`
(`{"option":"option-name"}`), and `runtime`
(`{"action":"run"}`, `stop`, or `restart`). The selected report names the Code Layer,
route and working root; edits belong to that root. Ordinary duplicated frames share code.
History excludes known secrets, generated files, symlinks and oversized source; it is not
a backup of credentials. Restore, applying an option and deleting one need an explicit user request
after reviewing changes; restore and apply retain a recovery checkpoint. Applying never writes the original repo.

A page that navigates (a link, a form, `location.href`) moves its layer's frame with it; the
user's navigation is normal. When a frame is blank, stuck loading or on the wrong page,
`playground reload <project> Application` sends the frames the app shows back to their
routes and says for each where it was and whether it rendered.

## The first conversation

When the message asks you to welcome the user to Sneak Peek and bring in their first project,
write the welcome first, then read `onboarding.md` beside this file and follow it instead of
the steps above.

## A project just added

When the request brought a project in, read `first-frame.md` beside this file and follow it
instead of the steps above: their own app running on the canvas, before any question.

## A blank canvas

A project listed as a `blank canvas` runs Sneak Peek's starter app: Vite and React, with
`src/App.jsx` as its one screen. Follow the steps above and build the user's idea in it from
scratch, in plain React and CSS, adding packages with npm when they help. Never `add` its
folder. When they want their own app instead, they press Connect a Project in the app, or
you run `playground add <blank-project> <folder>`, which replaces the starter with a copy.

## Legacy prototype projects

`list` names projects registered before working copies as `legacy prototype project`. Do
not write variants in them. When the user wants to work on one, bring its repo in with
`playground reimport <project>`: a new working copy, while the legacy project stays as it
is. Then work in the new one.

## Other requests

Read the file beside this one only when the request calls for it:

- `selection-and-notes.md`: the user says "this", "the selected one", or refers to notes
  they left in the app.
- `projects.md`: bringing a project in, running an application Sneak Peek cannot run by
  itself, the offer `working` may ask you to put, the folder layout, opening the app.
