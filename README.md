# README

## How to use

Install my-stargazer

```bash
pkgver="0.0.3"
target_path=~/.local/share/typst/packages/local/my-stargazer/$pkgver
mkdir -p "$target_path"
git clone --depth 1 --branch $pkgver https://github.com/okatsn/my-stargazer.git "$target_path"
# Create symlink to your development directory
ln -s "$target_path" $(pwd)
```

and

```typst
#import "@local/my-stargazer:0.0.3": *
```


Remove all versions


```bash
yes | rm -rv ~/.local/share/typst/packages/local/my-stargazer

```

## Example Typst Package Structure

my-package/
├── typst.toml          # Package manifest (required)
├── lib.typ             # Main entrypoint file
├── README.md           # Documentation (required for submission)
├── LICENSE             # License file (required)
└── example.typ

## Package Submission Checklist

□ Package Structure:
  □ typst.toml with all required fields
  □ Main entrypoint file (lib.typ)

□ Package Quality:
  □ Package name follows kebab-case convention
  □ Code follows reasonable style (2-space indent recommended)


## Releases

### 0.0.14

- Simply bump `mitex` to 0.2.7 to prevent error in typst 0.15.1

### 0.0.15

- Upgrade `touying` to 0.8.0, whose `components.knob-marker` no longer uses `place` and so is aligned with the text baseline in Typst 0.15 (fixes the bullet sitting below the first line).
- Minimum Typst version raised to 0.15.0 (required by touying 0.8.0).
