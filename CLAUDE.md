# dotfiles

Personal dotfiles deployed with GNU Stow (see `README.md`).

## Conventions

- **Keep the README in sync with the repo.** When you add or remove anything the
  README describes — a Stow package, a top-level dir, or an external plugin in
  `ext_pull.sh` — update `README.md` in the *same* change:
  - the intro's list of stowed packages and the **Packages** table,
  - the **Credits** section (every external project, with a source link).
  The README must never drift from the actual layout or `ext_pull.sh`.
