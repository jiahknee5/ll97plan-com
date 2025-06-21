# LL97Plan.com Production Deployment Instructions

## 🚀 Quick Deployment (15 minutes)

### Step 1: Upload Files to Your Server
```bash
# Upload the assets to your web server
scp -r assets/ user@your-server:/path/to/website/
scp -r api/ user@your-server:/path/to/website/
```

### Step 2: Update Your HTML Pages

#### LL97 Calculator Page (`/ll97-calculator`):
1. Add to `<head>`: `<script src="/assets/js/calculator-fix.js"></script>`
2. Update form field names to match: `building-type`, `square-footage`, `year-built`, `current-usage`
3. Ensure form has `id="ll97-calculator-form"`

#### Contact Page (`/contact`):
1. Add to `<head>`: `<script src="/assets/js/contact-form-fix.js"></script>`
2. Update form field names to match template
3. Remove office address and business hours
4. Keep only: Email: info@ll97plan.com, Phone: 917-674-5720

#### Retrofit Calculator Page (`/retrofit-calculator`):
1. Add to `<head>`: `<link rel="stylesheet" href="/assets/css/retrofit-styles-fix.css">`

### Step 3: Backend API Setup
1. Install dependencies: `npm install`
2. Configure environment: Copy `.env.example` to `.env` and set email credentials
3. Add API endpoint to your server: `app.use('/api', require('./api/contact-api'));`

### Step 4: Test Each Fix
1. Test LL97 calculator with sample data
2. Submit contact form and verify email delivery
3. Check retrofit calculator visual improvements

## 🧪 Testing Checklist
- [ ] LL97 calculator shows results (not empty page)
- [ ] Contact form sends emails to info@ll97plan.com
- [ ] Retrofit calculator has improved styling
- [ ] No JavaScript console errors
- [ ] Mobile responsiveness works

## 🎯 Success Criteria
All 3 critical UAT issues should be resolved after deployment.
