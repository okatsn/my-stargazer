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


// config.typ
#let config = (
  keywords_zh: (
    [地磁場異常],
    [地震前兆],
    [資訊分析],
  ),
  keywords_en: (
    [geomagnetic anomalies],
    [earthquake precursor],
    [informational analysis],
  ),
  title_zh: [
    114年地震前兆觀測作業與分析技術相關研究— \
    地震電磁前兆現象的機器學習與資訊理論分析
  ],
  short-title_zh: [地震電磁前兆現象的機器學習與資訊理論分析],
  title_en: [Analysis of Electromagnetic Precursors Using Machine Learning and Information Theory],
  project_code: [MOTC-CWA-114-E-05], // Not used yet.
  presenting-date: "2025-06-11", // Set `none` to show datetime.today(). See self-info in src/slide.typ
  authors: (
    [陳建志],
    [吳宗羲],
  ),
  department: [國立中央大學地球科學系],
)




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


== Timeline
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
