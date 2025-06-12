#!/bin/bash

# Dry-run cleanup script for orphaned files in Undefined site
# This script will ONLY LIST what would be removed WITHOUT actually removing anything

echo "🔍 Analyzing orphaned files (DRY RUN - no files will be removed)..."

# Function to check if a path exists and would be removed
check_for_removal() {
    local path="$1"
    local description="$2"
    
    if [ -e "$path" ]; then
        echo "  🗑️  Would remove $description: $path"
        return 1
    else
        echo "  ✅ Already clean: $path"
        return 0
    fi
}

echo ""
echo "📂 Checking unused content directories..."

check_for_removal "src/content/authors" "authors content directory"
check_for_removal "src/content/blog" "blog content directory" 
check_for_removal "src/content/index-cards" "index-cards content directory"
check_for_removal "src/content/poetry" "poetry content directory"
check_for_removal "src/content/portfolio" "portfolio content directory"
check_for_removal "src/content/recipes" "recipes content directory"

echo ""
echo "📄 Checking unused page files..."

check_for_removal "src/pages/index-cards.astro" "index-cards page"
check_for_removal "src/pages/portfolio.astro" "portfolio page"
check_for_removal "src/pages/programs.astro" "programs page"
check_for_removal "src/pages/support.astro" "support page"
check_for_removal "src/pages/authors" "authors page directory"
check_for_removal "src/pages/blog" "blog page directory"
check_for_removal "src/pages/poetry" "poetry page directory"
check_for_removal "src/pages/recipes" "recipes page directory"

echo ""
echo "🎨 Checking unused component directories..."

check_for_removal "src/components/authors" "authors components"
check_for_removal "src/components/blog" "blog components"
check_for_removal "src/components/index-cards" "index-cards components"
check_for_removal "src/components/poetry" "poetry components"
check_for_removal "src/components/portfolio" "portfolio components"
check_for_removal "src/components/recipes" "recipes components"
check_for_removal "src/components/about" "about components"
check_for_removal "src/components/terms" "terms components"
check_for_removal "src/components/search" "search components"
check_for_removal "src/components/not-found" "not-found components"

echo ""
echo "🖼️ Checking unused asset directories..."

check_for_removal "src/assets/blog" "blog assets"
check_for_removal "src/assets/poetry" "poetry assets"
check_for_removal "src/assets/profile" "profile assets"
check_for_removal "src/assets/recipes" "recipes assets"
check_for_removal "src/assets/docs" "docs assets"

echo ""
echo "📄 Checking orphaned individual files..."

check_for_removal "src/assets/logo.svg" "unused logo.svg"

echo ""
echo "🔧 Checking potentially unused library functions..."

lib_files=(
    "src/lib/readingTime.ts"
    "src/lib/similarItems.ts" 
    "src/lib/taxonomyFilter.ts"
    "src/lib/taxonomyParser.ts"
    "src/lib/tocUtils.ts"
)

for lib_file in "${lib_files[@]}"; do
    if [ -f "$lib_file" ]; then
        lib_name=$(basename "$lib_file" .ts)
        usage_count=$(grep -r "from.*$lib_name" src/ 2>/dev/null | wc -l)
        import_count=$(grep -r "import.*$lib_name" src/ 2>/dev/null | wc -l)
        
        if [ "$usage_count" -eq 0 ] && [ "$import_count" -eq 0 ]; then
            echo "  🗑️  Would remove unused library: $lib_file"
        else
            echo "  ✅ Library in use: $lib_file (usage: $usage_count, imports: $import_count)"
        fi
    else
        echo "  ✅ Already clean: $lib_file"
    fi
done

echo ""
echo "📊 Analysis complete!"
echo ""
echo "To actually perform the cleanup, run:"
echo "  ./cleanup-orphaned-files.sh"
echo ""
echo "⚠️  Always backup your work before running the cleanup script!"
