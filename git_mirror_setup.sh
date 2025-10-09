#!/bin/bash

# Git Mirror Setup Script
# This script clones a 42 Vogsphere repo, mirrors it to GitHub, 
# then sets up the local repo to only track the 42 Vogsphere origin

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if correct number of arguments provided
if [ "$#" -ne 3 ]; then
    echo -e "${RED}Error: Invalid number of arguments${NC}"
    echo "Usage: $0 <42_vogsphere_repo_link> <github_repo_link> <dir_name>"
    echo "Example: $0 git@vogsphere.42.fr:repo.git git@github.com:user/repo.git my_project"
    exit 1
fi

VOGSPHERE_REPO=$1
GITHUB_REPO=$2
DIR_NAME=$3

echo -e "${GREEN}=== Starting Git Mirror Setup ===${NC}\n"

# Step 1: Clone the 42 Vogsphere repository
echo -e "${YELLOW}[1/10] Cloning 42 Vogsphere repository...${NC}"
git clone "$VOGSPHERE_REPO" "$DIR_NAME"
echo -e "${GREEN}✓ Clone complete${NC}\n"

# Step 2: Change to the directory
echo -e "${YELLOW}[2/10] Changing to directory: $DIR_NAME${NC}"
cd "$DIR_NAME"
echo -e "${GREEN}✓ Changed directory${NC}\n"

# Step 3: Add GitHub remote
echo -e "${YELLOW}[3/10] Adding GitHub remote...${NC}"
git remote add my_repo "$GITHUB_REPO"
echo -e "${GREEN}✓ GitHub remote added${NC}\n"

# Step 4: Fetch from GitHub repo
echo -e "${YELLOW}[4/10] Fetching from GitHub repo...${NC}"
git fetch my_repo
echo -e "${GREEN}✓ Fetch complete${NC}\n"

# Step 5: Mirror push to GitHub
echo -e "${YELLOW}[5/10] Mirroring repository to GitHub...${NC}"
git push my_repo --mirror
echo -e "${GREEN}✓ Mirror push complete${NC}\n"

# Step 6: Reset origin URL (safety check)
echo -e "${YELLOW}[6/10] Resetting origin URL to 42 Vogsphere...${NC}"
git remote set-url origin "$VOGSPHERE_REPO"
echo -e "${GREEN}✓ Origin URL reset${NC}\n"

# Step 7: Checkout master and list files
echo -e "${YELLOW}[7/10] Checking out master branch...${NC}"
git checkout master
echo -e "${GREEN}✓ Checked out master${NC}\n"

echo -e "${YELLOW}Files in repository:${NC}"
git ls-files
echo ""

# Wait for user confirmation
echo -e "${YELLOW}Please verify the files above are correct.${NC}"
read -p "Press Enter to continue or Ctrl+C to abort..."
echo ""

# Step 8: Show remotes (should show origin and my_repo)
echo -e "${YELLOW}[8/10] Current remotes:${NC}"
git remote -v
echo ""

# Step 9: Remove GitHub remote
echo -e "${YELLOW}[9/10] Removing GitHub remote (my_repo)...${NC}"
git remote remove my_repo
echo -e "${GREEN}✓ GitHub remote removed${NC}\n"

echo -e "${YELLOW}Remotes after cleanup (should only show origin):${NC}"
git remote -v
echo ""

# Step 10: Set upstream for master
echo -e "${YELLOW}[10/10] Setting upstream for master branch...${NC}"
git push --set-upstream origin master
echo -e "${GREEN}✓ Upstream set${NC}\n"

echo -e "${GREEN}=== Setup Complete ===${NC}"
echo -e "${GREEN}Your repository is now configured to work with 42 Vogsphere only.${NC}"
echo -e "${GREEN}The GitHub repo has been mirrored but is no longer linked to this local copy.${NC}"
