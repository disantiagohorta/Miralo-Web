# miralo-web

Public-facing website for [miraloai.com](https://miraloai.com). Deployed on Vercel.

## Pages

| Route | File | Purpose |
|---|---|---|
| `/` | `index.html` | Landing page with waitlist signup |
| `/q/{invite-code}` | `q/index.html` | Companion questionnaire (Ari-voiced) |

## Setup

### 1. Connect to Vercel
- Import this repo in Vercel
- Point `miraloai.com` domain to the Vercel project
- No build step needed — it's static HTML

### 2. Configure Supabase (landing page waitlist)
In `index.html`, replace the two placeholder values:
```js
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

Create the waitlist table:
```sql
CREATE TABLE waitlist (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  source TEXT DEFAULT 'landing_page',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(email),
  UNIQUE(phone)
);

ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow anonymous inserts" ON waitlist
  FOR INSERT WITH CHECK (true);
```

### 3. Configure API (companion form)
In `q/index.html`, replace:
```js
const API_BASE = 'YOUR_RENDER_API_URL';
```

The companion form calls two endpoints on your Render backend:
- `GET /invite/{code}` — resolves invite code to `{ inviter_name, recipient_name }`
- `POST /invite/{code}/responses` — submits questionnaire responses

## Routing

`vercel.json` rewrites `/q/{anything}` to serve `q/index.html`. The invite code is parsed client-side from the URL path.

## Design System

- **Fonts:** Cormorant Garamond (display), DM Sans (body)
- **Palette:** warm-white `#F5F0E8`, terracotta `#C4622D`, ink `#2A1F1B`, stone `#8C7168`, blush `#EBC4AB`, cream `#FAF7F2`
- **Dark theme:** `#18100A` base
