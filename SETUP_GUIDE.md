# Complete Setup Guide - AI Shopify Theme Builder

This guide will walk you through getting all necessary API keys and setting up the project.

---

## Quick Setup Checklist

- [ ] Install dependencies
- [ ] Get InsForge keys (Required)
- [ ] Get Gemini API key (Required)
- [ ] Get ImageKit endpoint (Optional but recommended)
- [ ] Get Stripe keys (Optional - for billing)
- [ ] Configure `.env.local`
- [ ] Run the development server

---

## 1. Install Dependencies

```bash
npm install
```

---

## 2. Get InsForge Keys (REQUIRED)

InsForge provides your database, authentication, and file storage.

### Steps:

1. **Visit InsForge Dashboard**
   - Go to: https://insforge.dev
   - Sign up or log in

2. **Create a New Project** (if you don't have one)
   - Click "New Project"
   - Name it: "AI Shopify Theme Builder" (or any name)
   - Choose a region (preferably closest to you)
   - Wait for project creation (~30 seconds)

3. **Get Your API Keys**
   - Go to Project Settings → API
   - Copy these values:
     - **Project URL** → Use for `NEXT_PUBLIC_INSFORGE_URL`
       - Format: `https://[project-id].[region].insforge.app`
     - **Anon/Public Key** → Use for `NEXT_PUBLIC_INSFORGE_ANON_KEY`
       - This is safe for browser use
     - **Service Role Key** → Use for `INSFORGE_ADMIN_KEY`
       - Keep this secret, server-only

4. **Add to `.env.local`:**
```bash
NEXT_PUBLIC_INSFORGE_URL=https://e8prgczp.us-east.insforge.app
NEXT_PUBLIC_INSFORGE_ANON_KEY=your-anon-key-here
INSFORGE_ADMIN_KEY=your-service-role-key-here
```

---

## 3. Get Gemini API Key (REQUIRED)

Gemini powers the AI generation for themes.

### Steps:

1. **Visit Google AI Studio**
   - Go to: https://aistudio.google.com/
   - Sign in with your Google account

2. **Create API Key**
   - Click "Get API key" in the top right
   - Click "Create API key"
   - Choose "Create API key in new project" (or use existing)
   - Copy the generated key

3. **Add to `.env.local`:**
```bash
AI_PROVIDER=gemini
AI_MODEL=gemini-2.5-flash
GEMINI_API_KEY=your-gemini-key-here
```

**Note:** Gemini 2.5 Flash is recommended for fast generation. You can also use:
- `gemini-2.0-flash` (faster, less capable)
- `gemini-2.5-pro` (slower, more capable)

---

## 4. Get ImageKit Endpoint (OPTIONAL but recommended)

ImageKit handles image generation, optimization, and transformations.

### Steps:

1. **Visit ImageKit**
   - Go to: https://imagekit.io/
   - Sign up for a free account

2. **Get Your URL Endpoint**
   - After signing in, go to Dashboard
   - Look for "URL-endpoint" in the Dashboard
   - Copy the URL (format: `https://ik.imagekit.io/your_imagekit_id`)

3. **Add to `.env.local`:**
```bash
NEXT_PUBLIC_IMAGEKIT_URL_ENDPOINT=https://ik.imagekit.io/your_imagekit_id
```

**Note:** Without ImageKit, image features will be limited. The free plan includes:
- 20 GB bandwidth/month
- 20 GB storage
- Image transformations and optimization

---

## 5. Get Stripe Keys (OPTIONAL - for billing)

Only needed if you want to test billing and payment features.

### Steps:

1. **Visit Stripe Dashboard**
   - Go to: https://dashboard.stripe.com/
   - Sign up or log in

2. **Get Test API Keys**
   - Go to Developers → API keys
   - Use **Test mode** for development
   - Copy:
     - **Secret key** (starts with `sk_test_`)
     - For webhook secret, see next step

3. **Set Up Webhook (for local testing)**
   - Install Stripe CLI: https://stripe.com/docs/stripe-cli
   - Run: `stripe listen --forward-to localhost:3000/api/webhooks/stripe`
   - Copy the webhook signing secret (starts with `whsec_`)

4. **Add to `.env.local`:**
```bash
STRIPE_SECRET_KEY=sk_test_your-stripe-key-here
STRIPE_WEBHOOK_SECRET=whsec_your-webhook-secret-here
```

---

## 6. Configure Your `.env.local`

Your final `.env.local` should look like this:

```bash
# InsForge (REQUIRED)
NEXT_PUBLIC_INSFORGE_URL=https://e8prgczp.us-east.insforge.app
NEXT_PUBLIC_INSFORGE_ANON_KEY=eyJhb...your-key
INSFORGE_ADMIN_KEY=eyJhb...your-admin-key

# AI Provider (REQUIRED)
AI_PROVIDER=gemini
AI_MODEL=gemini-2.5-flash
GEMINI_API_KEY=AIza...your-gemini-key

# ImageKit (OPTIONAL but recommended)
NEXT_PUBLIC_IMAGEKIT_URL_ENDPOINT=https://ik.imagekit.io/your_id

# Stripe (OPTIONAL)
STRIPE_SECRET_KEY=sk_test_...your-key
STRIPE_WEBHOOK_SECRET=whsec_...your-secret

# App Configuration
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_INSFORGE_EXPORTS_BUCKET=theme-exports
NEXT_PUBLIC_INSFORGE_THUMBNAILS_BUCKET=project-thumbnails
```

---

## 7. Run the Development Server

```bash
npm run dev
```

Then open: http://localhost:3000

---

## 8. Test the Setup

1. **Sign Up/Sign In**
   - Should work via InsForge authentication

2. **Create a Project**
   - Click "New Project"
   - Give it a name

3. **Test AI Generation**
   - Enter a prompt like: "Create a modern ecommerce store for organic skincare products"
   - Watch the AI generate the theme

4. **Test Image Generation** (if ImageKit is configured)
   - Try editing or generating images in the builder

5. **Test Export**
   - Export the theme as a ZIP file
   - Verify it downloads successfully

---

## Troubleshooting

### "Authentication error" or "Invalid API key"
- Double-check your InsForge keys in `.env.local`
- Make sure you copied the full keys without extra spaces
- Restart your dev server after changing `.env.local`

### "AI generation failed"
- Verify your Gemini API key is correct
- Check you have API quota remaining in Google AI Studio
- Try a simpler prompt first

### "Image operations not working"
- ImageKit is optional - the app will work without it
- If you want image features, verify your ImageKit endpoint is correct

### Changes not reflected
- Always restart the dev server after editing `.env.local`:
  ```bash
  # Press Ctrl+C to stop
  npm run dev
  ```

---

## Next Steps

Once your app is running:

1. Read [projectsetup.md](./projectsetup.md) for backend database setup
2. See [docs/billing-setup.md](./docs/billing-setup.md) for payment configuration
3. Check [docs/shopify-export-setup.md](./docs/shopify-export-setup.md) for export features
4. Review [AGENTS.md](./AGENTS.md) for development guidelines

---

## API Key Security Reminders

- ✅ `.env.local` is in `.gitignore` - never commit it
- ✅ Use test/development keys for local development
- ✅ `NEXT_PUBLIC_*` variables are safe for browser code
- ❌ Never expose `INSFORGE_ADMIN_KEY`, `GEMINI_API_KEY`, or `STRIPE_SECRET_KEY` to the client

---

## Cost Estimates (Free Tiers)

- **InsForge**: Free tier includes 500MB database, 1GB storage
- **Gemini**: Free tier includes 1,500 requests/day (Flash model)
- **ImageKit**: Free tier includes 20GB bandwidth/month
- **Stripe**: No cost for test mode

This should be sufficient for development and testing!
