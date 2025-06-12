#!/bin/bash

echo "🧹 Cleanup Script for Undefined Site"
echo "===================================="
echo ""
echo "This script will help you remove orphaned/unused files from your project."
echo "Based on your current site structure, the following appear to be unused:"
echo ""

# List of directories/files to potentially remove
declare -a unused_items=(
    "src/content/authors|Authors content directory"
    "src/content/blog|Blog content directory"  
    "src/content/index-cards|Index cards content directory"
    "src/content/poetry|Poetry content directory"
    "src/content/recipes|Recipes content directory"
    "src/content/portfolio|Portfolio content directory"
    "src/pages/blog|Blog pages directory"
    "src/pages/poetry|Poetry pages directory"
    "src/pages/recipes|Recipes pages directory" 
    "src/pages/authors|Authors pages directory"
    "src/pages/index-cards.astro|Index cards page"
    "src/pages/portfolio.astro|Portfolio page"
    "src/pages/programs.astro|Programs page"
    "src/pages/support.astro|Support page"
    "src/components/authors|Authors components"
    "src/components/blog|Blog components"
    "src/components/index-cards|Index cards components"
    "src/components/poetry|Poetry components"
    "src/components/recipes|Recipes components"
    "src/components/portfolio|Portfolio components"
    "src/assets/blog|Blog assets"
    "src/assets/poetry|Poetry assets"
    "src/assets/profile|Profile assets"
    "src/assets/recipes|Recipes assets"
    "src/assets/docs|Docs assets"
    "src/assets/logo.svg|Unused logo.svg file"
)

removed_count=0
total_count=${#unused_items[@]}

for item in "${unused_items[@]}"; do
    IFS='|' read -r path description <<< "$item"
    
    if [ -e "$path" ]; then
        echo "📁 Found: $description ($path)"
        read -p "   Remove this item? [y/N]: " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "   ❌ Removing: $path"
            rm -rf "$path"
            ((removed_count++))
        else
            echo "   ⏭️  Skipping: $path"
        fi
        echo
    fi
done

echo "✅ Cleanup complete!"
echo "📊 Removed $removed_count out of $total_count potential items"
echo ""
echo "🔍 Remaining core structure:"
echo "   📁 Content: home, about, documents, terms"
echo "   📄 Pages: index, about, contact, donate, events, documents, terms, 404" 
echo "   🎨 Components: base, common, home"
echo "   🖼️ Assets: logo.png, backgrounds/"
echo ""
echo "⚠️  Please test your site to ensure everything works correctly!"
