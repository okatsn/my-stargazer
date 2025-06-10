// [Multi-File Architecture](https://touying-typ.github.io/docs/multi-file)
#import "@preview/touying:0.6.1": *
#import themes.stargazer: *
#import "@preview/numbly:0.1.0": numbly
#import "../information/config.typ" // my global configuration
#import "@preview/mitex:0.2.5": *
#import "blocks.typ": *
#import "rubies.typ": *
#import "roadmap.typ": *
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/fletcher:0.5.7": diagram, node, edge
#import "colorconfig.typ": *



#let self-info = config-info(
  // KEYNOTE: This is `self.info` in the `...theme.with()` that you can refer.
  title: [#config.title_zh],
  subtitle: [#config.title_en],
  authors: config.authors,
  author: [#config.authors.join(" ")],
  short-title: [#config.short-title_zh], // if there is no "short-title", "title" will be presented at the bottom-left footer (`footer-c`) of the stargaze slide.
  // date: datetime.today(),
  date: if config.presenting-date == none { datetime.today() } else { config.presenting-date },
  institution: [#config.department],
  hello: [world], // You can define arbitrary information (in this example, use with `self.info.hello`)
)

// Please refer the https://touying-typ.github.io/docs/0.3.2+/layout#page-columns for the composer option.
#let new-section-plain(..bodies) = slide(title: none, composer: (auto, 1fr), ..bodies)

#let new-section-invert(config: (:), align: horizon + left, ..titlebody) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.primary,
      margin: 2em,
      header: none,
      footer: none,
    ),
  )
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 1.2em) // regular texts
  show heading.where(level: 1): it => [
    // Set top-level headers.
    #text(fill: self.colors.neutral-lightest, weight: "black")[#it]
  ]
  touying-slide(
    self: self,
    config: config,
    std.align(
      align,
      [
        #{ titlebody.at(0) } \ // title
        #{ titlebody.at(1) } // brief notes
      ],
    ),
  )
})

// KEYNOTE: Use `SECTION[= Introduction][- brief notes]` instead of `= Introduction`
// #let SECTION = new-section-invert
#let SECTION = new-section-plain



// Custom outline slide
// See themes/dewdrop.typ
#let custom-outline(config: (:), title: utils.i18n-outline-title, ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      margin: 2em, // narrower margin
      header: none, // KEYNOTE: no top banner. This makes the overflowed TOC (if it is long) does not obscured by the top banner.
      // footer: none,
    ),
  )
  self.store.title = title // "Outline" shown in the top banner, if header is not `none`.
  touying-slide(
    self: self,
    config: config,
    components.adaptive-columns(
      start: block(
        fill: self.colors.primary,
        inset: 8pt,
        radius: 4pt,
        text(
          1.4em,
          fill: self.colors.primary-lightest,
          weight: "bold",
          utils.call-or-display(
            self,
            text(size: 1.4em, title),
          ),
        ),
      ), // The "Outline" shown on the top
      text(
        fill: self.colors.neutral-darker,
        outline(
          title: none,
          indent: 1em,
          depth: self.slide-level,
          ..args,
        ), // self.slide-level is heading of `level: 2`.
      ),
    ),
  )
})



// Custom title slide
// Modified from ~/.cache/typst/packages/preview/touying/0.6.1/themes/stargazer.typ

#let custom-title(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
  )
  self.store.title = none
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
    show: std.align.with(center + top)
    block(
      fill: self.colors.primary,
      inset: 1.5em,
      radius: 0.5em,
      breakable: false,
      {
        text(size: 1.2em, fill: self.colors.neutral-lightest, weight: "bold", info.title)
        if info.subtitle != none {
          parbreak()
          text(size: 1.0em, fill: self.colors.neutral-lightest, weight: "bold", info.subtitle)
        }
      },
    )
    // authors
    grid(
      columns: (auto,) * calc.min(info.authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
      ..info.authors.map(author => text(fill: black, author)),
    )
    // others
    block(
      breakable: false,
      [
        // institution
        #if info.institution != none {
          text(size: 0.7em, info.institution)
        }
        \
        // date
        #if info.date != none {
          text(size: 0.7em, utils.display-info-date(self))
        }
      ],
    )
  }
  touying-slide(self: self, body)
})


