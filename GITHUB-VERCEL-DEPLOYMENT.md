# 🚀 GitHub & Vercel Deployment Guide

## Overview
This guide will help you deploy LL97Plan.com to GitHub and Vercel with all UAT fixes included.

## ✅ Pre-Deployment Checklist

### System Requirements
- Git installed
- Node.js 16+ installed
- GitHub CLI (will be installed automatically)
- Vercel CLI (will be installed automatically)

### Required Files (All Present ✅)
- `package.json` - Project configuration
- `server.js` - Express server
- `vercel.json` - Vercel deployment config
- `public/` - Static assets and pages
- `api/` - Backend API endpoints
- `README.md` - Project documentation

## 🎯 Deployment Steps

### Option 1: Automated Deployment (Recommended)
```bash
# Run the automated deployment script
./deploy-to-github-vercel.sh
```

### Option 2: Manual Deployment
```bash
# 1. Initialize Git repository
git init
git add .
git commit -m "Initial commit: LL97Plan.com production ready"

# 2. Create GitHub repository
gh repo create ll97plan-com --public --description "NYC Local Law 97 Compliance Platform"

# 3. Push to GitHub
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/ll97plan-com.git
git push -u origin main

# 4. Deploy to Vercel
vercel --prod
```

## ⚙️ Environment Configuration

### Required Environment Variables in Vercel
```env
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
FROM_EMAIL=noreply@ll97plan.com
TO_EMAIL=info@ll97plan.com
```

### How to Set Environment Variables in Vercel:
1. Go to Vercel Dashboard
2. Select your project
3. Go to Settings > Environment Variables
4. Add each variable with Production scope

## 🧪 Post-Deployment Testing

### Test Checklist
- [ ] Homepage loads correctly
- [ ] LL97 Calculator shows results (not empty page)
- [ ] Contact form sends emails to info@ll97plan.com
- [ ] Retrofit calculator has improved styling
- [ ] Mobile responsiveness works
- [ ] All pages load without errors

### Test URLs
- Homepage: `https://your-domain.vercel.app/`
- LL97 Calculator: `https://your-domain.vercel.app/pages/ll97-calculator-update.html`
- Contact Form: `https://your-domain.vercel.app/pages/contact-page-update.html`
- Retrofit Calculator: `https://your-domain.vercel.app/pages/retrofit-calculator-update.html`

## 📧 Email Configuration

### Gmail Setup (Recommended)
1. Enable 2-factor authentication
2. Generate an App Password
3. Use the App Password for SMTP_PASS

### Email Test
```bash
# Test email functionality
curl -X POST https://your-domain.vercel.app/api/contact \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","message":"Test message"}'
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Email Not Sending
- Check environment variables are set correctly
- Verify Gmail App Password is working
- Check Vercel function logs

#### 2. Static Files Not Loading
- Ensure files are in `public/` directory
- Check Vercel routing configuration
- Verify file paths in HTML

#### 3. API Endpoints Not Working
- Check `server.js` is properly configured
- Verify API routes in `vercel.json`
- Check function timeout settings

### Debugging Commands
```bash
# Check Vercel logs
vercel logs

# Test local deployment
npm run dev

# Validate deployment package
./validate-deployment.sh
```

## 🎉 Success Metrics

After successful deployment, you should have:
- ✅ Professional LL97Plan.com website live
- ✅ Functional LL97 calculator
- ✅ Working contact form with email delivery
- ✅ Improved retrofit calculator UI
- ✅ Mobile-responsive design
- ✅ All UAT issues resolved

## 📞 Support

For issues or questions:
- Email: info@ll97plan.com
- Phone: 917-674-5720

## 🚀 Go Live Checklist

1. [ ] Run `./validate-deployment.sh` - All checks pass
2. [ ] Run `./deploy-to-github-vercel.sh` - Deployment complete
3. [ ] Configure environment variables in Vercel
4. [ ] Test all functionality on live site
5. [ ] Update DNS if using custom domain
6. [ ] Monitor for 24 hours post-deployment

**Your LL97Plan.com platform is ready for production!**
