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

== Timeline

#slide[
  #set text(size: 0.6em)
  #let evtbxwidth = 5cm
  #timeline(
    interval: 1,
    startyear: 2016,
    endyear: 2025,
    events: (
      event(
        title: "MagTIP 演算法",
        year: 2019,
      ),
      event(
        title: "MagTIP 機率預報模式",
        year: 2020,
      ),
      event(
        title: "多變量 MagTIP 演算法",
        year: 2021,
      ),
      event(
        title: "GEMS-MagTIP 系統整合",
        year: 2022,
      ),
      event(
        title: "濾波頻段影響研究",
        year: 2023,
      ),
      event(
        title: "整合資訊理論",
        year: 2024,
      ),
    ),
    eventspans: (
      eventspan(
        title: strong[GEMSTIP 演算法],
        start-point: 2016,
        end-point: 2018,
        color: theme-color-configuration.colors.primary,
        box-width: evtbxwidth,
      ),
      eventspan(
        title: strong[MagTIP 發展期],
        start-point: 2019,
        end-point: 2022,
        color: theme-color-configuration.colors.quaternary-light,
        box-width: evtbxwidth,
      ),
      eventspan(
        title: strong[系統整合與分析期],
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

== Roadmap


#let items = (
  text()[缺失值與異常值的處理],
  text()[自相關分析：ACF/PACF 分析時間相依結構],
  text()[識別地電磁指標樣態 #right-arrow-c #hlc[特徵工程指引]],
  text(fill: gray)[發展降維技術解決特徵共線性問題],
)

#roadmap-diagram(
  items,
  highlight-at: items.len() - 2,
  title: [本期工作內容 \ #text(size: 0.7em)[自相關分析：邁向TIPTree的前置處理]
  ],
)


== Info-box and stacked simple-rect

#slide[
  #set text(size: 0.85em)
  #infobox(
    title: [地磁站的資訊理論指標所揭示的時間相依結構],
    type: "danger",
  )[
    - ACF/PACF 衰減快 #right-arrow-c #hlc[穩態]
    - ACF/PACF 在 lag 27 出現超越95%信賴區間的「丘狀」特徵 #linebreak() #right-arrow-c #hlc[$tilde 27$ 天週期的季節性變化]
  ]

  #set align(center)

  #set text(size: 0.7em, weight: "bold")

  #stack(
    simple-rect(alignment: left)[
      🌔 月球的軌道(公轉)週期 $tilde 27.3$ days
      @guoqing273day136dayAtmospheric2005
    ],
    simple-rect(alignment: left)[
      ☀️ 太陽的自轉週期 $tilde 27$ days
      @bartelsTwentysevenDayRecurrences1934
      @beckComparisonDifferentialRotation2000
    ],
  )

]

== Uncover

#slide(repeat: 3)[

  - item to show

  #uncover("2-")[
    - item to show
  ]

  #uncover("3-")[
    - item to show
  ]
]

== Step workflow

#step-workflow(
  title: [Analysis workflow],
  [Step 1],
  [
    #let txt = [Compute QD/IQD on Taiwan catalog #linebreak() to produce stable trend]
    #only("1")[#hla(txt)]
    #only("2-")[#txt]
  ],
  [Step 2],
  [
    #let txt = [Construct time-lagged features #linebreak() from rainfall & solar flux]
    #only("2")[#hlb(txt)]
    #only("1,3-")[#txt]
  ],
  [Step 3],
  [
    #let txt = [ML validation with CART #linebreak() importance ranking]
    #only("3")[#hlc(txt)]
    #only("1-2,4")[#txt]
  ],
  [Key 4],
  [description 4],
  [Key 5],
  [description 5],
),

== 參考文獻

#slide()[

  #set page(columns: 2)
  #set text(size: 0.7em)
  #bibliography("example.bib", style: "springer-basic", title: none)

]



#show: appendix

#SECTION[= 附錄][


]
