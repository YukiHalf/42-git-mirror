#!/bin/bash
# Git Mirror Setup Script
# This script clones a GitHub repo, mirrors it to 42 Vogsphere, 
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
    echo "Usage: $0 <github_repo_link> <42_vogsphere_repo_link> <dir_name>"
    echo "Example: $0 git@github.com:user/repo.git git@vogsphere.42.fr:repo.git my_project"
    exit 1
fi

GITHUB_REPO=$1
VOGSPHERE_REPO=$2
DIR_NAME=$3

echo -e "${GREEN}=== Starting Git Mirror Setup ===${NC}\n"

# Step 1: Clone the GitHub repository
echo -e "${YELLOW}[1/10] Cloning GitHub repository...${NC}"
git clone "$GITHUB_REPO" "$DIR_NAME"
echo -e "${GREEN}✓ Clone complete${NC}\n"

# Step 2: Change to the directory
echo -e "${YELLOW}[2/10] Changing to directory: $DIR_NAME${NC}"
cd "$DIR_NAME"
echo -e "${GREEN}✓ Changed directory${NC}\n"

# Step 3: Add 42 Vogsphere remote
echo -e "${YELLOW}[3/10] Adding 42 Vogsphere remote...${NC}"
git remote add vogsphere "$VOGSPHERE_REPO"
echo -e "${GREEN}✓ 42 Vogsphere remote added${NC}\n"

# Step 4: Fetch from 42 Vogsphere repo
echo -e "${YELLOW}[4/10] Fetching from 42 Vogsphere repo...${NC}"
git fetch vogsphere
echo -e "${GREEN}✓ Fetch complete${NC}\n"

# Step 5: Mirror push to 42 Vogsphere
echo -e "${YELLOW}[5/10] Mirroring repository to 42 Vogsphere...${NC}"
git push vogsphere --mirror
echo -e "${GREEN}✓ Mirror push complete${NC}\n"

# Step 6: Set origin URL to 42 Vogsphere
echo -e "${YELLOW}[6/10] Setting origin URL to 42 Vogsphere...${NC}"
git remote set-url origin "$VOGSPHERE_REPO"
echo -e "${GREEN}✓ Origin URL set to 42 Vogsphere${NC}\n"

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

# Step 8: Show remotes (should show origin and vogsphere)
echo -e "${YELLOW}[8/10] Current remotes:${NC}"
git remote -v
echo ""

# Step 9: Remove GitHub remote
echo -e "${YELLOW}[9/10] Removing GitHub remote...${NC}"
git remote remove vogsphere
echo -e "${GREEN}✓ GitHub remote removed${NC}\n"

echo -e "${YELLOW}Remotes after cleanup (should only show origin pointing to 42 Vogsphere):${NC}"
git remote -v
echo ""

# Step 10: Set upstream for master
echo -e "${YELLOW}[10/10] Setting upstream for master branch...${NC}"
git push --set-upstream origin master
echo -e "${GREEN}✓ Upstream set${NC}\n"

echo -e "${GREEN}=== Setup Complete ===${NC}"
echo -e "${GREEN}Your repository is now configured to work with 42 Vogsphere only.${NC}"
echo -e "${GREEN}GitHub content has been mirrored to 42 Vogsphere successfully.${NC}"
