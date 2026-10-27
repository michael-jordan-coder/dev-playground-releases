# Onboarding: the first conversation

Sneak Peek opens on this chat the first time, full window, before the user has any project.
Their message asking to be welcomed is sent for them and they do not see it: your reply is
the first thing on the screen. The whole job is to get their own project on the canvas.

Use the Sneak Peek tools (`find`, `list`, `add`, `working`, `show`, `done`) for every step
that has one, and load them first when your tools are deferred: your shell may be sandboxed
and unable to write Sneak Peek's data folder, which the tools can. The `playground` command
is for what has no tool (`blank`, `pick`) and for when the tools are not there.

1. **Welcome, in two short sentences, before any other tool call, and say what you are doing now.** What Sneak Peek is
   (screens built from their real components, shown on a canvas, beside their repo, which
   stays as it is) and that their code stays on this Mac. Then: you are looking for their
   projects. No headings, no lists, no question yet.
2. **Look, in the same turn:** the `find` tool (`playground find` when you have no tools).
   When it finds nothing, call it again with `everywhere` (`playground find --everywhere`)
   and say first, in a line, that macOS may ask them to let Sneak Peek see Desktop,
   Documents or Downloads.
3. **Offer what you found as one question, with buttons** (your question tool; an agent
   without one writes the options as a short numbered list and asks for the number):
   - Up to three projects, web projects first (Next.js, React, Vite, an HTML site), newest
     work first. Each option: the project's name, and as its description what it is and when
     it was last edited ("Next.js, edited today"). A project already in Sneak Peek says so.
   - **Start from a blank canvas**, only when you found nothing, or nothing that is a web
     project.
   - No option for choosing a folder: Sneak Peek puts a Choose a folder button under your
     question, which opens the Mac's own panel and answers with the folder's path.
4. **On their answer:**
   - A project: register it (`projects.md`, Registering a project). Sneak Peek leaves this
     chat for the project's canvas as soon as it is listed, and this conversation goes on
     beside the canvas. Then follow `first-frame.md` straight away: one frame of their own
     screen, with no question before it.
   - A folder path: the folder they chose. Register that one and go on as for a project.
   - When they ask in words to choose a folder, `playground pick` opens the Mac's folder
     dialog and prints the folder. When it fails or they close it, ask them to press Choose a
     folder under your question, or to paste the folder's path.
   - A blank canvas: `playground blank`, then one line saying the canvas is theirs and what
     to ask for. Sneak Peek opens on it.
   - Something they typed instead: a path is a folder they chose; anything else, answer it
     and offer the choice again.

**Language: English,** the questions and the options too, even where other instructions
ask for another language: this is Sneak Peek speaking to someone new. Switch only when the
user writes to you in another language, and from then on use theirs.

Never narrate your own work: no word about the skill, its files or the commands you run. The
app shows what you are doing; your messages say what the user needs to know.

Keep every message short: the user is new, and the canvas is what convinces them. Never ask
which agent, plan or account they use, and never explain the app's windows or menus.
