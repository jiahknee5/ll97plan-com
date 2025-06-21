#!/bin/bash

# Microsoft/Outlook App Password Setup Guide for LL97Plan.com
# This script guides you through getting your Microsoft App Password

echo "📧 Microsoft Email Setup for LL97Plan.com"
echo "========================================="
echo ""

echo "🔑 To enable contact form functionality with info@ll97plan.com:"
echo ""
echo "📋 Step-by-step instructions:"
echo ""
echo "1. 🌐 Go to: https://account.microsoft.com/security"
echo ""
echo "2. 🔐 Enable Multi-Factor Authentication (if not already enabled):"
echo "   • Sign in to your Microsoft account"
echo "   • Go to Security > Advanced security options"
echo "   • Set up two-step verification"
echo ""
echo "3. 🔑 Generate App Password:"
echo "   • Go to Security > Advanced security options"
echo "   • Under 'App passwords', click 'Create a new app password'"
echo "   • Enter name: 'LL97Plan Contact Form'"
echo "   • Copy the generated password"
echo ""
echo "4. 📝 Update the .env file:"
echo "   • Open .env file in this directory"
echo "   • Replace 'your-microsoft-app-password-here' with your app password"
echo "   • Save the file"
echo ""
echo "5. 🚀 Deploy with updated configuration:"
echo "   ./setup-vercel-env.sh"
echo ""

echo "📂 Current .env file status:"
if [ -f ".env" ]; then
    echo "✅ .env file exists"
    echo "✅ Configured for Microsoft email (info@ll97plan.com)"
    if grep -q "your-microsoft-app-password-here" .env; then
        echo "⚠️  App password not yet configured (still has placeholder)"
    else
        echo "✅ App password appears to be configured"
    fi
else
    echo "❌ .env file missing"
fi

echo ""
echo "⚙️ Email Configuration:"
echo "• SMTP Server: smtp-mail.outlook.com"
echo "• Port: 587"
echo "• Security: STARTTLS"
echo "• From Email: info@ll97plan.com"
echo "• To Email: info@ll97plan.com"
echo ""

echo "📝 Quick edit command:"
echo "   nano .env"
echo "   (or use your preferred editor)"
echo ""
echo "🎯 After updating .env with your Microsoft app password, run:"
echo "   ./setup-vercel-env.sh"
echo ""
echo "This will configure Vercel and deploy your site with Microsoft email!"

# Function to open browser to Microsoft security settings
if command -v open &> /dev/null; then
    echo ""
    read -p "Would you like to open Microsoft security settings now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open "https://account.microsoft.com/security"
        echo "🌐 Microsoft security page opened in your browser"
    fi
fi

echo ""
echo "💡 Microsoft Email Benefits:"
echo "• Professional sender address (info@ll97plan.com)"
echo "• Matches your domain name"
echo "• More trustworthy for business communications"
echo "• All contact form emails go to your business email"
