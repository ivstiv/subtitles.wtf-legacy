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
"$project_root/src/api/composer install"

echo "Don't forget to add your OMDb API key to $project_root/src/api/.env"
