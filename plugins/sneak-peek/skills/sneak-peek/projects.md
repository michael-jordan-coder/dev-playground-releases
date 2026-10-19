# Projects, layout, snapshots, opening

## Registering a project

`playground list` prints the projects folder on its first line, then what exists. To add a
project (or the `add` tool, with the same arguments):

```sh
playground add <name> <path-to-repo> [--css <repo-relative stylesheet>] [--backend <url>]
```

It takes the stylesheets the app's entry (root layout, `_app` or `main`) imports, else one
that imports Tailwind, else the source's few plain stylesheets. Check its output. If the guess
is wrong or missing, pass `--css`, or set `css` in `project.json`.
`themeAttribute` defaults to `data-theme`; set it to `class` for projects that toggle a
`dark` class. A repo with a `package.json` renders through the built-in stage, made for React
web projects (Next, Vite). Any other repo, a site of plain HTML, CSS and JS say, gets a
recipe you write (below); `add` says so, and `working` repeats it until the recipe exists.

A Vite repo's own `vite.config` is read when its stage starts: its transform plugins (macros
such as Spectrum's `style`, SVGR and the like), aliases, defines and `optimizeDeps.exclude`
apply to the stage, so components that need them render as they are. Its server, proxy and
API middleware do not run here; for real data, set a backend (below). A config that fails to
load leaves the stage on its own plugins, and the supervisor's log says why.

## Recipes

A recipe is how a project's stage serves its variants: `stage.json` in the project folder,
plus whatever it starts. Sneak Peek runs it, puts its own bridge into every page (errors,
the settled mark, reload on save, the usage log) and shows each variant as a frame, so a
recipe knows nothing about the canvas. Write it once; later sessions run it as it is.

```json
{
  "kind": "static",
  "start": ["node", "stage/serve.mjs", "--port", "{port}"],
  "variant": "/{prototype}/{variant}.html",
  "entry": "{prototype}/{variant}.html",
  "ready": "/"
}
```

- `start`: a command, as a list of words, run from the project folder; `{port}` and `{repo}`
  are filled in. It serves pages on that port. Never `builtin:` unless the repo is React.
- `variant`: the path on that server that shows one variant; `{prototype}`, `{variant}` and
  `{theme}` are filled in.
- `entry`: which file in the prototype folder is one variant, so `working` and the sidebar
  can count them. `{variant}` is the variant's name.
- `ready` (optional): a path that answers 200 once the server is up. Default `/`.

Keep the recipe's own files in `<project>/stage/`. A recipe installs nothing: it uses the
repo's files and `node_modules` as they are, and when it needs a package the repo lacks,
say so in chat instead. For a site of plain files, this server is the whole recipe; copy it
to `stage/serve.mjs` and change nothing:

```js
import fs from "node:fs";
import http from "node:http";
import path from "node:path";
const port = Number(process.argv[process.argv.indexOf("--port") + 1]);
const project = process.cwd();
const repo = path.resolve(project, JSON.parse(fs.readFileSync("project.json", "utf8")).repo);
const types = { ".html": "text/html; charset=utf-8", ".css": "text/css", ".js": "text/javascript", ".mjs": "text/javascript", ".svg": "image/svg+xml", ".png": "image/png", ".jpg": "image/jpeg", ".woff2": "font/woff2", ".json": "application/json" };
http.createServer((request, response) => {
  const { pathname } = new URL(request.url, "http://127.0.0.1");
  const [base, rest] = pathname.startsWith("/repo/") ? [repo, pathname.slice(5)] : [project, pathname];
  let file = path.join(base, decodeURIComponent(rest));
  if (!file.startsWith(base)) return response.writeHead(403).end();
  if (fs.existsSync(file) && fs.statSync(file).isDirectory()) file = path.join(file, "index.html");
  if (!fs.existsSync(file)) return response.writeHead(404).end(`Not found: ${pathname}`);
  response.writeHead(200, { "content-type": types[path.extname(file)] ?? "application/octet-stream" });
  fs.createReadStream(file).pipe(response);
}).listen(port, "127.0.0.1");
```

It serves the project folder at `/` and the repo at `/repo/`, so a variant file links the
site's own stylesheets and scripts as `/repo/styles/site.css`. A variant is then
`<prototype>/<Name>.html`: a whole page that links those and holds the markup of the take.
For a framework Vite knows (Vue, Svelte, Solid), `start` is the repo's own Vite with a config
in `stage/` that mounts one component per variant; `variant` is then a query, as the
built-in recipe's is: `"?prototype={prototype}&variant={variant}"`.

A recipe is ready only when a variant renders through it: write `Current` (or `Mock`),
run `playground shot`, and fix the recipe until the shot reports no errors. Only then go on
to the takes that were asked for. When `working` says the stage failed, it prints the
server's last output: fix that, not the variant.

## Real data from the project's backend

When the project's own dev server runs on this Mac, prototypes can use its API instead of
fixtures. Set it once (or `--backend` on `add`, or the `backend` tool):

```sh
playground backend <project> http://localhost:3000            # proxies /api
playground backend <project> --paths /api,/graphql            # other prefixes
playground backend <project>                                  # what is set, and whether it runs
```

The stage forwards those paths to the dev server on the frame's own origin, so a prototype
fetches `/api/...` as the app does. `working` prints the backend and whether it is running.

- **Reads only.** GET and HEAD pass; the stage refuses POST, PUT, PATCH and DELETE with a
  405 that says why. When a prototype needs to write, ask the user in one sentence, and only
  on their yes run `playground backend <project> --writes yes`. A new address turns writes
  off again.
- **The dev server is the user's.** Sneak Peek never starts it. When it is down, the frame
  shows a strip and `shot` lists the error: tell the user to start it, or use fixtures.
- **The session** is the backend's own, signed in through a frame (or a dev login bypass),
  kept for every frame. The browser's login does not reach the stage.
- Setting or changing it reloads the project's frames once. It lives under `backend` in
  `project.json`. Server components and actions still do not run: pass their data as fixtures.

## Offering Sneak Peek on your own

Once a project is past its first frame, `working` may print one question to put in your
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
  project.json          repo path, global stylesheet(s), backend (dev server, paths, writes)
  stage.json            the recipe: built-in for a React repo, yours otherwise (Recipes above)
  stage/                a recipe's own files, such as its server
  map.md                generated by each `working`: screens, components, tokens
  tsconfig.json         generated; resolves the repo's aliases for tsc and the editor
  node_modules          generated link to the repo's node_modules
  <prototype>/
    index.tsx           one export per variant (built-in recipe)
    <Name>.html         or one file per variant, as the recipe's "entry" names them
    *.tsx               any helpers it needs
    snapshots/<date>/   dated copies, shown as history in the app
```

## Snapshots

Before reworking a prototype in a way that replaces what is there:

```sh
playground snapshot <project> <prototype>
```

A new direction that sits beside the others is a new variant instead. Snapshots copy the
folder, so imports that reach outside it with `../` break inside them.

## Opening

"Open the playground" or "open Sneak Peek" means the app, never a dev server and a browser
tab: `playground open`. `working` and `show` open it too. Never `open -a "Sneak Peek"`: with
a development build beside the installed app, that starts a second copy.

## Shipping one

If the user wants a take in the repo, port it as a normal task, following the repo's
conventions. The prototype is a reference, not code to copy verbatim.
