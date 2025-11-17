#import "@preview/touying:0.6.1": config-colors

#let theme-color-configuration = config-colors(
  primary: rgb("#005bac"),
  primary-dark: rgb("#004078"),
  primary-light: rgb("#337ab7"),
  secondary: rgb("#28a745"), // Green
  secondary-dark: rgb("#1e7e34"), // Dark green
  secondary-light: rgb("#5cb85c"), // Light green
  tertiary: rgb("#ac1100"), //
  tertiary-dark: rgb("#8b0e00"), // Darker red
  tertiary-light: rgb("#d63384"), // Lighter, more vibrant red-pink
  quinary: rgb("#ff6b35"), // Vibrant orange
  quinary-dark: rgb("#e55a2b"), // Darker orange
  quinary-light: rgb("#ff8c69"), // Light coral-orange
  quaternary: rgb("#6a4c00"), // Brown
  quaternary-dark: rgb("#4a3500"), // Darker brown
  quaternary-light: rgb("#8a6c20"), // Lighter brown

  neutral-lightest: rgb("#ffffff"),
  neutral-darkest: rgb("#000000"),
)

#let hla(x) = strong(text(fill: theme-color-configuration.colors.primary)[#x])
#let hlb(x) = strong(text(fill: theme-color-configuration.colors.secondary)[#x])
#let hlc(x) = strong(text(fill: theme-color-configuration.colors.tertiary)[#x])
#let hlad(x) = strong(text(fill: theme-color-configuration.colors.primary-dark)[#x])
#let hlbd(x) = strong(text(fill: theme-color-configuration.colors.secondary-dark)[#x])
#let hlcd(x) = strong(text(fill: theme-color-configuration.colors.tertiary-dark)[#x])
#let hle(x) = strong(text(fill: theme-color-configuration.colors.quinary)[#x])
#let hled(x) = strong(text(fill: theme-color-configuration.colors.quinary-dark)[#x])
#let hld(x) = strong(text(fill: theme-color-configuration.colors.quaternary)[#x])
#let hldd(x) = strong(text(fill: theme-color-configuration.colors.quaternary-dark)[#x])

#let right-arrow-a = text(fill: theme-color-configuration.colors.primary)[▶️]
#let right-arrow-b = text(fill: theme-color-configuration.colors.secondary)[▶️]
#let right-arrow-c = text(fill: theme-color-configuration.colors.tertiary)[▶️]
#let right-arrow-e = text(fill: theme-color-configuration.colors.quinary)[▶️]
#let right-arrow-d = text(fill: theme-color-configuration.colors.quaternary)[▶️]
#let right-arrow-k = text(fill: black)[▶️]
#let right-arrow = right-arrow-a
