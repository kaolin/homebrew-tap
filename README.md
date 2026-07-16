# homebrew-tap

Kaolin's Homebrew tap. Formulae for personal tools.

> Replace `kaolin` with your actual GitHub username throughout if it differs.

## Use

```
brew install --HEAD kaolin/tap/crew    # installs from the main branch (no release needed)
brew services start crew               # start the 5-minute snapshot agent
```

`brew install kaolin/tap/crew` (without `--HEAD`) needs a tagged release — see below.

## Formulae

- **crew** — status console + dispatcher for hand-run Claude Code sessions.
  Optional companion: [spacetags](https://spacetags.app/) for Space-aware
  restore.

## Cutting a release (so plain `brew install` works)

In the `crew` repo:

```
git tag v0.1.0 && git push origin v0.1.0
```

Then get the tarball's checksum:

```
curl -sL https://github.com/kaolin/crew/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
```

In `Formula/crew.rb`: uncomment the `url` + `sha256` lines, paste the checksum,
bump the version in the URL, and remove reliance on `--HEAD`. Commit + push this
tap repo. Users then get it with `brew install kaolin/tap/crew` and
`brew upgrade crew`.

## How a tap works (short version)

- A tap is just a public GitHub repo named `homebrew-<name>` (this one →
  `kaolin/homebrew-tap`, referenced as `kaolin/tap`).
- Each `Formula/*.rb` is a Ruby recipe: where to download, how to install, an
  optional `service` block (launchd), and a `test`.
- `brew install kaolin/tap/crew` clones the tap and runs the formula.
