# Git Mirror Setup Script

A bash script to automate the process of cloning a 42 School Vogsphere repository, creating a mirror backup on GitHub, and setting up your local environment to work exclusively with the 42 origin.

## Purpose

This script is designed for 42 School students who want to:
- Create a GitHub backup of their 42 Vogsphere projects
- Keep their local repository connected only to the 42 Vogsphere (for grading/evaluation)
- Avoid accidentally pushing changes to both repositories

## What It Does

1. Clones your 42 Vogsphere repository
2. Adds your GitHub repository as a temporary remote
3. Mirrors all branches and history to GitHub (one-time backup)
4. Removes the GitHub remote connection
5. Configures the local repository to only track 42 Vogsphere
6. Sets up proper upstream tracking for the master branch

After running this script, you can work on your 42 project without worrying about changes being pushed to your GitHub backup.

## Prerequisites

- Git installed on your system
- SSH keys configured for both 42 Vogsphere and GitHub
- A GitHub repository created (can be empty)

## Installation

```bash
# Download the script
sudo curl -fsSL https://raw.githubusercontent.com/YukiHalf/42-git-mirror/main/git_mirror_setup.sh -o /usr/local/bin/42-mirror && sudo chmod +x /usr/local/bin/42-mirror
# Then use it anywhere with: 42-mirror <args>
```

## Usage

```bash
./git_mirror_setup.sh <github_repo_link> <42_vogsphere_repo_link>  <dir_name>
```

### Example

```bash
./git_mirror_setup.sh \
  git@vogsphere.42.fr:vogsphere/intra-uuid-project-name.git \
  git@github.com:username/project-backup.git \
  my_project
```

### Parameters

- `42_vogsphere_repo_link`: Your 42 School Vogsphere repository URL
- `github_repo_link`: Your GitHub repository URL (for backup)
- `dir_name`: Local directory name for the cloned repository

## Features

- ✅ Color-coded output for easy progress tracking
- ✅ Step-by-step execution with clear feedback
- ✅ User confirmation before finalizing changes
- ✅ Error handling (exits on failure)
- ✅ Automatic cleanup of GitHub remote
- ✅ Preserves complete git history in the mirror

## What Happens After

After running this script:

- **GitHub repository**: Contains a complete mirror of your 42 project (backup only)
- **Local repository**: Connected only to 42 Vogsphere origin
- **Your workflow**: Push/pull operations only affect the 42 repository

You can safely make changes, commit, and push to your 42 repository without affecting the GitHub backup.

## Important Notes

⚠️ **One-time mirror**: The GitHub backup is created once and won't receive further updates automatically.

⚠️ **Evaluation requirements**: Always ensure your local repository is connected only to 42 Vogsphere before evaluation.

⚠️ **Manual updates**: If you want to update your GitHub backup later, you'll need to manually push changes to it.

## Troubleshooting

**"Permission denied" errors**: Make sure your SSH keys are properly configured for both 42 and GitHub.

**"Repository not found"**: Verify that both repository URLs are correct and accessible.

**Script stops at file listing**: This is intentional! Press Enter after verifying the files to continue.

## License

MIT License - Feel free to use and modify as needed.

## Contributing

Pull requests are welcome! Feel free to improve the script or documentation.

---

Made for 42 School students 🚀
