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
  // Nested item parameters
  nested-indent: 0.7, // Horizontal indent for nested items
  nested-dot-scale: 0.8, // Scale factor for nested item dots
  nested-spacing-scale: 0.8, // Scale factor for spacing of nested items
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

      // Helper function to flatten nested items for spacing calculation
      let flatten-items(items) = {
        let flat = ()
        for item in items {
          if type(item) == dictionary and "content" in item and "children" in item {
            flat.push((content: item.content, nested: false))
            for child in item.children {
              flat.push((content: child, nested: true))
            }
          } else {
            flat.push((content: item, nested: false))
          }
        }
        return flat
      }

      let flat-items = flatten-items(items)

      // Calculate total line length with dynamic spacing for highlighted items
      let total-spacing = 0
      for i in range(flat-items.len()) {
        if i == 0 {
          total-spacing += 0.5 // Initial offset
        } else {
          let current-spacing = item-spacing
          // Nested items have reduced spacing
          if flat-items.at(i).nested {
            current-spacing *= nested-spacing-scale
          }
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
      for (i, flat-item) in flat-items.enumerate() {
        // Check if this item should be highlighted
        let is-highlighted = highlight-at != none and i == highlight-at
        let is-nested = flat-item.nested

        // Calculate spacing for this item
        if i > 0 {
          let spacing = item-spacing
          // Nested items have reduced spacing
          if is-nested {
            spacing *= nested-spacing-scale
          }
          if highlight-at != none and (i == highlight-at or i == highlight-at + 1) {
            spacing *= highlight-spacing-scale
          }
          current-y -= spacing
        }

        let y-pos = current-y

        // Determine sizes based on highlight status and nesting
        let base-dot-size = if is-nested { dot-size * nested-dot-scale } else { dot-size }
        let current-dot-size = if is-highlighted { base-dot-size * highlight-dot-scale } else { base-dot-size }
        let current-font-size = if is-highlighted { font-size * highlight-text-scale } else { font-size }
        let current-connecting-thickness = if is-highlighted {
          connecting-line-thickness * highlight-dot-scale
        } else {
          connecting-line-thickness
        }

        // Calculate horizontal offset for nested items
        let x-offset = if is-nested { nested-indent } else { 0 }
        let dot-x = x-offset
        let connector-start-x = dot-x + current-dot-size + 0.05
        let connector-end-x = x-offset + 0.35
        let text-x = x-offset + 0.5

        // Add text to the right of the dot
        content(
          (text-x, y-pos),
          {
            set text(size: current-font-size, fill: text-color, weight: if is-highlighted { "bold" } else { "regular" })
            set align(left)
            flat-item.content
          },
          anchor: "west",
        )

        // Add connecting lines from dots to text - now with scaled thickness
        line(
          (connector-start-x, y-pos),
          (connector-end-x, y-pos),
          stroke: (paint: gray, thickness: current-connecting-thickness),
        )

        // Draw the dot
        circle((dot-x, y-pos), radius: current-dot-size, fill: dot-color, stroke: none)
      }
    },
  )
}
