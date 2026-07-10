#!/usr/bin/env bash
# ATI Complete Rebrand Script (ATI v16.4.7 → ATI + EVN)
# Usage: cd <repo_root> && bash do_rebrand.sh
set -e

echo "🔄 ATI Complete Rebrand - Starting..."

# ===== STEP 1: Rename directory arguswatch → ati =====
echo "📦 Step 1: Renaming backend/arguswatch → backend/ati..."
if [[ -d "backend/arguswatch" ]]; then
  mv backend/arguswatch backend/ati
  echo "   ✓ Renamed successfully"
else
  echo "   ⚠️  backend/arguswatch not found"
fi

# ===== STEP 2: Update Python imports (arguswatch → ati) =====
echo "📝 Step 2: Updating Python imports and references..."
find . -type f \( -name "*.py" -o -name "*.yml" -o -name "*.yaml" -o -name "*.sh" -o -name "*.md" \) \
  -not -path "./.git/*" -not -path "./.rebrand-backup/*" \
  -exec sed -i 's/from ati/from ati/g' {} + \
  -exec sed -i 's/import ati/import ati/g' {} + \
  -exec sed -i 's/backend\.ati/backend.ati/g' {} + \
  -exec sed -i 's|ati/|ati/|g' {} +

echo "   ✓ Updated all Python imports"

# ===== STEP 3: Update text references (ATI → ATI) =====
echo "📄 Step 3: Updating text references..."
find . -type f \( -name "*.py" -o -name "*.html" -o -name "*.md" -o -name "*.yml" -o -name "*.sh" \) \
  -not -path "./.git/*" -not -path "./.rebrand-backup/*" \
  -exec sed -i 's/ATI (Agentic Threat Intelligence)/ATI (Agentic Threat Intelligence)/g' {} + \
  -exec sed -i 's/ATI Agentic-AI/ATI Agentic-AI/g' {} + \
  -exec sed -i 's/ATI/ATI/g' {} + \
  -exec sed -i 's/EVN/EVN/g' {} + \
  -exec sed -i 's/EVN/EVN/g' {} +

echo "   ✓ Updated all text references"

# ===== STEP 4: Rename SVG files =====
echo "🎨 Step 4: Replacing SVG logos..."
if [[ -d "backend/ati/static" ]]; then
  # Overwrite with new SVG content
  cat > backend/ati/static/solvent-icon.svg <<'SVG_ICON'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" width="28" height="28">
  <defs><linearGradient id="atig" x1="0" y1="0" x2="1" y2="1">
    <stop offset="0%" stop-color="#22d3ee"/><stop offset="100%" stop-color="#a78bfa"/>
  </linearGradient></defs>
  <path d="M16 2 L27 6 V15 C27 22 22 27 16 30 C10 27 5 22 5 15 V6 Z"
        fill="none" stroke="url(#atig)" stroke-width="1.8" stroke-linejoin="round"/>
  <circle cx="16" cy="14" r="2.5" fill="url(#atig)"/>
  <path d="M16 14 L16 8 M16 14 L10 17 M16 14 L22 17 M16 14 L16 22"
        stroke="url(#atig)" stroke-width="1.5" stroke-linecap="round" fill="none"/>
  <circle cx="16" cy="8" r="1.2" fill="#22d3ee"/>
  <circle cx="10" cy="17" r="1.2" fill="#22d3ee"/>
  <circle cx="22" cy="17" r="1.2" fill="#a78bfa"/>
  <circle cx="16" cy="22" r="1.2" fill="#a78bfa"/>
</svg>
SVG_ICON

  cat > backend/ati/static/solvent-logo.svg <<'SVG_LOGO'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 180 40" width="180" height="40">
  <defs><linearGradient id="atilg" x1="0" y1="0" x2="1" y2="0">
    <stop offset="0%" stop-color="#22d3ee"/><stop offset="100%" stop-color="#a78bfa"/>
  </linearGradient></defs>
  <g transform="translate(4,4)">
    <path d="M16 0 L28 4 V14 C28 22 22 28 16 32 C10 28 4 22 4 14 V4 Z"
          fill="none" stroke="url(#atilg)" stroke-width="1.8" stroke-linejoin="round"/>
    <circle cx="16" cy="14" r="2.4" fill="url(#atilg)"/>
    <path d="M16 14 L16 8 M16 14 L10 17 M16 14 L22 17 M16 14 L16 22"
          stroke="url(#atilg)" stroke-width="1.4" stroke-linecap="round" fill="none"/>
  </g>
  <text x="44" y="26" font-family="'Segoe UI',Roboto,system-ui,sans-serif"
        font-size="20" font-weight="700" letter-spacing="2" fill="url(#atilg)">ATI</text>
  <text x="82" y="26" font-family="'Segoe UI',Roboto,system-ui,sans-serif"
        font-size="11" font-weight="500" letter-spacing="1" fill="#a8b3cf">Agentic TI</text>
