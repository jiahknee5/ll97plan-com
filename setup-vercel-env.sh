#!/bin/bash

# Quick Vercel Environment Variables Setup
# This script automatically configures all required environment variables in Vercel

echo "🌐 Setting up Vercel Environment Variables"
echo "========================================="
echo ""

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "❌ .env file not found."
    echo "Please edit .env file with your actual email credentials first."
    echo ""
    echo "📝 Edit .env file:"
    echo "   SMTP_USER=your-email@gmail.com"
    echo "   SMTP_PASS=your-gmail-app-password"
    echo "   FROM_EMAIL=noreply@ll97plan.com"
    echo "   TO_EMAIL=info@ll97plan.com"
    echo ""
    echo "🔑 Get Gmail App Password:"
    echo "   1. Go to https://myaccount.google.com/security"
    echo "   2. Enable 2-Factor Authentication"
    echo "   3. Generate App Password"
    echo "   4. Use the 16-character password"
    exit 1
fi

# Load environment variables
echo "📋 Loading environment variables from .env file..."
source .env

# Validate required variables
if [ -z "$SMTP_USER" ] || [ -z "$SMTP_PASS" ] || [ -z "$FROM_EMAIL" ] || [ -z "$TO_EMAIL" ]; then
    echo "❌ Missing required environment variables in .env file."
    echo "Please ensure all variables are set: SMTP_USER, SMTP_PASS, FROM_EMAIL, TO_EMAIL"
    exit 1
fi

echo "✅ Environment variables loaded successfully"
echo ""

# Check if user is logged in to Vercel
echo "🔐 Checking Vercel authentication..."
if ! vercel whoami &> /dev/null; then
    echo "Please login to Vercel first:"
    vercel login
fi

echo "✅ Vercel authentication confirmed"
echo ""

# Set environment variables in Vercel
echo "🔧 Setting environment variables in Vercel..."
echo ""

echo "Setting SMTP_USER..."
echo "$SMTP_USER" | vercel env add SMTP_USER production

echo "Setting SMTP_PASS..."
echo "$SMTP_PASS" | vercel env add SMTP_PASS production

echo "Setting FROM_EMAIL..."
echo "$FROM_EMAIL" | vercel env add FROM_EMAIL production

echo "Setting TO_EMAIL..."
echo "$TO_EMAIL" | vercel env add TO_EMAIL production

echo ""
echo "✅ All environment variables set in Vercel!"
echo ""

# Redeploy with new environment variables
echo "🚀 Redeploying with new environment variables..."
vercel --prod --yes

echo ""
echo "🎉 DEPLOYMENT COMPLETE!"
echo "======================"
echo ""
echo "✅ Environment variables configured"
echo "✅ Application redeployed with email functionality"
echo "✅ Contact form will now send emails to: $TO_EMAIL"
echo ""
echo "🧪 Test your deployment:"
echo "1. Go to your live Vercel URL"
echo "2. Navigate to the contact form"
echo "3. Submit a test message"
echo "4. Check $TO_EMAIL for the message"
echo ""
echo "Your LL97Plan.com platform is now fully functional! 🎯"
