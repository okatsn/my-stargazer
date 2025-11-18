#import "../lib.typ": * // where touying and slide theme was imported.
#import "config.typ"
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





#let self-info = config-info(
  // KEYNOTE: This is `self.info` in the `...theme.with()` that you can refer.
  title: [#config.info.title_main],
  subtitle: [#config.info.title_sub],
  authors: config.info.authors,
  author: [#config.info.authors.join(" ")],
  short-title: [#config.info.title_short], // if there is no "short-title", "title" will be presented at the bottom-left footer (`footer-c`) of the stargaze slide.
  // date: datetime.today(),
  date: if config.info.presenting-date == none { datetime.today() } else { config.info.presenting-date },
  institution: [#config.info.department],
  hello: [world], // You can define arbitrary information (in this example, use with `self.info.hello`)
)

// Show stargazer

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
    cover: utils.semi-transparent-cover.with(alpha: 50%), // Set the transparency for the `uncover`ed object.
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
          stroke: 0pt, // You may assign slight stroke to simulate "boldness"
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


#custom-title()

#custom-outline()

// Introduction
// A transition page with:
#SECTION[
  // Left: Section title
  = Timeline and Milestone
][
  // Right: listed items (headers of subsections in this section)
  - Timeline
  - Milestone
]


== Timeline

#slide[
  #set text(size: 0.6em)
  #let evtbxwidth = 5cm
  // This is a horizontal timeline diagram where:
  // - x ticks: the timestamps in `year`
  // - an event points to a specific time point, showing a title adhere to a specific `year`.
  // - an event span is a rectangular that spans from `start-point` to `end-point` in `year` with transparent background color. Showing a range of a "phase" or "stage".
  #timeline(
    interval: 1,
    startyear: 2016,
    endyear: 2025,
    events: (
      event(
        title: "Initial Research Framework",
        year: 2019,
      ),
      event(
        title: "Pilot Study Completion",
        year: 2020,
      ),
      event(
        title: "Algorithm Development Phase",
        year: 2021,
      ),
      event(
        title: "System Integration",
        year: 2022,
      ),
      event(
        title: "Parameter Optimization Study",
        year: 2023,
      ),
      event(
        title: "Advanced Method Integration",
        year: 2024,
      ),
    ),
    eventspans: (
      eventspan(
        title: strong[Foundation Phase],
        start-point: 2016,
        end-point: 2018,
        color: theme-color-configuration.colors.primary,
        box-width: evtbxwidth,
      ),
      eventspan(
        title: strong[Development Phase],
        start-point: 2019,
        end-point: 2022,
        color: theme-color-configuration.colors.quaternary-light,
        box-width: evtbxwidth,
      ),
      eventspan(
        title: strong[Integration and Refinement Phase],
        start-point: 2022,
        end-point: 2025,
        color: theme-color-configuration.colors.secondary,
        box-width: evtbxwidth,
      ),
    ),
    length-of-timeline: 23,
    linestroke: 2pt + black,
    spanheight: 0.8,
  )

]


== Milestone

// This is a slide split into two panel, left and right.
// `composer` defines the aspect ratio of left and right panel.
#slide(composer: (2fr, 1.4fr))[
  // left panel:
  #set text(size: 0.7em)
  #grid(
    columns: (1fr, 0.8fr),
    gutter: 1em,
    [
      *Approach A limitations*
      - Limited scope of single point analysis
      - Uneven spatial distribution
      - Computational constraints
      - Coverage gaps in dataset
    ],
    [
      *Approach B advantages*
      - Integration of multiple data sources
      - Spatially uniform analysis
      - Fine-grained resolution
    ],
  )

  #simple-rect(subtitle: [A supplementary description for the small information box])[
    #set text(weight: "bold", size: 1.1em)
    The content of information
  ]

][
  // right panel:
  #set text(size: 0.7em)

  #let items = (
    text()[Data preprocessing and cleaning],
    text()[Statistical analysis],
    text()[Feature extraction #right-arrow-c #hlc[Feature engineering]],
    text(fill: gray)[Dimensionality reduction],
  )
  #let items_next = (
    text(fill: gray)[Model evaluation and validation],
    text(fill: gray, weight: "black")[Advanced algorithm integration],
    text(fill: gray)[Performance optimization],
    text(fill: gray, weight: "black")[System refinement and deployment],
  )

  // `roadmap-diagram` is a vertical timeline-like diagram.
  // - takes `items` as an array of `text`.
  // - you can assign a `title` for this diagram
  // - use `highlight-at` to make the text of a specific item `strong`.
  #roadmap-diagram(
    items,
    highlight-at: items.len() - 2,
    title: [Current work \ #text(size: 0.7em)[Detailed subtitle describing current research focus]
    ],
  )

  #roadmap-diagram(
    items_next,
    line-color: theme-color-configuration.colors.primary-light.lighten(50%),
    title: [Future outlooks],
  )

]

== Nested Milestone

#roadmap-diagram(
  (
    text()[Step 1: Regular item],
    (
      content: text()[Step 2: Parent item],
      children: (
        text(size: 0.8em)[Sub-step 2a],
        text(size: 0.8em)[Sub-step 2b],
      ),
    ),
    text()[Step 3: Another regular item],
  ),
  title: [Project Roadmap],
)

== Info-box and stacked simple-rect

#slide[
  #set text(size: 0.85em)
  #infobox(
    title: [The title for the major information box],
    type: "danger",
  )[
    - Key finding 1 #right-arrow-c #hlc[brief comment for this finding]
  ]

  #set align(center)

  #set text(size: 0.7em, weight: "bold")

  #stack(
    simple-rect(alignment: left)[
      📊 Data source A: Description of first data type and its characteristics
    ],
    simple-rect(alignment: left)[
      📈 Data source B: Description of second data type and its properties
    ],
  )

]

== Step workflow

#slide[
  #step-workflow(
    grid-columns: (1fr, 6fr),
    title: [Analysis workflow],
    [Step 1],
    [
      #let txt = [Preprocess data #linebreak() to ensure quality and consistency]
      #only("1")[#hla(txt)]
      #only("2-")[#txt]
    ],
    [Step 2],
    [
      #let txt = [Extract and construct features #linebreak() from multiple data sources]
      #only("2")[#hlb(txt)]
      #only("1,3-")[#txt]
    ],
    [Step 3],
    [
      #let txt = [Apply machine learning models #linebreak() with validation and ranking]
      #only("3")[#hlc(txt)]
      #only("1-2,4")[#txt]
    ],
    [Step 4],
    [Evaluate model performance and metrics],
    [Step 5],
    [Interpret results and draw conclusions],
  )
]

== Uncover

#slide(repeat: 3)[

  - First point to introduce

  #uncover("2-")[
    - Second point revealed progressively
  ]

  #uncover("3-")[
    - Third point revealed last
  ]
]


== References

#slide()[

  #set page(columns: 2)
  #set text(size: 0.4em)
  #bibliography("example.bib", style: "springer-basic", title: none)

]




#show: appendix

#SECTION[= Appendices][


]

