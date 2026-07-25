/**
 * Database Setup Script
 * Runs the complete database setup using the InsForge admin key
 */

const fs = require('fs');
const path = require('path');

// Load environment variables
require('dotenv').config({ path: '.env.local' });

const INSFORGE_URL = process.env.NEXT_PUBLIC_INSFORGE_URL;
const ADMIN_KEY = process.env.INSFORGE_ADMIN_KEY;

if (!INSFORGE_URL || !ADMIN_KEY) {
  console.error('❌ Error: Missing required environment variables');
  console.error('Make sure .env.local has:');
  console.error('  - NEXT_PUBLIC_INSFORGE_URL');
  console.error('  - INSFORGE_ADMIN_KEY');
  process.exit(1);
}

console.log('🔧 Setting up database...');
console.log(`📡 InsForge URL: ${INSFORGE_URL}`);

// SQL to create tables
const tables = [
  {
    name: 'subscriptions',
    sql: `
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
      CREATE POLICY "read own subscription" ON public.subscriptions FOR SELECT USING (auth.uid() = user_id);
    `
  },
  {
    name: 'projects',
    sql: `
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
      CREATE POLICY "read own projects" ON public.projects FOR SELECT USING (auth.uid() = user_id);
      DROP POLICY IF EXISTS "insert own projects" ON public.projects;
      CREATE POLICY "insert own projects" ON public.projects FOR INSERT WITH CHECK (auth.uid() = user_id);
      DROP POLICY IF EXISTS "update own projects" ON public.projects;
      CREATE POLICY "update own projects" ON public.projects FOR UPDATE USING (auth.uid() = user_id);
      DROP POLICY IF EXISTS "delete own projects" ON public.projects;
      CREATE POLICY "delete own projects" ON public.projects FOR DELETE USING (auth.uid() = user_id);
    `
  }
];

async function executeSQL(sql) {
  const response = await fetch(`${INSFORGE_URL}/rest/v1/rpc/exec_sql`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'apikey': ADMIN_KEY,
      'Authorization': `Bearer ${ADMIN_KEY}`
    },
    body: JSON.stringify({ query: sql })
  });

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`SQL execution failed: ${error}`);
  }

  return response.json();
}

async function setupDatabase() {
  try {
    console.log('\n📋 Creating tables...\n');

    for (const table of tables) {
      process.stdout.write(`  Creating ${table.name}... `);
      await executeSQL(table.sql);
      console.log('✅');
    }

    console.log('\n✅ Database setup complete!');
    console.log('\n🎉 You can now refresh your app at http://localhost:3000\n');
    
  } catch (error) {
    console.error('\n❌ Setup failed:', error.message);
    console.error('\n💡 Try using the InsForge CLI instead:');
    console.error('   npx @insforge/cli db execute -f COMPLETE-DATABASE-SETUP.sql\n');
    process.exit(1);
  }
}

setupDatabase();
