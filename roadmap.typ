#import "@preview/cetz:0.3.4": canvas, draw
#import "colorconfig.typ": theme-color-configuration
#let roadmap-diagram(
  items,
  title: none,
  title-anchor: "base-west",
  font-size: 1em,
  dot-size: 0.17,
  canvas-length: 1cm,
  canvas-width: 8,
  canvas-height: 8,
  line-color: theme-color-configuration.colors.primary-light,
  item-spacing: 1., // New parameter for spacing between items
  highlight-at: none, // New parameter for highlighting specific item
  // Highlight scaling factors
  highlight-dot-scale: 1.3,
  highlight-text-scale: 1.15,
  highlight-spacing-scale: 1.15,
) = {
  canvas(
    length: canvas-length,
    {
      import draw: *

      // Set colors
      let dot-color = line-color
      let text-color = black
      let title-bg-color = line-color
      let title-text-color = line-color.lighten(0%)

      // Calculate scaled line thickness based on dot size
      let main-line-thickness = dot-size * 0.7
      let connecting-line-thickness = dot-size * 0.5


      // Calculate positions based on title presence and dynamic spacing
      let title-height = if title != none { 0.6 } else { 0 }
      let title-bottom = if title != none { 0.7 } else { 0 }
      let start-y = title-bottom

      // Calculate total line length with dynamic spacing for highlighted items
      let total-spacing = 0
      for i in range(items.len()) {
        if i == 0 {
          total-spacing += 0.5 // Initial offset
        } else {
          let current-spacing = item-spacing
          // Add extra spacing around highlighted item
          if highlight-at != none and (i == highlight-at or i == highlight-at + 1) {
            current-spacing *= highlight-spacing-scale
          }
          total-spacing += current-spacing
        }
      }
      let line-length = total-spacing

      // Draw title if provided
      if title != none {
        // Calculate dynamic rectangle dimensions based on title content
        let title-padding = 0.2
        let title-width = 2.5 // You can make this configurable if needed

        // Draw title text inside the rectangle
        content(
          (0, title-bottom + title-height / 2),
          {
            set text(size: font-size * 1.2, fill: title-text-color, weight: "black")
            title
          },
          anchor: title-anchor,
        )
      }

      // Draw the main vertical line - now with scaled thickness
      line((0, start-y), (0, start-y - line-length), stroke: (paint: line-color, thickness: main-line-thickness))

      // Draw dots and text for each item with dynamic positioning
      let current-y = start-y - 0.5
      for (i, item) in items.enumerate() {
        // Check if this item should be highlighted
        let is-highlighted = highlight-at != none and i == highlight-at

        // Calculate spacing for this item
        if i > 0 {
          let spacing = item-spacing
          if highlight-at != none and (i == highlight-at or i == highlight-at + 1) {
            spacing *= highlight-spacing-scale
          }
          current-y -= spacing
        }

        let y-pos = current-y

        // Determine sizes based on highlight status
        let current-dot-size = if is-highlighted { dot-size * highlight-dot-scale } else { dot-size }
        let current-font-size = if is-highlighted { font-size * highlight-text-scale } else { font-size }
        let current-connecting-thickness = if is-highlighted {
          connecting-line-thickness * highlight-dot-scale
        } else {
          connecting-line-thickness
        }

        // Add text to the right of the dot
        content(
          (0.5, y-pos),
          {
            set text(size: current-font-size, fill: text-color, weight: if is-highlighted { "bold" } else { "regular" })
            set align(left)
            item
          },
          anchor: "west",
        )

        // Add connecting lines from dots to text - now with scaled thickness
        line(
          (current-dot-size + 0.05, y-pos),
          (0.35, y-pos),
          stroke: (paint: gray, thickness: current-connecting-thickness),
        )

        // Draw the dot
        circle((0, y-pos), radius: current-dot-size, fill: dot-color, stroke: none)
      }
    },
  )
}
