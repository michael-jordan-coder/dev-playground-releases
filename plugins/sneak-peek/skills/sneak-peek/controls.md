# Controls: the full rules

Read this only when a control needs more than the example in SKILL.md, or when the user
asks to keep what they tuned.

- Say which element each control changes: `for` on the control, and a matching
  `data-control` on that element in the JSX. The user picks an element with Inspect and the
  inspector shows the controls of that element and of the ones around it. Use short names a
  designer would use (`card`, `avatar`, `title`), one element per name. Give every control
  a `for`, or none: a control without one is hidden whenever an element is picked.
- A spacing, radius, size or font size takes `presets`: the project's own scale, every
  token of that kind, from its tokens or Tailwind config. The default is one of them.
  Without presets, the menu holds a 4-point scale inside the range.
- A hex color takes the palette as named `presets`:
  `accent: { value: "#0f7a5a", presets: { accent: "#0f7a5a", info: "#2563eb", danger: "#c4352b" }, for: "button" }`.
  Offer the colors that could fill the control's role (for an accent, the brand and status
  colors); leave out state shades (hover, pressed, soft) and colors of another role. Without
  presets the user types a hex.
- A number with a fraction or a fine `step` (opacity, scale, line height) is a bar. A whole
  number whose `min` and `max` span up to five values is segments, drawn as columns or rows
  when the key says so (`columns: { value: 3, min: 1, max: 4 }`). A boolean is a switch and
  a list of `options` a pop-up menu, except ways to align (`start`, `center`, `end`, `left`,
  `right`, `top`, `bottom`, `stretch`, `between`, and `justify` for a key with `text` in
  it), which are icon segments: offer every direction of the axis. Any other string is a
  text field, which grows for copy over a line.
- A bare number needs a sensible range. Without one, a whole number (including 1) slides in
  whole steps up to three times itself, and only a value between 0 and 1, or one named like
  `opacity` or `alpha`, slides from 0 to 1. A scale or line height of 1 needs `min`, `max`
  and a `step` such as 0.05.
- Stay on the design system: offer its tokens as `options` (surfaces, sizes, variants, text
  styles) rather than raw values.
- Labels come from the keys (`showAvatar` reads "Show avatar"); set `label` when the key
  does not read well.

## Keeping what the user tuned

The values the user sets are saved per variant and show on every frame, `shot` included.
When they say to keep, use or apply them:

```sh
playground controls [<project> <prototype>] [--variant Name]   # tuned values next to their defaults
playground controls <project> <prototype> --variant Name --reset
```

Without a project it reads the selection. Write the changed values in as the new defaults
in `useControls`, then reset, so the frames show the code again.
