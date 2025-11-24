// Example: How to use custom navigation with CJK support
#import "../lib.typ": * // where touying and slide theme was imported.

#let self-info = config-info(
  title: [報告標題],
  subtitle: [Subtitle],
  authors: ("作者",),
  author: "作者",
  short-title: [短標題],
  date: datetime.today(),
  institution: [機構],
)

// OPTION 1: Use custom heading map for precise control
#let my-heading-map = (
  // Map from full heading text to short text
  "背景與研究概述": "背景",
  "資料與方法": "方法",
  "結果與討論": "結果",
  "結論與未來展望": "結論",
  "附錄": "附錄",
)

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  footer-columns: (25%, 10%, 1fr, 5em),
  self-info,
  footer-a: none,
  config-common(
    slide-fn: slide,
    show-strong-with-alert: false,
    new-section-slide-fn: new-section-slide.with(numbered: false),
  ),
  config-methods(
    cover: utils.semi-transparent-cover.with(alpha: 50%),
    init: (self: none, body) => {
      set text(size: 24pt, font: ("Noto Serif CJK TC", "Tinos"))
      set list(marker: components.knob-marker(primary: self.colors.primary))
      show heading: set text(fill: self.colors.primary)
      body
    },
    alert: utils.alert-with-primary-color,
    tblock: _tblock,
  ),
  theme-color-configuration,
  config-store(
    // Override the navigation with custom one
    navigation: self => my-simple-navigation(
      self: self,
      short-heading: true,
      heading-map: my-heading-map, // Use custom map
      primary: white,
      secondary: gray,
      background: self.colors.neutral-darkest,
      logo: utils.call-or-display(self, self.store.header-right),
    ),
  ),
)

#set figure(numbering: none)

// ============================================================================
// Content
// ============================================================================

#title-slide()

= 背景與研究概述

== 研究目的

這是內容。

= 資料與方法

== 測站位置

更多內容。

= 結果與討論

== 主要發現

結果內容。

= 結論與未來展望

總結內容。

= 附錄

額外資訊。
