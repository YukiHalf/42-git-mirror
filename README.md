# Git Mirror Setup Script

A bash script to automate the process of mirroring your GitHub repository to a 42 School Vogsphere repository, preserving all commit history and branches.

## 📋 Purpose

This script is designed for 42 School students who want to:
- Transfer an existing GitHub project to their 42 Vogsphere repository
- Preserve complete git history, commits, and branches
- Set up their local environment to work exclusively with the 42 origin for evaluations

## 🔄 What It Does

1. Clones your GitHub repository with full history
2. Adds your 42 Vogsphere repository as a temporary remote
3. Mirrors all branches and commit history to 42 Vogsphere (one-time transfer)
4. Removes the GitHub remote connection
5. Configures the local repository to only track 42 Vogsphere
6. Sets up proper upstream tracking for the master branch

After running this script, your 42 Vogsphere repository will contain everything from your GitHub repo, and your local repository will be connected only to 42 Vogsphere for evaluations.

## ✅ Prerequisites

- Git installed on your system
- SSH keys configured for both 42 Vogsphere and GitHub
- A 42 Vogsphere repository (can be empty)
- An existing GitHub repository with the code you want to transfer

## 📥 Installation

```bash
# Download the script to your home directory
curl -fsSL https://raw.githubusercontent.com/YukiHalf/42-git-mirror/main/git_mirror_setup.sh -o ~/42-mirror && chmod +x ~/42-mirror

# Add to your PATH (add this line to your ~/.zshrc or ~/.bashrc)
export PATH="$HOME:$PATH"

# Reload your shell configuration
source ~/.zshrc  # or source ~/.bashrc

# Then use it anywhere with:
42-mirror <github_repo_link> <42_vogsphere_repo_link> <dir_name>
```

**Alternative**: Run directly without installation
```bash
# Clone the repository
git clone git@github.com:YukiHalf/42-git-mirror.git
cd 42-git-mirror

# Make it executable
chmod +x git_mirror_setup.sh

# Run it
./git_mirror_setup.sh <github_repo_link> <42_vogsphere_repo_link> <dir_name>
```

## 🚀 Usage

```bash
./git_mirror_setup.sh <github_repo_link> <42_vogsphere_repo_link> <dir_name>
```

### Example

```bash
./git_mirror_setup.sh \
  git@github.com:username/my-project.git \
  git@vogsphere.42.fr:vogsphere/intra-uuid-project-name.git \
  my_project
```

### Parameters

| Parameter | Description |
|-----------|-------------|
| `github_repo_link` | Your GitHub repository URL (source) |
| `42_vogsphere_repo_link` | Your 42 School Vogsphere repository URL (destination) |
| `dir_name` | Local directory name for the cloned repository |

### ⚡ Quick Command (Advanced Users)

If you prefer a single command without the script:

```bash
git clone git@github.com:username/repo.git my_project && cd my_project && git push --mirror git@vogsphere.42.fr:repo.git && git remote set-url origin git@vogsphere.42.fr:repo.git
```

Replace the repository URLs and directory name with your own. This does the same thing but without error handling, colored output, or verification steps.

## ✨ Features

- ✅ Color-coded output for easy progress tracking
- ✅ Step-by-step execution with clear feedback
- ✅ User confirmation before finalizing changes
- ✅ Error handling (exits on failure)
- ✅ Automatic cleanup of GitHub remote
- ✅ Preserves complete git history in the transfer

## 📦 What Happens After

After running this script:

- **42 Vogsphere repository**: Contains a complete copy of your GitHub project with full history
- **Local repository**: Connected only to 42 Vogsphere origin
- **Your workflow**: Push/pull operations only affect the 42 repository

You can safely work on your project and push changes to your 42 repository for evaluations.

## ⚠️ Important Notes

- **One-time transfer**: This script transfers your GitHub repository to 42 Vogsphere once. Future updates must be pushed manually.
- **Evaluation requirements**: Your local repository will be connected only to 42 Vogsphere, which is required for evaluations.
- **Existing content**: If your 42 Vogsphere repository already contains commits, you may need to force push. The script will guide you through this.

## 🔧 Troubleshooting

### "Permission denied" errors
Make sure your SSH keys are properly configured for both 42 and GitHub.

```bash
# Test your SSH connections
ssh -T git@github.com
ssh -T git@vogsphere.42.fr
```

### "Repository not found"
Verify that both repository URLs are correct and accessible.

### Script stops at file listing
This is intentional! Press Enter after verifying the files to continue.

### Force push required
If your 42 repository has existing commits, you may need to use `git push -f origin master` to complete the transfer.

## 📝 License

MIT License - Feel free to use and modify as needed.

## 🤝 Contributing

Pull requests are welcome! Feel free to improve the script or documentation.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📧 Support

If you encounter any issues or have questions, please open an issue on GitHub.

---

Made with ❤️ for 42 School students 🚀
