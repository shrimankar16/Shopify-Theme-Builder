-- AI Shopify Theme Builder - Complete Database Setup
-- Run this SQL in your InsForge Dashboard (SQL Editor)
-- IMPORTANT: Copy and paste ALL of this into the SQL editor and run it once

-- 1. Create subscriptions table (for billing)
create table if not exists public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references auth.users(id) on delete cascade,
  stripe_customer_id text,
  stripe_subscription_id text,
  plan text not null default 'free',
  billing_interval text,
  status text not null default 'free',
  current_period_start timestamptz,
  current_period_end timestamptz,
  cancel_at_period_end boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists subscriptions_customer_idx
  on public.subscriptions (stripe_customer_id);

alter table public.subscriptions enable row level security;

create policy "read own subscription"
  on public.subscriptions for select
  using (auth.uid() = user_id);

-- 2. Create projects table (main user projects)
create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  prompt text,
  status text not null default 'draft',
  description text,
  thumbnail_url text,
  thumbnail_key text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists projects_user_idx
  on public.projects (user_id);

alter table public.projects enable row level security;

create policy "read own projects"
  on public.projects for select
  using (auth.uid() = user_id);

create policy "insert own projects"
  on public.projects for insert
  with check (auth.uid() = user_id);

create policy "update own projects"
  on public.projects for update
  using (auth.uid() = user_id);

create policy "delete own projects"
  on public.projects for delete
  using (auth.uid() = user_id);

-- 3. Create project_pages table (pages within projects)
create table if not exists public.project_pages (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  page_type text not null,
  html text,
  sections jsonb,
  metadata jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists project_pages_project_idx
  on public.project_pages (project_id);

create index if not exists project_pages_user_idx
  on public.project_pages (user_id);

alter table public.project_pages enable row level security;

create policy "read own project_pages"
  on public.project_pages for select
  using (auth.uid() = user_id);

create policy "insert own project_pages"
  on public.project_pages for insert
  with check (auth.uid() = user_id);

create policy "update own project_pages"
  on public.project_pages for update
  using (auth.uid() = user_id);

create policy "delete own project_pages"
  on public.project_pages for delete
  using (auth.uid() = user_id);

-- 4. Create project_themes table (theme configurations)
create table if not exists public.project_themes (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null unique references public.projects(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  colors jsonb,
  fonts jsonb,
  settings jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists project_themes_project_idx
  on public.project_themes (project_id);

create index if not exists project_themes_user_idx
  on public.project_themes (user_id);

alter table public.project_themes enable row level security;

create policy "read own project_themes"
  on public.project_themes for select
  using (auth.uid() = user_id);

create policy "insert own project_themes"
  on public.project_themes for insert
  with check (auth.uid() = user_id);

create policy "update own project_themes"
  on public.project_themes for update
  using (auth.uid() = user_id);

create policy "delete own project_themes"
  on public.project_themes for delete
  using (auth.uid() = user_id);

-- 5. Create theme_exports table (exported ZIP files)
create table if not exists public.theme_exports (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  file_name text not null,
  storage_key text not null,
  download_url text not null,
  status text not null default 'ready',
  file_size bigint not null default 0,
  theme_version text not null default '1.0.0',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists theme_exports_project_id_key
  on public.theme_exports (project_id);

create index if not exists theme_exports_user_id_idx
  on public.theme_exports (user_id);

alter table public.theme_exports enable row level security;

create policy "theme_exports_select_own" 
  on public.theme_exports for select 
  using (user_id = auth.uid());

create policy "theme_exports_insert_own" 
  on public.theme_exports for insert 
  with check (user_id = auth.uid());

create policy "theme_exports_update_own" 
  on public.theme_exports for update 
  using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "theme_exports_delete_own" 
  on public.theme_exports for delete 
  using (user_id = auth.uid());

-- Success message
select 'Database setup complete! All tables created.' as message;
