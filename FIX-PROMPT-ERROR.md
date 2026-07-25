# 🔧 Fix "Could not find the 'prompt' column" Error

## The Problem
Your app shows: **"Could not find the 'prompt' column of 'projects' in the schema cache"**

This means the `projects` table is missing two columns: `prompt` and `status`.

---

## ✅ THE FIX (2 Minutes)

### Quick Fix: Add Missing Columns

1. **Go back to InsForge SQL Editor**
   - https://insforge.dev
   - Your project → SQL Editor

2. **Copy this SQL:**
   - Open file: `add-missing-columns.sql`
   - Copy everything (Ctrl+A, Ctrl+C)

3. **Run it:**
   - Paste in SQL Editor (Ctrl+V)
   - Click "RUN"
   - Should see: ✅ "Missing columns added successfully!"

4. **Refresh your app:**
   - Go to http://localhost:3000
   - Press F5
   - Error should be GONE! ✅

---

## 📋 What This Does

Adds two missing columns to your `projects` table:

- **`prompt`** (text) - Stores the original user input prompt
- **`status`** (text) - Tracks project state (draft, generating, ready)

---

## 🔄 Alternative: Drop and Recreate Table (Clean Slate)

If you want to start fresh (this will delete any test projects you created):

```sql
-- Drop the existing table (WARNING: deletes all projects!)
DROP TABLE IF EXISTS public.projects CASCADE;

-- Then run the full setup-database.sql again
```

**Only use this if:**
- You haven't created any projects you want to keep
- The quick fix above didn't work

---

## ✅ Verification

After running the SQL, verify with this query:

```sql
SELECT column_name 
FROM information_schema.columns
WHERE table_name = 'projects' 
AND table_schema = 'public'
ORDER BY ordinal_position;
```

You should see these columns:
- ✅ id
- ✅ user_id
- ✅ name
- ✅ prompt ← NEW
- ✅ status ← NEW
- ✅ description
- ✅ thumbnail_url
- ✅ thumbnail_key
- ✅ created_at
- ✅ updated_at

---

## 🎯 Why This Happened

The initial SQL script I provided was missing these columns. I've now updated:

- ✅ `setup-database.sql` - Fixed to include `prompt` and `status`
- ✅ `add-missing-columns.sql` - Quick fix to add them to existing table

---

## 📝 Next Steps After This Fix

Once the columns are added:

1. ✅ Refresh http://localhost:3000
2. ✅ Enter a prompt like: "Create a modern ecommerce homepage"
3. ✅ Click the arrow button to generate
4. ✅ Watch the AI build your Shopify theme in real-time!

---

## 🆘 Still Getting Errors?

If you see other "column not found" errors, let me know which column and I'll create the fix!

Common ones might be:
- Other tables (project_pages, project_themes)
- Different column names

Just share the exact error message.
