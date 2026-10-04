# What the user selected, and their notes

## Selection

The app records what the user is looking at: the prototype in the sidebar, the variant in
the toolbar, and the frame they last clicked. When the user says "this", "the selected
one", "make this bigger" or "more like this one", read it first:

```sh
playground selected
```

It prints the prototype, the variant and device, the file and export to edit, and how long
ago it was selected. Say which one you took it to be ("Taking this as contact-cta › Card on
phone"). If the selection is old, a snapshot, or does not fit the request, confirm before
editing.

When the user picked an element with Inspect (⌥⌘C), the selection also names it: the tag
and text, the line that wrote it, and each component that rendered it. "This" then means
that element. Edit the line given; when it is in the repo, change how the prototype uses it
instead.

## Notes

The user can leave a note on a picked element. Its numbered pin stays on it until you mark
the note handled. New notes arrive with the user's next message, each with its id, the
element, the line that wrote it and the components that rendered it. A rewritten note
arrives again marked "edited since you last saw it": follow the new words. To list open
notes:

```sh
playground notes [<project> [<prototype>]]
```

Treat each note as a request about that element: mark the work with `working`, change the
line given, and check the frame. Once saved, mark it handled, which takes its pin off:

```sh
playground notes done <id> [<id>...]
```

Say which notes you handled by number ("Note 3: the button has more room now"). A note you
cannot act on, or that needs the user to decide, stays open: say why.
