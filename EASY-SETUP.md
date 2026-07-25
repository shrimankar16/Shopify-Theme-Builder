# 🚨 EASY DATABASE SETUP - Try This Method

Since the SQL Editor isn't working, let's use the **InsForge CLI** instead.

---

## Method 1: Using InsForge CLI (Recommended)

### Step 1: Install InsForge CLI

Open your terminal (CMD or PowerShell) and run:

```bash
npm install -g @insforge/cli
```

### Step 2: Login to InsForge

```bash
npx @insforge/cli login
```

This will open your browser - log in with your InsForge account.

### Step 3: Link Your Project

```bash
cd "c:\Users\Shrijay\Desktop\ai-shopify-template-builder"
npx @insforge/cli link
```

- When prompted, select your project (the one with `84j589yc`)
- Or paste the project ref: `84j589yc`

### Step 4: Run the Database Setup

```bash
npx @insforge/cli db execute -f COMPLETE-DATABASE-SETUP.sql
```

This will run the SQL file directly against your database!

### Step 5: Verify

```bash
npx @insforge/cli db query "SELECT table_name FROM information_schema.tables WHERE table_schema='public' ORDER BY table_name;"
```

You should see your tables listed!

---

## Method 2: Manual Table Creation via REST API

If CLI doesn't work, we can create tables using the API directly.

Run this in your terminal from the project folder:

```bash
npm run setup-db
```

I'll create a Node.js script that does this for you.

---

## Method 3: Contact InsForge Support

If neither method works:

1. The InsForge SQL Editor might have restrictions
2. Your account might need permissions
3. Contact InsForge support: https://insforge.dev/support

Share this error with them:
> "SQL Editor shows no errors but doesn't create tables when I run CREATE TABLE statements"

---

## 🤔 Why Isn't SQL Editor Working?

Possible reasons:

1. **Wrong Mode**: You might be in a read-only view
2. **Permissions**: Your account might not have admin rights
3. **UI Issue**: The editor might not be showing errors
4. **Project Type**: Some project types have restrictions

---

## ✅ Try CLI First

The CLI is the most reliable method. Let me know if you get any errors and I'll help you troubleshoot!

```bash
# Quick setup commands (copy all at once):
npm install -g @insforge/cli
npx @insforge/cli login
cd "c:\Users\Shrijay\Desktop\ai-shopify-template-builder"
npx @insforge/cli link
npx @insforge/cli db execute -f COMPLETE-DATABASE-SETUP.sql
```

After running these, refresh your app at http://localhost:3000 and try again!