</svg>
SVG_LOGO

  echo "   ✓ Updated SVG logos"
else
  echo "   ⚠️  backend/ati/static not found"
fi

# ===== STEP 5: Update CSS theme to dark SOC =====
echo "🌙 Step 5: Updating CSS theme to dark SOC..."
python3 <<'PYCSS'
import re
p = "backend/ati/static/dashboard.css"
try:
  with open(p, "r", encoding="utf-8") as f:
    css = f.read()

  new_root = """:root{
  --bg:#0b1020;--bg2:#131a2e;--bg3:#1a2340;--bg4:#212b4d;
  --surface:#101728;--surface2:#17203a;--surface3:#1f2947;
  --text:#e7ecf7;--text2:#a8b3cf;--text3:#7d8aab;--text4:#5a6789;
  --cyan:#22d3ee;--cyan-g:rgba(34,211,238,.12);--cyan-b:rgba(34,211,238,.35);
  --orange:#f59e0b;--orange-g:rgba(245,158,11,.12);--orange-b:rgba(245,158,11,.3);
  --green:#22c55e;--green-g:rgba(34,197,94,.1);--green-b:rgba(34,197,94,.25);
  --red:#ef4444;--red-g:rgba(239,68,68,.1);--red-b:rgba(239,68,68,.25);
  --purple:#a78bfa;--purple-g:rgba(167,139,250,.1);
  --amber:#fbbf24;--amber-g:rgba(251,191,36,.1);
  --blue:#60a5fa;--blue-g:rgba(96,165,250,.1);
"""

  m = re.search(r":root\{", css)
  if m:
    start = m.start()
    depth = 0
    i = m.end() - 1
    while i < len(css):
      if css[i] == '{': depth += 1
      elif css[i] == '}':
        depth -= 1
        if depth == 0:
          end = i + 1
          break
      i += 1

    css_new = css[:start] + new_root + "}\n" + css[end:]
    with open(p, "w", encoding="utf-8") as f:
      f.write(css_new)
    print("   ✓ Updated CSS theme to dark SOC")
  else:
    print("   ⚠️  :root{ not found in CSS")
except Exception as e:
  print(f"   ⚠️  Error updating CSS: {e}")
PYCSS

# ===== STEP 6: Update seed customers to EVN =====
echo "💾 Step 6: Updating seed customers to EVN..."
python3 <<'PYMAIN'
import re
try:
  p = "backend/ati/main.py"
  with open(p, "r", encoding="utf-8") as f:
    src = f.read()

  new_demo = '''DEMO_CUSTOMERS = [
            {"name": "EVN", "domain": "evn.com.vn", "industry": "energy"},
            {"name": "EVN NPC", "domain": "npc.com.vn", "industry": "energy"},
            {"name": "EVN CPC", "domain": "cpc.vn", "industry": "energy"},
            {"name": "EVN SPC", "domain": "evnspc.vn", "industry": "energy"},
            {"name": "EVN HANOI", "domain": "evnhanoi.com.vn", "industry": "energy"},
            {"name": "EVN HCMC", "domain": "evnhcmc.vn", "industry": "energy"},
            {"name": "EVNICT", "domain": "evnict.vn", "industry": "energy"},
        ]'''

  pattern = re.compile(r'DEMO_CUSTOMERS\s*=\s*\[[\s\S]*?\n\s*\]', re.MULTILINE)
  if pattern.search(src):
    src = pattern.sub(new_demo, src, count=1)
    with open(p, "w", encoding="utf-8") as f:
      f.write(src)
    print("   ✓ Updated DEMO_CUSTOMERS in main.py")
  else:
    print("   ⚠️  DEMO_CUSTOMERS not found")
except Exception as e:
  print(f"   ⚠️  Error: {e}")
PYMAIN

