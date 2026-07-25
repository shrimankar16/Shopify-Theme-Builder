# Database Setup Instructions

## ⚠️ The Error You're Seeing

**"relation 'public.subscriptions' does not exist"**

This means the database tables haven't been created yet in your InsForge project.

---

## 🔧 How to Fix It (5 Minutes)

### Step 1: Go to InsForge SQL Editor

1. Open your browser and go to: **https://insforge.dev**
2. Click on your project: **AI Shopify Theme Builder** (or whatever you named it)
3. In the left sidebar, click **"SQL Editor"** or **"Database"**

### Step 2: Copy the SQL Setup Script

1. Open the file I created: **`setup-database.sql`** (in your project root)
2. Copy ALL the contents of that file

### Step 3: Run the SQL

1. Paste the SQL into the InsForge SQL Editor
2. Click **"Run"** or **"Execute"** button
3. Wait for it to complete (should take ~5 seconds)
4. You should see: **"Database setup complete!"**

### Step 4: Refresh Your App

1. Go back to your app at: http://localhost:3000
2. Refresh the page (F5 or Ctrl+R)
3. The error should be gone! ✅

---

## 📋 What This Creates

The SQL script sets up 4 tables:

1. **`subscriptions`** - User billing plans (Free/Monthly/Yearly)
2. **`projects`** - Your Shopify theme projects
3. **`pages`** - Individual pages within projects (Home, Product, etc.)
4. **`theme_exports`** - Downloaded ZIP files

Plus all the security policies so users can only see their own data.

---

## 🎯 Alternative: Use InsForge CLI (Advanced)

If you prefer the command line:

```bash
# Install InsForge CLI (if not installed)
npm install -g @insforge/cli

# Login
insforge login

# Link to your project
insforge link

# Run the SQL file
insforge db execute --file setup-database.sql
```

---

## ✅ Verification

After running the SQL, try these in the SQL Editor:

```sql
-- Check tables were created
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('subscriptions', 'projects', 'pages', 'theme_exports');
```

You should see all 4 tables listed.

---

## 🚨 If You Still Get Errors

1. Make sure you're running the SQL in the **correct InsForge project**
2. Verify your `.env.local` has the correct `NEXT_PUBLIC_INSFORGE_URL`
3. Restart your dev server after database changes:
   ```bash
   npm run dev
   ```

---

## 📚 What's Next

After the database is set up:

1. ✅ Sign in to the app
2. ✅ Create your first project
3. ✅ Generate a Shopify theme with AI
4. ✅ Export and download your theme

Need help? Check the other docs:
- [projectsetup.md](./projectsetup.md) - Full setup guide
- [docs/billing-setup.md](./docs/billing-setup.md) - Stripe payment setup
- [docs/shopify-export-setup.md](./docs/shopify-export-setup.md) - Export features
