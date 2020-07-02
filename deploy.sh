#!/bin/sh

project_root=$(dirname "$(realpath "$0")")
# shellcheck source=/dev/null
echo "$project_root"


checkDependencies() {
    mainShellPID="$$"
    printf "git\ncomposer\nnpm" | while IFS= read -r program; do
        if ! [ -x "$(command -v "$program")" ]; then
            echo "Error: $program is not installed." >&2
            kill -9 "$mainShellPID" 
        fi
    done
}

checkDependencies

git remote update
git pull
npm install
npm run build
cp "$project_root/src/api/.env.example" "$project_root/src/api/.env"
mkdir -p "$project_root/dist/api"
cp "$project_root/src/api/movies.php" "$project_root/dist/api"
cp "$project_root/src/api/subtitles.php" "$project_root/dist/api"
cd "$project_root/src/api" || exit 1
composer install

echo ""
echo "Don't forget to add your OMDb API key and User Agent for opensubtitles.org to $project_root/src/api/.env"
