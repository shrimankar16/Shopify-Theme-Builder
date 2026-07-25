-- Fix: Add missing columns to projects table
-- Run this in InsForge SQL Editor

-- Add prompt column (stores the original user input)
ALTER TABLE public.projects 
ADD COLUMN IF NOT EXISTS prompt text;

-- Add status column (tracks project state: draft, generating, ready, etc.)
ALTER TABLE public.projects 
ADD COLUMN IF NOT EXISTS status text NOT NULL DEFAULT 'draft';

-- Verify columns were added
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public' 
AND table_name = 'projects'
ORDER BY ordinal_position;

-- Success message
SELECT 'Missing columns added successfully!' as message;
