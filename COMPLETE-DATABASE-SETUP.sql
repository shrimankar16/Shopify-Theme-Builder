-- ============================================================================
-- AI SHOPIFY THEME BUILDER - COMPLETE DATABASE SETUP
-- ============================================================================
-- Copy ALL of this and run it ONCE in your InsForge SQL Editor
-- This will create all tables with all required columns
-- ============================================================================

-- Clean up existing tables (optional - only if you want a fresh start)
-- UNCOMMENT these lines if you want to start completely fresh:
-- DROP TABLE IF EXISTS public.theme_exports CASCADE;
-- DROP TABLE IF EXISTS public.project_themes CASCADE;
-- DROP TABLE IF EXISTS public.project_pages CASCADE;
-- DROP TABLE IF EXISTS public.projects CASCADE;
-- DROP TABLE IF EXISTS public.subscriptions CASCADE;

-- ============================================================================
-- 1. SUBSCRIPTIONS TABLE (Billing & Plans)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.subscriptions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  stripe_customer_id text,
  stripe_subscription_id text,
  plan text NOT NULL DEFAULT 'free',
  billing_interval text,
  status text NOT NULL DEFAULT 'free',
  current_period_start timestamptz,
  current_period_end timestamptz,
  cancel_at_period_end boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS subscriptions_customer_idx ON public.subscriptions (stripe_customer_id);

ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "read own subscription" ON public.subscriptions;
CREATE POLICY "read own subscription"
  ON public.subscriptions FOR SELECT
  USING (auth.uid() = user_id);

-- ============================================================================
-- 2. PROJECTS TABLE (Main User Projects)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name text NOT NULL,
  prompt text,
  status text NOT NULL DEFAULT 'draft',
  description text,
  thumbnail_url text,
  thumbnail_key text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS projects_user_idx ON public.projects (user_id);

ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "read own projects" ON public.projects;
CREATE POLICY "read own projects"
  ON public.projects FOR SELECT
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "insert own projects" ON public.projects;
CREATE POLICY "insert own projects"
  ON public.projects FOR INSERT
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "update own projects" ON public.projects;
CREATE POLICY "update own projects"
  ON public.projects FOR UPDATE
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "delete own projects" ON public.projects;
CREATE POLICY "delete own projects"
  ON public.projects FOR DELETE
  USING (auth.uid() = user_id);

-- ============================================================================
-- 3. PROJECT_PAGES TABLE (Pages within Projects)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.project_pages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name text NOT NULL,
  page_type text NOT NULL,
  html text,
  sections jsonb,
  metadata jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS project_pages_project_idx ON public.project_pages (project_id);
CREATE INDEX IF NOT EXISTS project_pages_user_idx ON public.project_pages (user_id);

ALTER TABLE public.project_pages ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "read own project_pages" ON public.project_pages;
CREATE POLICY "read own project_pages"
  ON public.project_pages FOR SELECT
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "insert own project_pages" ON public.project_pages;
CREATE POLICY "insert own project_pages"
  ON public.project_pages FOR INSERT
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "update own project_pages" ON public.project_pages;
CREATE POLICY "update own project_pages"
  ON public.project_pages FOR UPDATE
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "delete own project_pages" ON public.project_pages;
CREATE POLICY "delete own project_pages"
  ON public.project_pages FOR DELETE
  USING (auth.uid() = user_id);

-- ============================================================================
-- 4. PROJECT_THEMES TABLE (Theme Configurations)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.project_themes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid NOT NULL UNIQUE REFERENCES public.projects(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  colors jsonb,
  fonts jsonb,
  settings jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS project_themes_project_idx ON public.project_themes (project_id);
CREATE INDEX IF NOT EXISTS project_themes_user_idx ON public.project_themes (user_id);

ALTER TABLE public.project_themes ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "read own project_themes" ON public.project_themes;
CREATE POLICY "read own project_themes"
  ON public.project_themes FOR SELECT
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "insert own project_themes" ON public.project_themes;
CREATE POLICY "insert own project_themes"
  ON public.project_themes FOR INSERT
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "update own project_themes" ON public.project_themes;
CREATE POLICY "update own project_themes"
  ON public.project_themes FOR UPDATE
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "delete own project_themes" ON public.project_themes;
CREATE POLICY "delete own project_themes"
  ON public.project_themes FOR DELETE
  USING (auth.uid() = user_id);

-- ============================================================================
-- 5. THEME_EXPORTS TABLE (Exported ZIP Files)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.theme_exports (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id uuid NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  file_name text NOT NULL,
  storage_key text NOT NULL,
  download_url text NOT NULL,
  status text NOT NULL DEFAULT 'ready',
  file_size bigint NOT NULL DEFAULT 0,
  theme_version text NOT NULL DEFAULT '1.0.0',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS theme_exports_project_id_key ON public.theme_exports (project_id);
CREATE INDEX IF NOT EXISTS theme_exports_user_id_idx ON public.theme_exports (user_id);

ALTER TABLE public.theme_exports ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "theme_exports_select_own" ON public.theme_exports;
CREATE POLICY "theme_exports_select_own" 
  ON public.theme_exports FOR SELECT 
  USING (user_id = auth.uid());

DROP POLICY IF EXISTS "theme_exports_insert_own" ON public.theme_exports;
CREATE POLICY "theme_exports_insert_own" 
  ON public.theme_exports FOR INSERT 
  WITH CHECK (user_id = auth.uid());

DROP POLICY IF EXISTS "theme_exports_update_own" ON public.theme_exports;
CREATE POLICY "theme_exports_update_own" 
  ON public.theme_exports FOR UPDATE 
  USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

DROP POLICY IF EXISTS "theme_exports_delete_own" ON public.theme_exports;
CREATE POLICY "theme_exports_delete_own" 
  ON public.theme_exports FOR DELETE 
  USING (user_id = auth.uid());

-- ============================================================================
-- VERIFICATION: List all created tables
-- ============================================================================
SELECT 
  table_name,
  (SELECT COUNT(*) 
   FROM information_schema.columns 
   WHERE table_schema = 'public' 
   AND table_name = t.table_name) as column_count
FROM information_schema.tables t
WHERE table_schema = 'public' 
AND table_name IN ('subscriptions', 'projects', 'project_pages', 'project_themes', 'theme_exports')
ORDER BY table_name;

-- ============================================================================
-- SUCCESS MESSAGE
-- ============================================================================
SELECT '✅ Database setup complete! All 5 tables created with all required columns.' as message;
