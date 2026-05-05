# VanguardMod Docs

Documentation for **VanguardMod** — the competitive Wolfenstein: Enemy Territory mod.

This repository contains the source for the VanguardMod manual, written in
[AsciiDoc](https://asciidoc.org/) and rendered to PDF and HTML via
[Asciidoctor](https://asciidoctor.org/).

The manual is published in two places:

1. **GitHub Release on this repo** — `vanguardmod-manual-vX.Y.Z.pdf` is attached
   to each tagged release.
2. **Bundled with the mod** — the latest manual PDF is shipped inside the
   server ZIP of the [main vanguard repo](https://github.com/vanguardmod/vanguard)
   so server admins always have the docs at hand.

## Repository layout

```
docs/
├── book/                 chapter sources, master.adoc is the entry point
├── cvar/                 one .adoc file per cvar (a-la Jaymod's doc/cvar/)
├── images/               figures / diagrams referenced from the book
├── theme/                asciidoctor-pdf theme (VanguardMod branding)
├── .github/workflows/    CI (build on PR) + Release (tag → PDF → asset)
├── Gemfile               Ruby deps (asciidoctor, asciidoctor-pdf, rouge)
└── Makefile              `make pdf`, `make html`, `make clean`
```

## Building locally

Requirements: Ruby ≥ 3.0 and Bundler.

```sh
bundle install
make pdf      # → build/vanguardmod-manual.pdf
make html     # → build/vanguardmod-manual.html
make clean
```

## Versioning

Docs follow the same version scheme as the mod (semver, with optional
hotfix-suffix: `vMAJOR.MINOR.PATCH[.HOTFIX]`). Every mod release should have a
matching docs release tag.

## Contributing

- One cvar = one file in `cvar/`.
- New cvars must be `include::`d from `book/04-cvars.adoc`.
- Cross-references use `<<anchor-id,Display Text>>` syntax.
- Branding constants live in `book/attributes.adoc` — never hardcode the mod
  name, version, or URLs.

## License

Documentation source: GPL-3.0-or-later (same as the mod).
