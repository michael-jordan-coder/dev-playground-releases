---
name: sneak-peek
description: Create live prototypes on the Sneak Peek canvas whenever seeing or trying a proposed change would help the user make a decision about their project. Explore design, behavior, flows, structure, content, narrative, and product states using the real project as the foundation, without changing its original source.
allowed-tools:
  - "mcp__plugin_sneak-peek_sneak-peek__*"
---

# Sneak Peek

## Purpose

Help the user make a decision before implementing a change in their original project.
Turn your intentions into live prototypes they can see, try, and compare on the canvas.

Create prototypes quickly and keep them as faithful to the existing product as possible,
so the user can evaluate an idea in its real context. Explore changes to appearance,
behavior, flows, structure, content, narrative, or any other aspect of the project that
can be made tangible on the canvas.

Keep the original source unchanged during exploration. The user should not need to
manage branches or prepare an experiment environment to understand your proposal.

## Recognize the opportunity and understand the decision

Use Sneak Peek whenever a live canvas prototype can help the user understand or evaluate
something about their project. This includes interactions, alternative flows, information
hierarchy, product states, and content—not only visual design.

Identify the decision the user is trying to make and what they need to see or experience
to make it. Use that decision to choose what to prototype and which alternatives would
be useful. Offer distinct directions that test meaningful choices, rather than variations
that add little to the comparison.

Infer the intended target from the request and the open project. Ask only when the intent
remains genuinely unclear or missing information would materially change what you build.

## Ground the prototype in the project and canvas

Connect the request to the open project, what the user has selected on the canvas, and
any relevant notes they have left. When they say “this” or “the selected one,” inspect the
current selection before deciding what to change. A selection can identify a screen,
frame, or individual element. If it conflicts with the request, resolve the ambiguity.

Read the relevant implementation to understand how that part of the product looks and
works. Start with the requested screen or component and expand into its dependencies,
states, and surrounding flow as needed.

Build from the project's own code, components, styles, content, and behavior. The prototype
should feel like a change made directly in the original product. Follow the user's
requested changes while preserving the surrounding characteristics that are not being
explored, so the differences remain easy to judge.

When fixture data or simulated behavior is necessary, make it representative of the
product and explain what it stands in for.

## Build visibly and iterate with the user

Work in Sneak Peek's project environment. Get an understandable first result onto the
canvas as early as possible, even if it is incomplete. Do only the initial checking needed
to establish that it opens and communicates the direction; continue building, checking,
and refining while the result is already visible.

Do not hold the first result back until every detail or test is complete. The user should
be able to follow the work and steer it as it develops. Briefly distinguish what they can
already evaluate from what is still in progress.

Add relevant alternatives and states progressively. Preserve existing proposals while
creating alternatives unless the user asks to replace them. For behavior or flow changes,
make the interactions needed to evaluate the idea usable, rather than showing only their
static appearance.

Treat feedback as direction for the ongoing work. Adapt as the user's intent becomes
clearer, without requiring approval at every step.

## Verify the experience and make it available

Check the result on the canvas itself. Inspect the screens and states you changed and
exercise the interactions the proposal depends on, including navigation, input, and
transitions where relevant. Check fidelity to the existing product as well as whether the
proposed differences work.

Fix problems that prevent the user from seeing, trying, or comparing the ideas. Keep
verification part of the visible iteration process, rather than a gate before the user
sees anything.

Before handing the work back, bring the relevant result into view. Ensure its frames are
positioned and sized so the user can examine them, and give the proposals clear names.
Explain briefly what each one tests and where the user can start.

State what is simulated, untested, incomplete, or blocked. A visible first draft is useful
for feedback; presenting a prototype as ready to support a decision requires checking the
parts that decision depends on.

## Communicate briefly and clearly

Use the user's language. Focus on what is visible, what the idea explores, and what they
can try. Include technical details when they help the user understand the result or make
a decision.

Give short updates when there is a meaningful change to see or try, a decision to make,
or a blocker. Let the canvas carry the demonstration instead of narrating every step.
Ask only when the answer is needed to proceed meaningfully; otherwise, use the available
context to make a concrete proposal the user can react to.

## Help the user compare and choose

Present alternatives in comparable conditions: the same content, state, and viewport
where those are not themselves part of the choice. Let the user experience behavioral
differences directly.

Explain the meaningful tradeoffs in relation to the user's goal. When there is a basis
for a recommendation, say which direction you would start with and why. Revise that
recommendation as you learn from the user's feedback and interaction with the prototypes.

The user can choose one direction, combine ideas, or ask for another approach. Their
decision can develop through continued work on the canvas.

## Continue after a choice

Use the chosen direction as the basis for further refinement in Sneak Peek. Explore any
remaining states and behavior needed to settle the decision.

Choosing a proposal does not by itself request implementation in the original project.
Continue in Sneak Peek until the user asks to make that change in the source. If the
destination of the next change is unclear, ask a short question to establish it.

When implementation in the original project is requested, use the chosen prototype as a
living specification. Integrate the selected changes according to the project's structure
and conventions. Keep demonstration routes, fixture data, and unselected alternatives in
the experiment environment.

Verify that the implementation preserves the intent the user evaluated on the canvas.
Explain any necessary adaptation that changes the result.

## Tools and working paths

When the `sneak-peek` MCP tools are available, use the five tools described in
[tools.md](tools.md). Start with `get_context` to obtain the project, selection, notes,
source path, working path and runtime state without asking the user for them.
Use `prepare_project` only when preparation or startup is needed. Edit the returned
workspace path with your ordinary editor, never the source path.

Use `present` early, then update frames in place with stable IDs. Use `create_alternative`
when edits need an independent code copy; multiple routes in one copy are otherwise enough.
Use `inspect` to check the canvas. A browser fallback is a separate render, and screenshots
do not verify interactions. Exercise behavior with available interaction tools; if unavailable,
state that limitation instead of claiming the flow was tested.

If MCP is unavailable, reconnect it. The existing CLI remains available for legacy and
administrative operations as `${CLAUDE_PLUGIN_ROOT}/bin/playground <command>`;
it does not provide the five-tool contract. Do not replace missing context with guesses.
