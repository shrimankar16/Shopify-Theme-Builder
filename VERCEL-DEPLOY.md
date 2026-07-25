# 🚀 Deploy to Vercel - Step by Step Guide

This guide walks you through deploying your AI Shopify Theme Builder to Vercel.

---

## 📋 Prerequisites

Before deploying, make sure you have:

- ✅ GitHub repository pushed (Done! ✓)
- ✅ InsForge database tables created
- ✅ All API keys ready:
  - InsForge URL and keys
  - Gemini API key
  - ImageKit endpoint (optional)
  - Stripe keys (optional)

---

## 🎯 Method 1: Deploy via Vercel Dashboard (Easiest)

### Step 1: Go to Vercel

1. Visit: https://vercel.com
2. Click **"Sign Up"** or **"Login"**
3. Sign in with **GitHub** (recommended)

### Step 2: Import Your Repository

1. Click **"Add New..."** → **"Project"**
2. You'll see "Import Git Repository"
3. Find: **shrimankar16/Shopify-Theme-Builder**
4. Click **"Import"**

### Step 3: Configure Project

**Framework Preset:** Next.js (auto-detected)

**Root Directory:** `./` (leave as default)

**Build Command:** `npm run build` (default)

**Output Directory:** `.next` (default)

**Install Command:** `npm install` (default)

### Step 4: Add Environment Variables

Click **"Environment Variables"** and add these:

#### Required Variables:

```
NEXT_PUBLIC_INSFORGE_URL=https://84j589yc.ap-southeast.insforge.app
NEXT_PUBLIC_INSFORGE_ANON_KEY=your-insforge-anon-key-here
INSFORGE_ADMIN_KEY=your-insforge-admin-key-here
AI_PROVIDER=gemini
AI_MODEL=gemini-3.6-flash
GEMINI_API_KEY=your-gemini-api-key-here
```

**Replace placeholders with your actual keys from `.env.local`**

#### Optional Variables:

```
NEXT_PUBLIC_IMAGEKIT_URL_ENDPOINT=https://ik.imagekit.io/your-id/
STRIPE_SECRET_KEY=your-stripe-secret-key-here
STRIPE_WEBHOOK_SECRET=
NEXT_PUBLIC_APP_URL=https://your-app-name.vercel.app
NEXT_PUBLIC_INSFORGE_EXPORTS_BUCKET=theme-exports
NEXT_PUBLIC_INSFORGE_THUMBNAILS_BUCKET=project-thumbnails
```

**Replace placeholders with your actual keys from `.env.local`**

**Important:** 
- For `NEXT_PUBLIC_APP_URL`, you can leave it blank initially
- After first deploy, come back and update it with your Vercel URL

### Step 5: Deploy

1. Click **"Deploy"**
2. Wait 2-3 minutes while Vercel builds your app
3. 🎉 You'll get a live URL like: `https://shopify-theme-builder-xyz.vercel.app`

---

## 🎯 Method 2: Deploy via Vercel CLI

### Step 1: Install Vercel CLI

```bash
npm install -g vercel
```

### Step 2: Login

```bash
vercel login
```

### Step 3: Deploy

```bash
cd "c:\Users\Shrijay\Desktop\ai-shopify-template-builder"
vercel
```

