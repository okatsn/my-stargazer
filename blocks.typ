
#import "@preview/showybox:2.0.4": showybox
#import "colorconfig.typ": theme-color-configuration
// https://github.com/Pablo-Gonzalez-Calderon/showybox-package/blob/main/examples/examples.typ
#let infobox(title: "", breakable: false, footer: "", title-align: center, type: "note", ..args) = {
  let color = {
    if type == "info" { blue } else if type == "tip" { rgb("#1e8449") } else if type == "warning" {
      rgb("#e67e22")
    } else if (
      type == "danger"
    ) { rgb("#cb4335") } else if type == "note" { rgb("#abb2b9") } // cornflower blue
    else { blue } // default
  }
  showybox(
    title: align(title-align, strong(title)),
    frame: (
      radius: 15pt,
      thickness: 0pt,
      border-color: color,
      title-color: color,
      body-color: color.lighten(92%),
      footer-color: color.lighten(80%),
      breakable: breakable,
    ),
    shadow: (
      offset: 3pt,
    ),
    footer: footer,
    ..args,
  )
}

#let foot-block(..kwargs, txt) = block(
  height: 1fr, // This block extends to the rest of the page
  inset: 0em, // no inset so it aligns with the paragraph.
  align(
    bottom, // align to bottom.
    block(..kwargs, txt),
  ),
)

// foot-block with top and bottom horizontal lines like ruled paper.
#let foot-block-ruled(
  txt,
) = foot-block(
  height: auto,
  inset: 2pt,
  stroke: (
    top: 0.3pt + black,
    bottom: 0.3pt + black,
    left: none,
    right: none,
  ),
  txt,
) // an alternative foot-block function with the following settings to show top and bottom strokes.


#let simple-rect(alignment: center, subtitle: none, rect-radius: 0.5em, body) = align(
  alignment,
  grid(
    columns: 1fr,
    rows: if subtitle != none { (auto, auto) } else { (auto,) },
    row-gutter: 0.18em,
    if subtitle != none [
      #set text(size: 0.8em, fill: theme-color-configuration.colors.primary-dark)
      #align(left, subtitle)
    ],
    rect(
      fill: theme-color-configuration.colors.primary-dark,
      radius: rect-radius,
      [
        #set text(fill: theme-color-configuration.colors.primary-dark.lighten(90%))
        #body
      ],
    )
  ),
)



