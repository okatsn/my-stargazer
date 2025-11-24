// [Multi-File Architecture](https://touying-typ.github.io/docs/multi-file)
#import "@preview/touying:0.6.1": *
#import themes.stargazer: *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/mitex:0.2.5": *
#import "blocks.typ": *
#import "rubies.typ": *
#import "roadmap.typ": *
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/fletcher:0.5.7": diagram, edge, node
#import "colorconfig.typ": *
#import "timeline.typ": *




// Please refer the https://touying-typ.github.io/docs/0.3.2+/layout#page-columns for the composer option.
#let new-section-plain(composer: (auto, 1fr), left, right) = slide(
  title: none,
  composer: composer,
  [
    #set text(fill: theme-color-configuration.colors.primary)
    #left
  ],
  right,
)


// KEYNOTE: Use `SECTION[= Introduction][- brief notes]` instead of `= Introduction`
// #let SECTION = new-section-invert
#let SECTION = new-section-plain



// Custom outline slide
// See themes/dewdrop.typ
#let custom-outline(
  config: (:),
  title: utils.i18n-outline-title,
  title-size: 1.4em,
  text-size: 1em,
  ..args,
) = touying-slide-wrapper(self => {
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
            text(size: title-size, title),
          ),
        ),
      ), // The "Outline" shown on the top
      text(
        fill: self.colors.neutral-darker,
        size: text-size,
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

#let custom-title(
  config: (:),
  title-block-width: auto,
  title-block-inset: 1em,
  title-block-below: auto,
  title-font-size: 1.2em,
  ..args,
) = touying-slide-wrapper(self => {
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
      width: title-block-width,
      fill: self.colors.primary,
      inset: title-block-inset,
      radius: 0.5em,
      below: title-block-below,
      breakable: false,
      {
        text(size: title-font-size, fill: self.colors.neutral-lightest, weight: "bold", info.title)
        if info.subtitle != none {
          parbreak()
          text(size: title-font-size * 0.8, fill: self.colors.neutral-lightest, weight: "bold", info.subtitle)
        }
      },
    )
    // authors
    grid(
      columns: (auto,) * calc.min(info.authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 0.5em,
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


// Showing information about publication in a unified style.
#let work-output(title, authors, year, journal, other-info) = [
  #text(weight: "bold")[#title]
  #linebreak()
  #text(size: 0.9em, style: "italic")[
    #authors
    #if journal != none [, #journal]
    , #year
  ]
  #if other-info != none [
    #linebreak()
    #text(size: 0.8em)[#other-info]
  ]
]


/// Custom navigation with CJK support
///
/// Instead of relying on label-based short-heading conversion,
/// this allows direct heading body display or custom mappings.
///
/// - self (none): The self context
/// - short-heading (boolean): Whether to use short headings. Default is `true`.
/// - heading-map (dictionary): Optional mapping from full heading text to short text.
///   Example: `(
///     "背景與研究概述": "背景",
///     "資料與方法": "方法",
///   )`
/// - primary (color): Color of current section. Default is `white`.
/// - secondary (color): Color of other sections. Default is `gray`.
/// - background (color): Background color. Default is `black`.
/// - logo (none): Logo content. Default is `none`.
///
/// -> content
#let my-simple-navigation(
  self: none,
  short-heading: true,
  heading-map: (:),
  primary: white,
  secondary: gray,
  background: black,
  logo: none,
) = (
  context {
    let body() = {
      let sections = query(heading.where(level: 1))
      if sections.len() == 0 {
        return
      }
      let current-page = here().page()
      set text(size: 0.5em)

      for (section, next-section) in sections.zip(sections.slice(1) + (none,)) {
        set text(fill: if section.location().page() <= current-page
          and (
            next-section == none or current-page < next-section.location().page()
          ) {
          primary
        } else {
          secondary
        })

        // Custom heading display logic
        let heading-text = {
          // First try custom heading map by checking each key
          let matched-short = none
          for (long-text, short-text) in heading-map {
            // Match by checking if section body contains the long text
            let body-str = repr(section.body)
            if body-str.contains(long-text) {
              matched-short = short-text
              break
            }
          }

          if matched-short != none {
            // Use custom short form from map
            matched-short
          } else if short-heading and section.has("label") {
            // Fallback to label-based short heading
            utils.short-heading(self: self, section)
          } else {
            // Use full body
            section.body
          }
        }

        box(inset: 0.5em)[#link(
          section.location(),
          heading-text,
        )<touying-link>]
      }
    }

    block(
      fill: background,
      inset: 0pt,
      outset: 0pt,
      grid(
        align: center + horizon,
        columns: (1fr, auto),
        rows: 1.8em,
        gutter: 0em,
        components.cell(
          fill: background,
          body(),
        ),
        block(fill: background, inset: 4pt, height: 100%, text(fill: primary, logo)),
      ),
    )
  }
)
