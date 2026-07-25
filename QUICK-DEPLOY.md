# ⚡ Quick Vercel Deploy - 5 Minutes

Follow these exact steps to deploy to Vercel in 5 minutes.

---

## 🚀 Fastest Method (Browser)

### 1. Click This Link
https://vercel.com/new/clone?repository-url=https://github.com/shrimankar16/Shopify-Theme-Builder

### 2. Sign In
- Click **"Sign in with GitHub"**

### 3. Configure Repository
- Repository Name: **Shopify-Theme-Builder** (or leave default)
- Click **"Create"**

### 4. Add Environment Variables

**Click "Environment Variables" and paste these:**

```env
NEXT_PUBLIC_INSFORGE_URL=https://84j589yc.ap-southeast.insforge.app
NEXT_PUBLIC_INSFORGE_ANON_KEY=your-insforge-anon-key-here
INSFORGE_ADMIN_KEY=your-insforge-admin-key-here
AI_PROVIDER=gemini
AI_MODEL=gemini-3.6-flash
GEMINI_API_KEY=your-gemini-api-key-here
NEXT_PUBLIC_IMAGEKIT_URL_ENDPOINT=https://ik.imagekit.io/your-id/
STRIPE_SECRET_KEY=your-stripe-secret-key-here
NEXT_PUBLIC_INSFORGE_EXPORTS_BUCKET=theme-exports
NEXT_PUBLIC_INSFORGE_THUMBNAILS_BUCKET=project-thumbnails
```

**Replace the placeholder values with your actual keys from `.env.local`**
1. In the "Name" field, type the variable name (e.g., `NEXT_PUBLIC_INSFORGE_URL`)
2. In the "Value" field, paste the value (e.g., `https://84j589yc...`)
3. Click "Add"
4. Repeat for all variables

### 5. Deploy
- Click **"Deploy"**
- Wait 2-3 minutes ⏳
- 🎉 Done!

### 6. Get Your URL
- Copy your URL: `https://shopify-theme-builder-xyz.vercel.app`
- Visit it and test!

---

## 🔄 Update App URL (Important!)

After first deploy:

1. Go to: https://vercel.com/dashboard
2. Click your project
3. Go to **Settings** → **Environment Variables**
4. Find `NEXT_PUBLIC_APP_URL` (or add it if missing)
5. Set value to: `https://your-vercel-url.vercel.app`
6. Go to **Deployments** tab
7. Click **"Redeploy"** on the latest deployment

---

## ✅ Verify It Works

Visit your Vercel URL and test:

1. Homepage loads ✓
2. Click "Sign in"
3. Sign in with Google
4. Create a new project
5. Enter a prompt and generate a theme
6. Success! 🎉

---

## 🐛 If Something Breaks

### Error: "Environment variable not found"
- Go back to Settings → Environment Variables
- Make sure ALL variables from step 4 are added
- Redeploy

### Error: "Database table not found"
- You still need to run the database setup SQL
- See: `COMPLETE-DATABASE-SETUP.sql`
- Run it in InsForge SQL Editor

### Error: "Gemini API error"
- Check your Gemini API key is correct
- Verify it has quota remaining
- Go to: https://aistudio.google.com/apikey

---

## 📱 Share Your App

Your app is live at:
```
https://your-project.vercel.app
```

Share it on:
- Twitter/X
- LinkedIn
- Product Hunt
- Reddit

---

## 💡 Pro Tips

1. **Custom Domain:**
   - Settings → Domains → Add your domain

2. **Auto-deploy on Push:**
   - Every git push to `main` auto-deploys!
   - Make changes → `git push` → Vercel deploys automatically

3. **Preview Deployments:**
   - Create a new branch → Push → Get preview URL
   - Test before merging to main

4. **Monitor Performance:**
   - Check the "Analytics" tab in Vercel
   - See page views, performance, errors

---

That's it! Your app is deployed! 🚀
