# First frame: a project just added

When the request brought a project in, this is the whole job. The user is looking at an empty
canvas and has seen nothing of what Sneak Peek does. Put one frame on it, their own screen,
within a minute. Ask nothing before it, and offer no list of ideas after it.

1. **Register it** if `playground list` does not have it (see `projects.md`).
2. **Mark the work**, before reading anything, on a prototype named for the screen
   (`home`, `pricing`, `dashboard`):

   ```sh
   playground working <project> <prototype> --note "putting your first screen up"
   ```

3. **Pick one screen** from the map `working` printed: the one a visitor sees first (the
   root route, or the entry the app opens on). With no screens, take the most self-contained
   composed component. Read that one file, and a component's file only when its map line is
   not enough.
4. **Write `index.tsx` with one variant, `Current`,** that renders that screen: the real
   component, imported from the repo. Data it fetches or receives from the server becomes
   fixture data passed in. No controls.
5. **When it cannot run here as it is, mock it. Do not ask.** That is a project that is not a
   React web app (Next, Vite), or a screen that needs what the stage does not run: server
   data, an Electron or native bridge, WebGPU, a canvas the app draws at runtime. Rebuild what
   the screen shows in React, from the repo's own components where they render, otherwise
   from its markup, stylesheet and tokens, with fixture data standing in for the rest. Name
   the variant `Mock` instead of `Current`.
6. **Check it once:** `playground shot <project> <prototype> --variant <Name>`, and read the
   PNG. Fix only what is broken.
7. **Hand back:** `playground done` and `playground show <project> <prototype> --variant
   <Name>` in one message, then one line in chat: what is on the canvas, and for a mock, what
   it stands in for. Then stop and wait for the user.