Follow the prompts:
- Link to existing project? **No**
- Project name? **shopify-theme-builder** (or your choice)
- Directory? **./** (just press Enter)

### Step 4: Add Environment Variables

```bash
vercel env add NEXT_PUBLIC_INSFORGE_URL
vercel env add NEXT_PUBLIC_INSFORGE_ANON_KEY
vercel env add INSFORGE_ADMIN_KEY
vercel env add AI_PROVIDER
vercel env add AI_MODEL
vercel env add GEMINI_API_KEY
```

Paste the values when prompted.

### Step 5: Deploy to Production

```bash
vercel --prod
```

---

## ⚙️ Post-Deployment Configuration

### 1. Update App URL

After first deploy:

1. Copy your Vercel URL (e.g., `https://shopify-theme-builder-xyz.vercel.app`)
2. Go to Vercel Dashboard → Your Project → Settings → Environment Variables
3. Update or add: `NEXT_PUBLIC_APP_URL=https://shopify-theme-builder-xyz.vercel.app`
4. Redeploy: **Deployments** → **...** → **Redeploy**

### 2. Configure Stripe Webhooks (If Using Billing)

1. Go to Stripe Dashboard: https://dashboard.stripe.com
2. Navigate to: **Developers** → **Webhooks**
3. Click **"Add endpoint"**
4. Endpoint URL: `https://your-vercel-url.vercel.app/api/billing/webhook`
5. Select events:
   - `checkout.session.completed`
   - `customer.subscription.created`
   - `customer.subscription.updated`
   - `customer.subscription.deleted`
   - `invoice.paid`
   - `invoice.payment_failed`
6. Copy the **Signing secret** (starts with `whsec_`)
7. Add to Vercel env vars: `STRIPE_WEBHOOK_SECRET=whsec_...`
8. Redeploy

### 3. Configure Google OAuth (InsForge Auth)

If using Google sign-in:

1. Go to: https://console.cloud.google.com
2. Navigate to: **APIs & Services** → **Credentials**
3. Edit your OAuth 2.0 Client
4. Add to **Authorized redirect URIs**:
   - `https://84j589yc.ap-southeast.insforge.app/auth/v1/callback`
   - `https://your-vercel-url.vercel.app/api/auth/callback`
5. Save

---

## 🔍 Verify Deployment

### 1. Check Build Logs

In Vercel Dashboard:
- Go to your project
- Click **"Deployments"**
- Click on the latest deployment
- Review **"Building"** logs for errors

### 2. Test Your App

Visit your Vercel URL and test:

1. ✅ Homepage loads
2. ✅ Sign in works
3. ✅ Can create a project
4. ✅ AI generation works
5. ✅ Export works (if configured)

### 3. Check Function Logs

In Vercel Dashboard:
- Go to **"Logs"** or **"Monitoring"**
- Check for runtime errors

---

## 🐛 Common Issues & Fixes

### Issue 1: Build Fails - "Module not found"

**Fix:** Check `package.json` has all dependencies:
```bash
npm install
git add package.json package-lock.json
git commit -m "Fix dependencies"
git push
```

### Issue 2: Environment Variables Not Working

**Fix:** 
1. Make sure `NEXT_PUBLIC_*` prefix is correct for client-side vars
2. Redeploy after adding env vars
3. Clear cache: **Settings** → **General** → **Clear Cache**

### Issue 3: Database Connection Fails

**Fix:**
1. Verify `NEXT_PUBLIC_INSFORGE_URL` is correct
2. Check InsForge allows connections from Vercel IPs
3. Verify database tables are created

### Issue 4: Gemini API Errors

**Fix:**
1. Verify `GEMINI_API_KEY` is correct
2. Check API key has quota remaining
3. Verify model name: `gemini-3.6-flash`

### Issue 5: 500 Internal Server Error

**Fix:**
1. Check Vercel function logs
2. Verify all required env vars are set
3. Check for missing database tables

---

## 🔄 Update Your Deployment

After making changes:

```bash
git add .
git commit -m "Your changes"
git push
```

Vercel auto-deploys on every push to `main` branch!

---

## 🌐 Custom Domain (Optional)

### Add Your Own Domain

1. Go to Vercel Dashboard → Your Project
2. Click **"Settings"** → **"Domains"**
3. Click **"Add"**
4. Enter your domain (e.g., `shopify-builder.yoursite.com`)
5. Follow DNS configuration instructions
6. Update `NEXT_PUBLIC_APP_URL` to your custom domain

---

## 📊 Monitor Your App

### Vercel Analytics

1. Go to your project in Vercel
2. Click **"Analytics"** tab
3. View:
   - Page views
   - Performance metrics
   - Error rates

### Function Logs

1. Click **"Logs"** tab
2. Filter by:
   - Time range
   - Status code
   - Function name

---

## 💰 Vercel Pricing

- **Free (Hobby):**
  - 100 GB bandwidth/month
  - Unlimited deployments
  - Automatic HTTPS
  - Good for personal projects

- **Pro ($20/month):**
  - 1 TB bandwidth
  - Analytics
  - Team collaboration
  - Commercial use allowed

For this project, **Free tier is fine** for development and testing!

---

## ✅ Deployment Checklist

Before going live:

- [ ] Database tables created in InsForge
- [ ] All environment variables added to Vercel
- [ ] `NEXT_PUBLIC_APP_URL` updated with Vercel URL
- [ ] Stripe webhooks configured (if using billing)
- [ ] Google OAuth redirect URIs updated
- [ ] Test sign-in functionality
- [ ] Test AI generation
- [ ] Test project creation
- [ ] Test export (if configured)
- [ ] Custom domain configured (optional)

---

## 🆘 Need Help?

- **Vercel Docs:** https://vercel.com/docs
- **Vercel Support:** https://vercel.com/support
- **Next.js Deployment:** https://nextjs.org/docs/deployment

---

## 🎉 You're Ready!

Your AI Shopify Theme Builder will be live at:
`https://your-project-name.vercel.app`

Share it with the world! 🚀
