#!/bin/bash

# Pre-deployment validation for LL97Plan.com
# Checks that all files are ready for GitHub and Vercel deployment

echo "🔍 LL97Plan.com Pre-Deployment Validation"
echo "========================================="
echo ""

# Check required files
echo "📁 Checking required files..."

REQUIRED_FILES=(
    "package.json"
    "server.js"
    "vercel.json"
    "README.md"
    ".gitignore"
    "public/index.html"
    "public/assets/js/calculator-fix.js"
    "public/assets/js/contact-form-fix.js"
    "public/assets/css/retrofit-styles-fix.css"
    "api/contact-api.js"
    "config/.env.example"
)

MISSING_FILES=()

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file (MISSING)"
        MISSING_FILES+=("$file")
    fi
done

echo ""

# Check if any files are missing
if [ ${#MISSING_FILES[@]} -gt 0 ]; then
    echo "❌ VALIDATION FAILED - Missing files:"
    for file in "${MISSING_FILES[@]}"; do
        echo "   • $file"
    done
    echo ""
    echo "Please ensure all required files are present before deployment."
    exit 1
fi

# Check package.json structure
echo "📦 Validating package.json..."
if node -e "
const pkg = require('./package.json');
const required = ['name', 'version', 'description', 'main', 'scripts', 'dependencies'];
const missing = required.filter(field => !pkg[field]);
if (missing.length > 0) {
    console.log('❌ Missing fields:', missing.join(', '));
    process.exit(1);
} else {
    console.log('✅ package.json structure valid');
}
"; then
    echo "✅ Package.json validated"
else
    echo "❌ Package.json validation failed"
    exit 1
fi

# Check Vercel configuration
echo ""
echo "🌐 Validating Vercel configuration..."
if node -e "
const vercel = require('./vercel.json');
if (!vercel.builds || !vercel.routes || !vercel.env) {
    console.log('❌ Invalid vercel.json structure');
    process.exit(1);
} else {
    console.log('✅ Vercel configuration valid');
}
" 2>/dev/null; then
    echo "✅ Vercel configuration validated"
else
    echo "❌ Vercel configuration validation failed"
    exit 1
fi

# Check file sizes
echo ""
echo "📊 Checking file sizes..."
find public/assets -name "*.js" -o -name "*.css" | while read file; do
    size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    if [ "$size" -gt 1048576 ]; then  # 1MB
        echo "⚠️  Large file: $file ($(echo $size | awk '{print int($1/1024)}')KB)"
    else
        echo "✅ $file ($(echo $size | awk '{print int($1/1024)}')KB)"
    fi
done

echo ""
echo "🎯 VALIDATION SUMMARY"
echo "===================="
echo ""
echo "✅ All required files present"
echo "✅ Package.json structure valid"
echo "✅ Vercel configuration valid"
echo "✅ File sizes acceptable"
echo ""
echo "🚀 READY FOR DEPLOYMENT!"
echo ""
echo "Next steps:"
echo "1. Run: ./deploy-to-github-vercel.sh"
echo "2. Configure environment variables in Vercel"
echo "3. Test the live deployment"
echo ""
echo "🎉 Your LL97Plan.com platform is ready to go live!"
