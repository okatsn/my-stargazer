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

