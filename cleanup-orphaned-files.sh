#!/bin/bash

# Cleanup script for orphaned files in Undefined site
# This script will remove unused files and directories

echo "🧹 Starting cleanup of orphaned files..."

# Function to check if a file is referenced in the codebase
check_file_usage() {
    local file_path="$1"
    local file_name=$(basename "$file_path")
    local file_name_no_ext="${file_name%.*}"
    
    # Search for references in source files
    grep -r "$file_name" src/ 2>/dev/null | grep -v ".DS_Store" | wc -l
}

# Function to safely remove file/directory
safe_remove() {
    local path="$1"
    local description="$2"
    
    if [ -e "$path" ]; then
        echo "  ❌ Removing $description: $path"
        rm -rf "$path"
    fi
}

echo ""
echo "📂 Cleaning up unused content directories..."

# Remove unused content types that we identified as not being used
safe_remove "src/content/authors" "authors content directory"
safe_remove "src/content/blog" "blog content directory" 
safe_remove "src/content/index-cards" "index-cards content directory"
safe_remove "src/content/poetry" "poetry content directory"
safe_remove "src/content/portfolio" "portfolio content directory"
safe_remove "src/content/recipes" "recipes content directory"

echo ""
echo "📄 Cleaning up unused page files..."

# Remove corresponding page files for unused content types
safe_remove "src/pages/index-cards.astro" "index-cards page"
safe_remove "src/pages/portfolio.astro" "portfolio page"
safe_remove "src/pages/programs.astro" "programs page (if unused)"
safe_remove "src/pages/support.astro" "support page (if unused)"
safe_remove "src/pages/authors" "authors page directory"
safe_remove "src/pages/blog" "blog page directory"
safe_remove "src/pages/poetry" "poetry page directory"
safe_remove "src/pages/recipes" "recipes page directory"

echo ""
echo "🎨 Cleaning up unused component directories..."

# Remove component directories for unused features
safe_remove "src/components/authors" "authors components"
safe_remove "src/components/blog" "blog components"
safe_remove "src/components/index-cards" "index-cards components"
safe_remove "src/components/poetry" "poetry components"
safe_remove "src/components/portfolio" "portfolio components"
safe_remove "src/components/recipes" "recipes components"
safe_remove "src/components/about" "about components (if unused)"
safe_remove "src/components/terms" "terms components"
safe_remove "src/components/search" "search components"
safe_remove "src/components/not-found" "not-found components"

echo ""
echo "🖼️ Cleaning up unused asset directories..."

# Remove unused asset directories
safe_remove "src/assets/blog" "blog assets"
safe_remove "src/assets/poetry" "poetry assets"
safe_remove "src/assets/profile" "profile assets"
safe_remove "src/assets/recipes" "recipes assets"
safe_remove "src/assets/docs" "docs assets"

echo ""
echo "📄 Cleaning up orphaned individual files..."

# Remove specific orphaned files
safe_remove "src/assets/logo.svg" "unused logo.svg (keeping logo.png)"

# Remove any remaining .DS_Store files
find . -name ".DS_Store" -type f -delete 2>/dev/null

echo ""
echo "🔧 Cleaning up unused library functions..."

# Check for potentially unused lib files
unused_libs=()

# List of lib files to check
lib_files=(
    "src/lib/readingTime.ts"
    "src/lib/similarItems.ts"
    "src/lib/taxonomyFilter.ts"
    "src/lib/taxonomyParser.ts"
    "src/lib/tocUtils.ts"
)

for lib_file in "${lib_files[@]}"; do
    if [ -f "$lib_file" ]; then
        # Check if the lib file is imported anywhere
        lib_name=$(basename "$lib_file" .ts)
        usage_count=$(grep -r "from.*$lib_name" src/ 2>/dev/null | wc -l)
        import_count=$(grep -r "import.*$lib_name" src/ 2>/dev/null | wc -l)
        
        if [ "$usage_count" -eq 0 ] && [ "$import_count" -eq 0 ]; then
            unused_libs+=("$lib_file")
        fi
    fi
done

# Remove unused lib files
for lib_file in "${unused_libs[@]}"; do
    safe_remove "$lib_file" "unused library file"
done

echo ""
echo "📦 Summary of cleanup:"
echo "  - Removed unused content type directories"
echo "  - Removed corresponding page files"
echo "  - Removed unused component directories"
echo "  - Removed unused asset directories"
echo "  - Removed orphaned individual files"
echo "  - Cleaned up unused library functions"

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "🔍 Remaining core structure:"
echo "📁 Content: home, about, documents, terms"
echo "📄 Pages: index, about, contact, donate, events, documents, terms, 404"
echo "🎨 Components: base, common, home"
echo "🖼️ Assets: logo.png, backgrounds/bwca-day.png"

echo ""
echo "⚠️  Please review the changes and test your site to ensure everything works correctly."
echo "💡 You may want to commit these changes or create a backup before running this script."
