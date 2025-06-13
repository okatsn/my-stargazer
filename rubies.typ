#import "@preview/rubby:0.10.2": get-ruby
// KEYNOTE: noted that currently the "furigana" (text above) does not support coloring and strong (e.g., #ruby[*ACF*][自相關函數]).
// KEYNOTE: The current `get-ruby` function interface does not allow you to set `ruby(pos: top, ..arg) = get-ruby(..., ..args)`.
//
// Ruby goes first, base text - second. Here is an example:
// #ruby[ふりがな][振り仮名]
//
#let ruby-size = 0.6em

#let rubytop = get-ruby(
  size: ruby-size, // Ruby font size
  dy: 0pt, // Vertical offset of the ruby
  pos: top, // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|", // The delimiter between words
  auto-spacing: true, // Automatically add necessary space around words
)
#let rubybtm = get-ruby(
  size: ruby-size, // Ruby font size
  dy: -1pt, // Vertical offset of the ruby
  pos: bottom, // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|", // The delimiter between words
  auto-spacing: true, // Automatically add necessary space around words
)
#let ruby = rubytop

