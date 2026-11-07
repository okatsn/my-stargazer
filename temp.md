### 1. What is wrong & why it did not happen in Typst $\le 0.14$

The shifted bullet comes from the interaction between **`components.knob-marker` in Touying ($\le 0.7.1$)** (set in `init` via `set list(marker: components.knob-marker(primary: self.colors.primary))`) and a **breaking layout change in Typst 0.15.0**:

* **How `components.knob-marker` is built in Touying $\le 0.7.1$:**
It draws the circular gradient bullet using `place(dy: 0.1em, circle(radius: 0.25em, ...))` inside a zero-height `box(width: 0.5em)`. Because the `box` contains no text and uses `place(...)`, its height is `0pt` and its implicit baseline is at `y = 0pt`.
* **Behavior in Typst $\le 0.14$ (Top-aligned):**
List markers and item bodies were aligned at their **top edges**. The `0pt`-height box of `knob-marker` was placed at the top of the item's first line of text, and `place(dy: 0.1em, ...)` pushed the circle slightly downward from the top of the line so that it visually centered against the text.
* **Behavior in Typst $\ge 0.15$ (Baseline-aligned):**
Typst 0.15 overhauled baseline propagation so that list markers and enum numbers are **baseline-aligned** with the first line of the list item by default (and introduced `list.marker-align`, which defaults to `end` with baseline vertical alignment).
* Standard text markers (`[•]`, `[–]`) are unaffected because they carry a font baseline matching the item text.
* Because `components.knob-marker` is a heightless non-text `box`, Typst 0.15 places its `y = 0pt` origin on the **text baseline** (the bottom of characters like `x`) instead of the top of the line, and `place(dy: 0.1em, ...)` pushes the knob a further `0.1em` *below* the baseline—causing the bullet to sink below the text line.



---

### 2. Cleanest Ways to Fix It

Fixing the marker definition itself (removing the `place` offset hack so the marker has a real baseline) is cleaner than relying on layout workarounds, because it renders identically on **both** Typst $\le 0.14$ and Typst $\ge 0.15$.

#### Option A: Fix in `my-stargazer` (Recommended — Package Side)

1. **Define a baseline-aware `knob-marker` in `lib.typ`:**
Instead of using `place(dy: 0.1em, ...)` inside a heightless box, put the `circle` directly inside a `box` and anchor it to a zero-width space (`#sym.zws`). Because `#sym.zws` establishes a standard text line box and baseline, this works identically in Typst $\le 0.14$ (top-aligned line boxes) and Typst $\ge 0.15$ (baseline-aligned):
```typst
// In my-stargazer/lib.typ
#let knob-marker(primary: rgb("#005bac")) = [
  #sym.zws#box(
    baseline: -0.1em, // Fine-tune vertical centering relative to x-height
    circle(
      radius: 0.25em,
      fill: gradient.radial(
        primary.lighten(100%),
        primary.darken(40%),
        focal-center: (30%, 30%),
      ),
    ),
  )
]

```


Then use `set list(marker: knob-marker(primary: self.colors.primary))` in `example.typ` (and your workspace's `slide-mid-zhtw.typ`).


2. **Alternatively, upgrade `touying` in `lib.typ`:**
`my-stargazer/lib.typ` currently imports `@preview/touying:0.7.1`. If you are moving to Typst $\ge 0.15$, upgrading `lib.typ` to `#import "@preview/touying:0.8.0": *` (the first Touying release targeting Typst 0.15+) also resolves the broken `semi-transparent-cover` noted in your `example.typ` comment via `alpha-changing-cover`.



---

#### Option B: Fix in the Workspace (No changes to `@local/my-stargazer:0.0.14`)

If you do not want to rebuild/bump `my-stargazer`, you have two clean choices in the workspace:

1. **One-line fix in `slide-mid-zhtw.typ` using `marker-align` (Typst $\ge 0.15.1$ only):**
Restore Typst $\le 0.14$'s top-alignment for list markers in `config-methods.init`:


```typst
// In slide-mid-zhtw.typ (inside config-methods -> init)
set list(
  marker: components.knob-marker(primary: self.colors.primary),
  marker-align: top + end,
)

```


*(Note: Use Typst $\ge 0.15.1$ if you use `marker-align: top + end`, as Typst 0.15.0 had a layout bug with vertical `marker-align` in multi-page lists. Also note that `marker-align` is not recognized by Typst $\le 0.14$.)*
2. **Version-agnostic fix in `slide-mid-zhtw.typ` (Works in both Typst $\le 0.14$ and $\ge 0.15$):**
If the workspace needs to compile cleanly across teammates or CI running either Typst $\le 0.14$ or $\ge 0.15$, replace `components.knob-marker(...)` in `slide-mid-zhtw.typ` (or export a helper from `typst-src/slide.typ`) with the `#sym.zws#box(...)` definition from Option A.1 above.