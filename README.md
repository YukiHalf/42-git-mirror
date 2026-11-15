# 42copy

`42copy` copies a Git repository into a 42 Vogsphere repository and creates
a local checkout configured for Vogsphere.

The command is designed for the common 42 workflow where GitHub uses
`main` and Vogsphere expects `master`.

## What it does

Given a source Git repository and a Vogsphere repository, `42copy`:

1. Verifies that the Vogsphere repository is reachable and, by default, empty.
2. Clones the source into `<source-name>_vog`.
3. Renames the source's default branch to `master`.
4. Copies the other branches and all tags.
5. Replaces the GitHub `origin` with the Vogsphere repository.
6. Configures local `master` to track `origin/master`.

Commit history is preserved. Remote-tracking refs such as
`refs/remotes/origin/main` are not copied into Vogsphere.

## Requirements

- Git
- Bash
- SSH access to the source repository and the Vogsphere repository
- An empty Vogsphere repository, unless `--override` is used deliberately

The command can be launched from zsh. It is an executable Bash script, so
do not source it into the current shell.

## Install for zsh

```sh
git clone git@github.com:YukiHalf/42-git-mirror.git
cd 42-git-mirror
mkdir -p "$HOME/.local/bin"
install -m 755 42copy "$HOME/.local/bin/42copy"
```

Ensure `~/.local/bin` is on zsh's `PATH`:

```sh
printf '%s\n' 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
source "$HOME/.zshrc"
```

If that export already exists in `~/.zshrc`, do not add it again.

## Usage

```text
42copy [--override] <git-repository> <vogsphere-repository> [directory]
```

Example:

```sh
42copy \
  git@github.com:username/cpp02.git \
  git@vogsphere.42heilbronn.de:vogsphere/intra-uuid-project-user
```

This creates `cpp02_vog`, pushes the source default branch to Vogsphere as
`master`, and leaves the checkout on `master` with this remote:

```text
origin  git@vogsphere.42heilbronn.de:vogsphere/intra-uuid-project-user
```

To choose a different checkout directory, pass it as the third argument:

```sh
42copy <git-repository> <vogsphere-repository> my_project_vog
```

To replace an existing Vogsphere repository deliberately:

```sh
42copy --override <git-repository> <vogsphere-repository> [directory]
```

`--override` force-updates matching branches and tags, then prunes destination
branches and tags that are absent from the source. It does not remove or reuse
an existing local checkout directory.

Repository URLs may use SSH, HTTPS, or local paths supported by Git.

## Safety behavior

- An existing checkout path is never overwritten, including with `--override`.
- A non-empty Vogsphere repository is refused unless `--override` is present.
- `--override` force-updates and prunes only destination branches and tags.
- Pushes never use `--mirror`, so remote-tracking refs are not copied.
- If a push fails, the local checkout remains available for inspection.
- If the source has distinct default and `master` branches, the command
  stops rather than choosing one silently.

Prefer a newly allocated Vogsphere repository. Use `--override` only when
replacing all of its existing branches and tags is intentional.

## Troubleshooting

### `Permission denied (publickey)`

Verify both SSH connections:

```sh
ssh -T git@github.com
ssh -T git@vogsphere.42heilbronn.de
```

### `The Vogsphere repository is not empty`

Use an empty Vogsphere repository, or add `--override` only if replacing and
pruning its existing branches and tags is intentional.

### `Destination path already exists`

Remove or rename the old local checkout, or pass a different directory as
the third argument.

### `42copy: command not found`

Confirm the installed command and zsh path:

```sh
ls -l "$HOME/.local/bin/42copy"
printf '%s\n' "$PATH"
```
