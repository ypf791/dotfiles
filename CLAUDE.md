# dotfiles

Personal dotfiles deployed with GNU Stow (see `README.md`).

## Conventions

- **Adding or removing a Stow package?** Create or delete `<pkg>/` (mirroring
  `$HOME`), update the `ALL` array in `install.sh`, and add/remove any external
  plugins in `ext_pull.sh`.
- **Keep the README in sync with the repo.** Any change to the package set, a
  top-level dir, or an external plugin in `ext_pull.sh` must update `README.md` in
  the *same* change:
  - the intro's list of stowed packages and the **What's inside** table,
  - the **Acknowledgements** section (every external project, with a source link).
  The README must never drift from the actual layout or `ext_pull.sh`.
