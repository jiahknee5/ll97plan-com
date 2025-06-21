#!/bin/bash

# GitHub and Vercel Deployment Script for LL97Plan.com
# This script initializes Git, pushes to GitHub, and deploys to Vercel

echo "🚀 LL97Plan.com - GitHub & Vercel Deployment"
echo "============================================"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run from the deployment directory."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: Git is not installed. Please install Git first."
    exit 1
fi

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "⚠️  GitHub CLI not found. Installing..."
    brew install gh
fi

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "⚠️  Vercel CLI not found. Installing..."
    npm install -g vercel
fi

echo "📁 Preparing repository..."

# Initialize git repository
if [ ! -d ".git" ]; then
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

# Add all files
git add .

# Create initial commit
if git diff --cached --quiet; then
    echo "✅ No changes to commit (repository up to date)"
else
    git commit -m "Initial commit: LL97Plan.com with UAT fixes

- ✅ LL97 Calculator functionality fix
- ✅ Contact form email delivery system  
- ✅ Retrofit calculator UI improvements
- ✅ Vercel deployment configuration
- ✅ Professional landing page
- ✅ Mobile responsive design

Ready for production deployment"
    echo "✅ Initial commit created"
fi

echo ""
echo "🐙 Creating GitHub repository..."

# Create GitHub repository
REPO_NAME="ll97plan-com"
echo "Repository name: $REPO_NAME"

# Check if repository already exists
if gh repo view "$REPO_NAME" &> /dev/null; then
    echo "✅ Repository already exists on GitHub"
else
    echo "Creating new GitHub repository..."
    gh repo create "$REPO_NAME" --public --description "NYC Local Law 97 Compliance Platform - Professional building assessment and compliance tools" --add-readme=false
    echo "✅ GitHub repository created"
fi

# Add remote origin
if git remote get-url origin &> /dev/null; then
    echo "✅ Remote origin already configured"
else
    git remote add origin "https://github.com/$(gh api user --jq .login)/$REPO_NAME.git"
    echo "✅ Remote origin added"
fi

# Push to GitHub
echo "📤 Pushing to GitHub..."
git branch -M main
git push -u origin main
echo "✅ Code pushed to GitHub"

echo ""
echo "🌐 Deploying to Vercel..."

# Login to Vercel (if not already logged in)
vercel whoami &> /dev/null || vercel login

# Deploy to Vercel
vercel --prod --confirm

echo ""
echo "🎯 DEPLOYMENT COMPLETE!"
echo "======================"
echo ""
echo "📋 Deployment Summary:"
echo "• 🐙 GitHub Repository: https://github.com/$(gh api user --jq .login)/$REPO_NAME"
echo "• 🌐 Vercel Deployment: Check your Vercel dashboard for the live URL"
echo "• ✅ All UAT fixes deployed and ready"
echo ""
echo "🔧 Next Steps:"
echo "1. Configure environment variables in Vercel dashboard:"
echo "   - SMTP_USER (your email)"
echo "   - SMTP_PASS (your app password)"  
echo "   - FROM_EMAIL (noreply@ll97plan.com)"
echo "   - TO_EMAIL (info@ll97plan.com)"
echo ""
echo "2. Test the live deployment:"
echo "   - LL97 Calculator functionality"
echo "   - Contact form email delivery"
echo "   - Retrofit calculator UI"
echo ""
echo "🎉 Your LL97Plan.com platform is now live!"
