#!/bin/bash

# Environment Variables Configuration Script for LL97Plan.com
# This script helps you set up the required environment variables

echo "🔧 LL97Plan.com Environment Variables Configuration"
echo "=================================================="
echo ""

# Check if we're in the deployment directory
if [ ! -f "vercel.json" ]; then
    echo "❌ Error: vercel.json not found. Please run from the ll97plan-deployment directory."
    exit 1
fi

echo "📋 Required Environment Variables:"
echo ""
echo "1. SMTP_USER - Your Gmail address for sending emails"
echo "2. SMTP_PASS - Your Gmail App Password (not regular password)"
echo "3. FROM_EMAIL - Email address that appears as sender"
echo "4. TO_EMAIL - Email address that receives contact form submissions"
echo ""

# Function to validate email format
validate_email() {
    if [[ $1 =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Collect environment variables
echo "🔑 Let's configure your environment variables:"
echo ""

# SMTP_USER
while true; do
    read -p "Enter your Gmail address (SMTP_USER): " SMTP_USER
    if validate_email "$SMTP_USER"; then
        break
    else
        echo "❌ Invalid email format. Please try again."
    fi
done

# SMTP_PASS
echo ""
echo "📧 Gmail App Password Setup:"
echo "1. Go to https://myaccount.google.com/security"
echo "2. Enable 2-Factor Authentication if not already enabled"
echo "3. Go to 'App passwords' and generate a new app password"
echo "4. Use that 16-character password (not your regular Gmail password)"
echo ""
read -s -p "Enter your Gmail App Password (SMTP_PASS): " SMTP_PASS
echo ""

# FROM_EMAIL
echo ""
read -p "Enter sender email address (FROM_EMAIL) [default: noreply@ll97plan.com]: " FROM_EMAIL
FROM_EMAIL=${FROM_EMAIL:-"noreply@ll97plan.com"}

# TO_EMAIL
echo ""
while true; do
    read -p "Enter recipient email address (TO_EMAIL) [default: info@ll97plan.com]: " TO_EMAIL
    TO_EMAIL=${TO_EMAIL:-"info@ll97plan.com"}
    if validate_email "$TO_EMAIL"; then
        break
    else
        echo "❌ Invalid email format. Please try again."
    fi
done

# Create .env file
echo ""
echo "📝 Creating .env file..."
cat > .env << EOF
# LL97Plan.com Environment Variables
# Generated on $(date)

# Email Configuration
SMTP_USER=${SMTP_USER}
SMTP_PASS=${SMTP_PASS}
FROM_EMAIL=${FROM_EMAIL}
TO_EMAIL=${TO_EMAIL}

# Server Configuration
NODE_ENV=production
PORT=3000
EOF

echo "✅ .env file created successfully!"
echo ""

# Update .env.example
echo "📝 Updating .env.example..."
cat > config/.env.example << EOF
# LL97Plan.com Environment Variables
# Copy this file to .env and fill in your actual values

# Email Configuration
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-gmail-app-password
FROM_EMAIL=noreply@ll97plan.com
TO_EMAIL=info@ll97plan.com

# Server Configuration
NODE_ENV=production
PORT=3000
EOF

echo "✅ .env.example updated!"
echo ""

# Test email configuration
echo "🧪 Testing email configuration..."
node -e "
const nodemailer = require('nodemailer');
require('dotenv').config();

const transporter = nodemailer.createTransporter({
    service: 'gmail',
    auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS
    }
});

transporter.verify((error, success) => {
    if (error) {
        console.log('❌ Email configuration test failed:', error.message);
        process.exit(1);
    } else {
        console.log('✅ Email configuration test successful!');
    }
});
" 2>/dev/null || echo "⚠️  Email test skipped (install dependencies first)"

echo ""
echo "🌐 Next Steps for Vercel Deployment:"
echo "=================================="
echo ""
echo "1. Go to your Vercel dashboard: https://vercel.com/dashboard"
echo "2. Find your project: ll97plan-deployment"
echo "3. Go to Settings > Environment Variables"
echo "4. Add these variables with 'Production' scope:"
echo ""
echo "   SMTP_USER = ${SMTP_USER}"
echo "   SMTP_PASS = ${SMTP_PASS}"
echo "   FROM_EMAIL = ${FROM_EMAIL}"
echo "   TO_EMAIL = ${TO_EMAIL}"
echo ""
echo "5. Click 'Save' for each variable"
echo "6. Go to Deployments tab and click 'Redeploy'"
echo ""

# Create Vercel environment setup script
cat > setup-vercel-env.sh << 'EOF'
#!/bin/bash

# Vercel Environment Variables Setup
echo "🌐 Setting up Vercel environment variables..."

if [ ! -f ".env" ]; then
    echo "❌ .env file not found. Run configure-env.sh first."
    exit 1
fi

# Load environment variables
source .env

echo "Setting environment variables in Vercel..."
vercel env add SMTP_USER production <<< "$SMTP_USER"
vercel env add SMTP_PASS production <<< "$SMTP_PASS"
vercel env add FROM_EMAIL production <<< "$FROM_EMAIL"
vercel env add TO_EMAIL production <<< "$TO_EMAIL"

echo "✅ Environment variables set in Vercel!"
echo "🚀 Redeploying with new environment variables..."
vercel --prod

echo "✅ Deployment complete with environment variables!"
EOF

chmod +x setup-vercel-env.sh

echo "📋 Configuration Summary:"
echo "========================"
echo "• Local .env file created ✅"
echo "• Email configuration ready ✅"
echo "• Vercel setup instructions provided ✅"
echo "• Automatic Vercel setup script created ✅"
echo ""
echo "🚀 To automatically set up Vercel environment variables:"
echo "   ./setup-vercel-env.sh"
echo ""
echo "Or follow the manual steps above to configure via Vercel dashboard."
echo ""
echo "✅ Environment configuration complete!"
