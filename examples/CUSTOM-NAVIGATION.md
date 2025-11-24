# Custom Navigation for CJK Headings

## Problem with Default `short-heading`

The built-in `utils.short-heading()` only works with **label-based conversion**:
- `<section:my-section>` → "My Section"
- It replaces `_` and `-` with spaces, applies title case
- **Does NOT work for CJK characters** (Chinese, Japanese, Korean)

## Solution: Custom Navigation Component

I've created `src/my-navigation.typ` with `my-simple-navigation()` function.

## Usage Options

### Option 1: Custom Heading Map (Recommended for CJK)

Explicitly map full heading text to short text:

```typst
#import "src/my-navigation.typ": my-simple-navigation

#let my-heading-map = (
  "背景與研究概述": "背景",
  "資料與方法": "方法",
  "結果與討論": "結果",
  "結論與未來展望": "結論",
)

#show: stargazer-theme.with(
  // ... other config ...
)

// Override navigation AFTER theme initialization
#show: touying-set-config.with(
  config-store(
    navigation: self => my-simple-navigation(
      self: self,
      heading-map: my-heading-map,  // ← Use custom map
      primary: white,
      secondary: gray,
      background: self.colors.neutral-darkest,
    ),
  )
)

= 背景與研究概述  // Will display as "背景" in navigation

== Content here...
```

### Option 2: Use Full Heading (No Shortening)

```typst
#show: stargazer-theme.with(
  // ... other config ...
)

#show: touying-set-config.with(
  config-store(
    navigation: self => my-simple-navigation(
      self: self,
      short-heading: false,  // ← Display full heading text
      primary: white,
      secondary: gray,
      background: self.colors.neutral-darkest,
    ),
  )
)
```

### Option 3: Mixed (Labels + Custom Map)

```typst
#let my-heading-map = (
  "背景與研究概述": "背景",
  "資料與方法": "方法",
)

// For headings WITH labels: use label-based short heading
= Background <sec:background>  // → "Background"

// For headings WITHOUT labels but in map: use custom map
= 背景與研究概述  // → "背景"

// For other headings: display full text
= Other Section  // → "Other Section"
```

## How It Works

The custom navigation checks in this order:
1. **Custom map**: If heading text is in `heading-map`, use mapped short text
2. **Label**: If heading has a label, use `utils.short-heading()` (label-based)
3. **Full text**: Otherwise, display full heading body

## Applying to Your Current Slide

In your `slide-fin.typ`, add:

```typst
#import "src/my-navigation.typ": my-simple-navigation

// Define your heading map
#let my-heading-map = (
  "背景與研究概述": "背景",
  "資料與方法": "方法",
  "結果與討論": "結果",
  "結論與未來展望": "結論",
  "附錄": "附錄",
)

#show: stargazer-theme.with(
  // ... existing config ...
)

// IMPORTANT: Override navigation AFTER theme initialization
// This ensures our custom navigation replaces the theme's default
#show: touying-set-config.with(
  config-store(
    navigation: self => my-simple-navigation(
      self: self,
      short-heading: true,
      heading-map: my-heading-map,
      primary: white,
      secondary: gray,
      background: self.colors.neutral-darkest,
      logo: utils.call-or-display(self, self.store.header-right),
    ),
  )
)
```

**Key Point**: Use `touying-set-config` **after** theme initialization. The stargazer theme sets its own navigation during initialization, so you must override it afterward.

## Benefits

✅ **Full CJK support** – Works with any Unicode characters
✅ **Flexible** – Mix custom maps, labels, and full text
✅ **Backward compatible** – Still supports label-based short headings
✅ **Type-safe** – Heading map is a simple dictionary

## See Also

- Example file: `EXAMPLE-custom-navigation.typ`
- Custom component: `src/my-navigation.typ`
- Original implementation: `~/.cache/typst/packages/preview/touying/0.6.1/src/components.typ`
