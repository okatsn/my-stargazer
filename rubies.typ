#import "@preview/rubby:0.10.2": get-ruby
// KEYNOTE: noted that currently the "furigana" (text above) does not support coloring and strong (e.g., #ruby[*ACF*][自相關函數]).
// KEYNOTE: The current `get-ruby` function interface does not allow you to set `ruby(pos: top, ..arg) = get-ruby(..., ..args)`.
//
// Ruby goes first, base text - second. Here is an example:
// #ruby[ふりがな][振り仮名]
//
#let ruby-size = 0.654em

#let rubytop(rt, rb, size: ruby-size, alignment: "center") = {
  let ruby-fn = get-ruby(
    size: size,
    dy: 0pt,
    pos: top,
    alignment: alignment,
    delimiter: "|",
    auto-spacing: true,
  )
  // get-ruby does not accept content arguments directly, so a two-step call is required
  ruby-fn(rt, rb)
}

#let rubybtm(rt, rb, size: ruby-size, alignment: "center") = {
  let ruby-fn = get-ruby(
    size: size, // Ruby font size
    dy: -1pt, // Vertical offset of the ruby
    pos: bottom, // Ruby position (top or bottom)
    alignment: alignment, // Ruby alignment ("center", "start", "between", "around")
    delimiter: "|", // The delimiter between words
    auto-spacing: true, // Automatically add necessary space around words
  )
  ruby-fn(rt, rb)
}

#let ruby = rubytop

