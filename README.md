# README

## Example Typst Package Structure

my-package/
├── typst.toml          # Package manifest (required)
├── lib.typ             # Main entrypoint file
├── README.md           # Documentation (required for submission)
├── LICENSE             # License file (required)
├── tests/              # Test files (recommended)
│   ├── test-basic.typ
│   └── test-advanced.typ
├── examples/           # Usage examples
│   └── example.typ
└── docs/              # Additional documentation
    └── manual.typ

For template packages, add:
├── template/          # Template files directory
│   ├── main.typ      # Template entrypoint
│   └── ...           # Other template files
└── thumbnail.png     # Template thumbnail (required for templates)

## Package Submission Checklist

□ Package Structure:
  □ typst.toml with all required fields
  □ README.md with clear documentation and examples
  □ LICENSE file with OSI-approved license
  □ Main entrypoint file (lib.typ)

□ Package Quality:
  □ Package name follows kebab-case convention
  □ Name is not too generic (avoid "slides", "math", etc.)
  □ Functions are well-documented
  □ Code follows reasonable style (2-space indent recommended)
  □ No large files (exclude them in typst.toml)

□ Testing:
  □ All functions work as documented
  □ Test files compile without errors
  □ Examples in README work correctly
  □ No security issues or data exfiltration

□ For Templates:
  □ Template directory with required files
  □ Thumbnail image (PNG/WebP, >1080px, <3MB)
  □ Template works with `typst init` command

□ Legal:
  □ License is OSI-approved
  □ All content is original or properly licensed
  □ Attribution is correct

