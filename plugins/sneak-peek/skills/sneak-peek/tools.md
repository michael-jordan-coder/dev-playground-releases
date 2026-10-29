# Canvas tools

All tools return structured data and a short text representation. Errors have a code and
message. Partial results retain created workspace/frame IDs and report issues; continue
from those IDs instead of creating replacements. Project IDs are existing project names,
workspace IDs identify the main managed copy or an option, and frame IDs identify Code Layers.

- `get_context({projectId?, includeProjects?})`: project and source path, selected working
  copy/path, runtime, frames, selected element with its original timestamp, and open notes.
  Omit projectId for the open project. `last_known` means the canvas state is cached.
- `prepare_project({mode, projectId?, sourcePath?, name?, runtime?})`: mode is `existing`,
  `import`, or `blank`; import requires sourcePath. Runtime defaults to `ensure_running`,
  with `restart` and `leave_as_is` alternatives. Returns a managed copy, initial frame and
  runtime progress. It can return before installation or startup completes. Check context
  for subsequent progress. An explicitly stopped project should stay stopped unless the
  user's request authorizes starting it.
- `present({projectId?, frames?, focus?, activity?, resolvedNoteIds?})`: provide at least
  one action. Frames have stable `id`, optional `workspaceId`, `name`, `x`, `y`, `width`,
  `height`, and `route` (required for new frames). Omitted fields stay unchanged. New frames
  are placed beside existing ones. `focus` is `new` (default), `all`, or `none`; it targets
  the supplied frames. Activity is `{state: "working" | "idle", message?}`. Resolve only
  notes actually addressed. Successful saving or a focus request does not prove rendering.
- `inspect({projectId?, frameIds?, capture?, reload?})`: defaults to the selected or main
  frame, `canvas_only`, and no reload. `allow_browser_fallback` permits a separate browser
  render. Each result identifies the image index, capture source, route, observed URL when
  available, viewport and errors. `interactionChecks: "not_run"` is not a flow test.
- `create_alternative({projectId?, sourceFrameId?, key, name, focus?})`: creates a separate
  working copy from the selected/main frame and displays it alongside existing frames.
  Reuse the same key when retrying; code already edited in that alternative is preserved.
  Edit the returned workspace path. Use multiple routes in a shared copy when isolation
  is unnecessary. This tool never applies an option to original source.

Unsupported legacy projects are reported explicitly, never converted automatically.
If no project is open, choose an identified project or prepare one from the request;
ask only if the intended project cannot be determined.
