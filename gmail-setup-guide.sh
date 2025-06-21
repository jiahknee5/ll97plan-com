#!/bin/bash

# Gmail App Password Setup Guide
# This script guides you through getting your Gmail App Password

echo "📧 Gmail App Password Setup for LL97Plan.com"
echo "============================================"
echo ""

echo "🔑 To enable email functionality, you need a Gmail App Password:"
echo ""
echo "📋 Step-by-step instructions:"
echo ""
echo "1. 🌐 Go to: https://myaccount.google.com/security"
echo ""
echo "2. 🔐 Enable 2-Factor Authentication (if not already enabled):"
echo "   • Click 'Signing in to Google'"
echo "   • Set up 2-Step Verification"
echo ""
echo "3. 🔑 Generate App Password:"
echo "   • Go back to Security settings"
echo "   • Click 'App passwords'"
echo "   • Select 'Mail' and 'Other (custom name)'"
echo "   • Enter 'LL97Plan Contact Form'"
echo "   • Click 'Generate'"
echo ""
echo "4. 📝 Copy the 16-character password (format: xxxx xxxx xxxx xxxx)"
echo ""
echo "5. ✏️ Update the .env file:"
echo "   • Open .env file in this directory"
echo "   • Replace 'your-16-character-app-password-here' with your actual app password"
echo "   • Save the file"
echo ""
echo "6. 🚀 Run the deployment:"
echo "   ./setup-vercel-env.sh"
echo ""

echo "📂 Current .env file status:"
if [ -f ".env" ]; then
    echo "✅ .env file exists"
    if grep -q "your-16-character-app-password-here" .env; then
        echo "⚠️  App password not yet configured (still has placeholder)"
    else
        echo "✅ App password appears to be configured"
    fi
else
    echo "❌ .env file missing"
fi

echo ""
echo "📝 Quick edit command:"
echo "   nano .env"
echo "   (or use your preferred editor)"
echo ""
echo "🎯 After updating .env with your app password, run:"
echo "   ./setup-vercel-env.sh"
echo ""
echo "This will automatically configure Vercel and deploy your site!"

# Function to open browser to Gmail security settings
if command -v open &> /dev/null; then
    echo ""
    read -p "Would you like to open Gmail security settings now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open "https://myaccount.google.com/security"
        echo "🌐 Gmail security page opened in your browser"
    fi
fi
