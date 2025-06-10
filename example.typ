#import "lib.typ": * // where touying and slide theme was imported.

// CHECKPOINT:
// - https://github.com/OrangeX4/typst-talk?tab=readme-ov-file
// - [Touying Gallery](https://github.com/touying-typ/touying/wiki)
//
// Useful packages
// - [showybox](https://typst.app/universe/package/showybox/)
//
// Themes:
// - https://touying-typ.github.io/docs/themes/stargazer/
// - https://touying-typ.github.io/docs/themes/dewdrop/#initialization

#show: stargazer-theme.with(
  // Needs to be set in the final script (the typst file for rendering the document).
  aspect-ratio: "16-9",
  footer-columns: (25%, 10%, 1fr, 5em),
  self-info,
  footer-a: none, // by default it takes `info.author`
  // Explicitly list all configuration available.
  // KEYNOTE:
  // - Click on `stargazer-theme` to open `~/.cache/typst/packages/preview/touying/0.6.1/themes/stargazer.typ`
  // - Also see https://touying-typ.github.io/docs/build-your-own-theme
  config-common(
    // Go to `default-config` in ~/.cache/typst/packages/preview/touying/0.6.1/src/configs.typ to see the full list of what you can set.
    slide-fn: slide,
    show-strong-with-alert: false, // strong (`*xxx*`) will set to primary color when `true`.
    new-section-slide-fn: new-section-slide.with(
      numbered: false,
    ), // This is the official example. This won't take effect if you use `SECTION`.
  ),
  config-methods(
    init: (self: none, body) => {
      set text(size: 24pt, font: ("Tinos", "Noto Serif CJK TC"))
      set list(marker: components.knob-marker(primary: self.colors.primary))
      show figure.caption: set text(size: 0.654em)
      show footnote.entry: set text(size: 0.654em)
      set footnote.entry(
        clearance: 0.2em, // A narrow gap between content and footnote.
        gap: 0.2em, // A narrower gap between entries.
        indent: 0em, // No indent
      )
      show math.equation: set text(
        size: 1em,
      ) // 1em is the same size as text. This is just the default value for showing how to set equation's attributes

      show heading: set text(fill: self.colors.primary)
      // Set heading numbering:
      // set heading(numbering: numbly("{1}.", default: "1.1"))
      show heading.where(level: 1): it => [
        // Set top-level headers.
        #text(
          size: 1.5em, // Larger size for emphasis
          stroke: 0.3pt, // Very slight stroke to simulate "boldness"
        )[#it]
      ]
      show heading.where(level: 2): it => [
        #text(
          size: 1.2em, // Larger size for emphasis
          stroke: 0.3pt, // Very slight stroke to simulate "boldness"
        )[#it]
      ]
      show link: it => if type(it.dest) == str {
        set text(fill: self.colors.primary)
        it
      } else {
        it
      }
      show figure.where(kind: table): set figure.caption(position: top)

      body
    },
    alert: utils.alert-with-primary-color,
    tblock: _tblock,
  ),
  theme-color-configuration,
)


#set figure(numbering: none)

// KEYNOTE: Guideline for this talk (by CCC in meeting 0611)
// - 本次報告敘事要注意動機目的未來方向
// - 人家沒時間了解細節
// - 三分鐘短講是很好的訓練

#custom-title()

#custom-outline()

// Introduction
#SECTION[= 背景與研究概述][
  - 文獻回顧
  - 沿革
]

