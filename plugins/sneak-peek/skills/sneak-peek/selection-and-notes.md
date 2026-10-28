# What the user selected, and their notes

## Selection

The app records what the user is looking at: the project, the Code Layer they last clicked,
its route and its size. When the user says "this", "the selected one", "make this bigger" or
"more like this one", read it first:

```sh
playground selected
```

It prints the project, its working copy (a design option's, when the layer shows one), the
Code Layer, its route and viewport. Say which one you took it to be ("Taking this as the
Stacked pricing layer"). If the selection does not fit the request, confirm before editing.

When the user picked an element with Inspect (⌥⌘C), the selection also names it: the tag
and text, and the components that rendered it. "This" then means that element: find it in
the working copy and edit it there.

## Notes

The user can leave a note on a picked element. Its numbered pin stays on it until you mark
the note handled. New notes arrive with the user's next message, each with its id, the
element and the components that rendered it. A rewritten note arrives again marked "edited
since you last saw it": follow the new words. To list open notes:

```sh
playground notes [<project>]
```

Treat each note as a request about that element: mark the work with `working`, change it in
the working copy, and check its layer. Once saved, mark it handled, which takes its pin off:

```sh
playground notes done <id> [<id>...]
```

Say which notes you handled by number ("Note 3: the button has more room now"). A note you
cannot act on, or that needs the user to decide, stays open: say why.