# ===== STEP 7: Update entrypoint.sh seed data =====
echo "🗄️  Step 7: Updating database seed data..."
python3 <<'PYENTRY'
import re
try:
  p = "backend/entrypoint.sh"
  with open(p, "r", encoding="utf-8") as f:
    src = f.read()

  new_block = '''# Customers – EVN group
$PGCMD -c "INSERT INTO customers (name, industry, tier, email, onboarding_state, active) VALUES
  ('EVN','energy','enterprise','security@evn.com.vn','monitoring',true),
  ('EVN NPC','energy','enterprise','security@npc.com.vn','monitoring',true),
  ('EVN CPC','energy','premium','security@cpc.vn','monitoring',true),
  ('EVN SPC','energy','enterprise','security@evnspc.vn','monitoring',true),
  ('EVN HANOI','energy','premium','security@evnhanoi.com.vn','monitoring',true),
  ('EVN HCMC','energy','premium','security@evnhcmc.vn','monitoring',true),
  ('EVNICT','energy','standard','security@evnict.vn','monitoring',true)
  ON CONFLICT (name) DO NOTHING;" 2>/dev/null || true

# Customer assets – brand + domain + keyword for each EVN unit
$PGCMD -c "INSERT INTO customer_assets (customer_id, asset_type, asset_value, criticality)
  SELECT c.id, a.t::assettype, a.v, a.cr FROM customers c
  CROSS JOIN (VALUES
    ('domain','evn.com.vn','critical'),('keyword','evn','critical'),('brand_name','EVN','critical'),
    ('subdomain','portal.evn.com.vn','high'),('subdomain','mail.evn.com.vn','high'),
    ('domain','npc.com.vn','critical'),('keyword','npc','high'),('brand_name','EVN NPC','critical'),
    ('subdomain','cskh.npc.com.vn','high'),
    ('domain','cpc.vn','critical'),('keyword','cpc','high'),('brand_name','EVN CPC','critical'),
    ('subdomain','cskh.cpc.vn','high'),
    ('domain','evnspc.vn','critical'),('keyword','evnspc','high'),('brand_name','EVN SPC','critical'),
    ('subdomain','cskh.evnspc.vn','high'),
    ('domain','evnhanoi.com.vn','critical'),('keyword','evnhanoi','high'),('brand_name','EVN HANOI','critical'),
    ('subdomain','cskh.evnhanoi.com.vn','high'),
    ('domain','evnhcmc.vn','critical'),('keyword','evnhcmc','high'),('brand_name','EVN HCMC','critical'),
    ('subdomain','cskh.evnhcmc.vn','high'),
    ('domain','evnict.vn','critical'),('keyword','evnict','critical'),('brand_name','EVNICT','critical'),
    ('subdomain','portal.evnict.vn','high')
  ) AS a(t, v, cr)
  WHERE (c.name='EVN'       AND a.v IN ('evn.com.vn','evn','EVN','portal.evn.com.vn','mail.evn.com.vn'))
     OR (c.name='EVN NPC'   AND a.v IN ('npc.com.vn','npc','EVN NPC','cskh.npc.com.vn'))
     OR (c.name='EVN CPC'   AND a.v IN ('cpc.vn','cpc','EVN CPC','cskh.cpc.vn'))
     OR (c.name='EVN SPC'   AND a.v IN ('evnspc.vn','evnspc','EVN SPC','cskh.evnspc.vn'))
     OR (c.name='EVN HANOI' AND a.v IN ('evnhanoi.com.vn','evnhanoi','EVN HANOI','cskh.evnhanoi.com.vn'))
     OR (c.name='EVN HCMC'  AND a.v IN ('evnhcmc.vn','evnhcmc','EVN HCMC','cskh.evnhcmc.vn'))
     OR (c.name='EVNICT'    AND a.v IN ('evnict.vn','evnict','EVNICT','portal.evnict.vn'))
  ON CONFLICT DO NOTHING;" 2>/dev/null || true

'''

  pat = re.compile(r'# Customers.*?(?=# NOTE: No fake findings)', re.DOTALL)
  if pat.search(src):
    src = pat.sub(new_block, src, count=1)
    with open(p, "w", encoding="utf-8") as f:
      f.write(src)
    print("   ✓ Updated database seed data in entrypoint.sh")
  else:
    print("   ⚠️  Customers block not found in entrypoint.sh")
except Exception as e:
  print(f"   ⚠️  Error: {e}")
PYENTRY

echo ""
echo "========================================================"
echo "✅ Rebrand completed successfully!"
echo ""
echo "NEXT STEPS (REQUIRED):"
echo ""
echo "  # 1. Wipe database to seed EVN data:"
echo "  docker compose down -v"
echo ""
echo "  # 2. Rebuild images (includes new Python code):"
echo "  docker compose build backend celery_worker celery_beat"
echo ""
echo "  # 3. Boot up:"
echo "  docker compose up -d"
echo ""
echo "  # 4. Open dashboard:"
echo "  http://localhost:7777"
echo ""
echo "========================================================"
