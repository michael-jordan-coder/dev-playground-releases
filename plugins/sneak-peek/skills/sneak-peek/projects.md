# Projects, running them, layout, opening

## Bringing a project in

`playground list` prints the projects folder on its first line, then what exists. To bring a
folder in (or the `add` tool, with the same arguments):

```sh
playground add <name> <folder>
```

It copies the folder's current files, uncommitted work and local configuration included, into
a working copy of its own in Sneak Peek's data folder, leaving out what installs and builds
make again (`node_modules`, `.git`, build output). The source folder never changes: you edit
the copy, and the canvas runs it. A folder already brought in answers with its project. Given
the name of a blank canvas, `add` replaces that canvas's starter app with the copy, as
Connect a Project does. A copy refuses links that point outside the folder and local package
dependencies from outside it; bring in the folder that holds them instead, such as a
monorepo's root.

## Running an application

Sneak Peek runs a Next.js or Vite application by its own `dev` script, after installing its
dependencies in the copy with its own package manager. Any other stack, and an app that
needs another command, runs by a **run recipe** you write once: `stage.json` beside
`project.json` (`working` prints its path). Later sessions and the project's design options
run it as it is.

```json
{
  "kind": "application",
  "install": ["bundle", "install"],
  "start": ["bin/rails", "server", "-b", "127.0.0.1", "-p", "{port}"],
  "ready": "/"
}
```

- `start`: the command that serves the application, as a list of words, run in the working
  copy. `{port}` is the port it must listen on, also given as `PORT`; `{repo}` is the copy's
  path. One server, on 127.0.0.1: Sneak Peek puts its proxy in front of it.
- `install` (optional): installs the dependencies in the copy. It runs before the first start
  and again whenever a manifest or lockfile changes.
- `ready` (optional): a path that answers below 400 once the app is up. Default `/`.

The words are not a shell line. A command that needs an environment variable or `&&` is
`["sh", "-c", "BROWSER=none PORT={port} npx react-scripts start"]`. Some starts:

- Astro: `["npx", "astro", "dev", "--host", "127.0.0.1", "--port", "{port}"]`
- A package of a monorepo: `["pnpm", "--filter", "web", "dev", "--port", "{port}"]`, with
  `install` `["pnpm", "install"]`
- Django: `["python3", "manage.py", "runserver", "127.0.0.1:{port}"]`
- A site of plain files: `["python3", "-m", "http.server", "{port}", "--bind", "127.0.0.1"]`

Saving `stage.json` restarts the server. A recipe is done only when a shot shows the app:
`playground shot <project> Application`, and when it fails, the output it prints (or the
`workspace` action `runtime`) says why. Fix the recipe or the copy until the shot shows the
app with no errors. The recipe runs the application itself: never a server of your own that
serves a page standing in for it.

## Offering Sneak Peek on your own

Once a project has been worked on before, `working` may print one question to put in your
hand-back: whether to add a few lines to your own instructions file in your home folder, so
that in later sessions, in every project, you offer Sneak Peek when how some UI should look
is still open. Ask it once, in one sentence, and record the reply (or the `offer` tool):

```sh
playground offer yes    # writes the lines to your instructions file
playground offer no     # stops the question, and takes out lines an earlier yes wrote
```

Either answer is kept, so the question does not come back. Without one, `working` asks again
at most once a day.

## Layout

```
<projects>/<project>/
  project.json          the working copy's folder, and the folder it was copied from
  stage.json            how it runs: {"kind": "application"}, or your run recipe
  .workspace-<id>/      the working copy: the application you edit
  .layers.json          its Code Layers: id, name, route, place and size on the canvas
  .history/             checkpoints of the copy, for the workspace actions
```

A design option is a project of its own beside it, `option-<id>/`, with its own copy.

## Opening

"Open the playground" or "open Sneak Peek" means the app, never a dev server and a browser
tab: `playground open`. `working` and `show` open it too. Never `open -a "Sneak Peek"`: with
a development build beside the installed app, that starts a second copy.

## Shipping one

The copy is not the user's repo, and nothing in Sneak Peek writes to it. When the user wants a
take in their repo, read what changed (the `workspace` action `changes`) and port it there as
a normal task, following the repo's conventions. Leave the prototype routes and fixtures out:
they exist for the canvas.
