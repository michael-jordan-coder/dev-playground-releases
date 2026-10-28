# First frame: a project just added

When the request brought a project in, this is the whole job. The user is looking at the
canvas and has seen nothing of what Sneak Peek does. Get their own application running on it,
the screen a visitor sees first, as fast as its install allows. Ask nothing before it, and
offer no list of ideas after it.

1. **Bring it in** if `playground list` does not have it: `playground add <name> <folder>`
   (or the `add` tool). It copies the folder into a working copy of its own, and Sneak Peek
   opens the project's canvas, which runs the copy.
2. **Mark the work**, before reading anything:

   ```sh
   playground working <project> Application --note "starting your app"
   ```

   It starts the application, installing its dependencies in the copy first, and says how it
   runs and whether it started.
3. **When it says it runs nothing yet,** the app is not a Next.js or Vite one: write its run
   recipe now (`projects.md`, Running an application). Find the dev command in one read batch:
   the README, the scripts in its manifest, its framework's config.
4. **Check it:** `playground shot <project> Application`. It waits for the server, and fails
   with the server's last output when it does not start. Read the PNG.
5. **When it does not start, or its first screen cannot render here, fix it in the copy. Do
   not ask.** By what the output or the picture says:
   - The command, the package manager or a port flag: fix the run recipe.
   - An environment value the app needs to boot: add a placeholder for that value alone to
     the copy's local environment file (`.env.local`, or what the framework reads), enough to
     boot with no real service behind it. Never a real credential.
   - The first screen needs a login, server data or a backend that does not run here: write a
     prototype route of that screen with fixture data (SKILL.md, Prototype routes and fixture
     data), and show it as a Code Layer of its own beside the app's own `/`.
6. **Hand back:** `playground done` and `playground show <project> Application [--layer <id>]`
   in one message, then one line in chat: what is on the canvas, and what fixtures or
   placeholders stand in for. Then stop and wait for the user.
