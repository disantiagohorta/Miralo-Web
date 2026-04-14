#!/bin/bash
echo "Injecting environment variables..."
sed -i "s|YOUR_SUPABASE_URL|${SUPABASE_URL}|g" index.html
sed -i "s|YOUR_SUPABASE_ANON_KEY|${SUPABASE_ANON_KEY}|g" index.html
sed -i "s|YOUR_RENDER_API_URL|${RENDER_API_URL}|g" q/index.html
echo "Done."