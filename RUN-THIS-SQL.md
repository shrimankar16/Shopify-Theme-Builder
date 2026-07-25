# 🚨 FIX THE DATABASE ERROR - FOLLOW THESE EXACT STEPS

## The Problem
Your app shows: **"relation 'public.projects' does not exist"**

This means the database tables aren't created yet.

---

## ✅ THE FIX (Copy & Paste - 2 Minutes)

### Step 1: Open InsForge SQL Editor

1. Go to: **https://insforge.dev**
2. Log in
3. Click on your project (the one with URL: `84j589yc.ap-southeast.insforge.app`)
4. Look in the **left sidebar**
5. Click: **"SQL Editor"** (or "Database" → "SQL Editor")

### Step 2: Copy the SQL Script

1. Open the file: **`setup-database.sql`** (in this project folder)
2. Press `Ctrl+A` to select ALL
3. Press `Ctrl+C` to copy

### Step 3: Paste and Run

1. Go back to InsForge SQL Editor in your browser
2. Click in the big text box
3. Press `Ctrl+V` to paste
4. Click the **"RUN"** or **"Execute"** button (usually blue button)
5. Wait 3-5 seconds

### Step 4: Check for Success

You should see at the bottom:
```
✓ Database setup complete! All tables created.
```

### Step 5: Refresh Your App

1. Go to: http://localhost:3000
2. Press `F5` or `Ctrl+R` to refresh
3. Error should be GONE! ✅

---

## 🎯 What If I Can't Find SQL Editor?

### Location varies by InsForge version:

**Option A: Left Sidebar**
- Look for: "SQL Editor" or "Database" → "SQL Editor"

**Option B: Top Navigation**
- Click "Database" tab
- Then look for "SQL Editor" or "Query Editor"

**Option C: Settings**
- Go to "Project Settings"
- Look for "Database" or "SQL" section

---

## 📋 What Tables Get Created

This SQL creates 5 essential tables:

1. ✅ `subscriptions` - User billing (Free/Pro plans)
2. ✅ `projects` - Your Shopify theme projects
3. ✅ `project_pages` - Pages in each project (Home, Product, etc.)
4. ✅ `project_themes` - Theme colors and fonts
5. ✅ `theme_exports` - Downloaded ZIP files

---

## ⚠️ Still Not Working?

### Common Issues:

**1. Wrong Project**
- Make sure you're in the project with URL: `84j589yc.ap-southeast.insforge.app`
- Check your `.env.local` file matches this URL

**2. Didn't Copy All SQL**
- The SQL file is ~200 lines
- You MUST copy EVERYTHING from top to bottom
- Don't run it in parts - run it all at once

**3. Permission Error**
- You need admin/owner access to your InsForge project
- If you get permission errors, you might need to:
  - Be the project owner
  - Or run: `insforge login` in terminal first

**4. Auth Error in SQL**
- If you see "auth.uid() not found", it means:
  - You're running in wrong mode
  - Try running from InsForge dashboard instead of CLI

---

## 🔄 Alternative: Use CLI (Advanced)

If the dashboard doesn't work, try command line:

```bash
# Install InsForge CLI
npm install -g @insforge/cli

# Login
insforge login

# Link to your project
insforge link --project-ref 84j589yc

# Run the SQL file
insforge db execute --file setup-database.sql
```

---

## 📸 Screenshot Guide

### What the SQL Editor looks like:

```
┌────────────────────────────────────────┐
│  InsForge - Your Project               │
├────────────────────────────────────────┤
│ [Sidebar]        [Main Area]           │
│                                         │
│ Dashboard        ┌───────────────────┐ │
│ Database         │ SQL Query Editor  │ │
│ → SQL Editor ← ← │                   │ │
│ Storage          │ [Paste SQL here]  │ │
│ Auth             │                   │ │
│ Settings         │                   │ │
│                  └───────────────────┘ │
│                  [▶ RUN] button       │
└────────────────────────────────────────┘
```

---

## ✅ Verification

After running SQL, test by running this query:

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('projects', 'subscriptions', 'project_pages', 'project_themes', 'theme_exports');
```

You should see **5 rows** returned.

---

## 🆘 Need More Help?

If you're still stuck:

1. Take a screenshot of the InsForge dashboard
2. Take a screenshot of the error
3. Share them so I can see exactly what's happening

The SQL file (`setup-database.sql`) is ready - you just need to paste and run it!
