---
name: todo
description: >
  Manage FriendsBattery roadmap in docs/ROADMAP.md AND sync Obsidian canvas
  Role Chain Workflow. List, show, add, mark done/undone, full canvas sync.
  Triggers: /todo, /todo-add, /todo-done, /todo-undone, /todo-sync, /todo next,
  roadmap, obsidian workflow.
---

# Todo + Obsidian workflow

## Files (always both)

| File | Role |
|------|------|
| `docs/ROADMAP.md` | **Source of truth** — checkboxes `- [ ]` / `- [x]` |
| `obsidian/FriendsBattery/Role Chain Workflow.canvas` | Visual in Obsidian — must match ROADMAP |
| `obsidian/FriendsBattery/Role Chain Workflow.md` | Optional mermaid note — update **Next** line on sync |

Never invent a second todo list. Edit ROADMAP first, then sync canvas.

**Role chain:** `SUPER ADMIN → ADMIN → SELLER → EMPLOYEE`  
Order: `§0 → §1 → §2 → §3 → §4 → §5 → §6` (Optional last).

---

## Commands

| Say | Do |
|-----|-----|
| `/todo` | Overview table from ROADMAP + **Next up** + remind canvas path |
| `/todo <n\|name>` | Print that ROADMAP section |
| `/todo next` | First incomplete section + open boxes |
| `/todo-add <text>` | Append `- [ ]` in right § → **sync canvas** |
| `/todo-done <n\|text>` | `- [ ]` → `- [x]` → **sync canvas** |
| `/todo-undone <n\|text>` | `- [x]` → `- [ ]` → **sync canvas** |
| `/todo-sync` | Rebuild canvas status from ROADMAP only (no ROADMAP edit) |

Ambiguous match → one short question.

---

## Placement (`/todo-add`)

| Sounds like | § | Canvas node `id` |
|-------------|---|------------------|
| roles, requireRole, four roles | **0** | `sec_0` |
| super admin, all WH, stock any WH | **1** | `sec_1` |
| shop admin, own shop, add shop | **2** | `sec_2` |
| seller re-scope | **3** | `sec_3` |
| employee bill, check-in | **4** | `sec_4` |
| WhatsApp, print, OTP, scrap, service, rent | **5** | `sec_5` |
| e2e, harden, smoke, GPS only when checked in | **6** | `sec_6` |
| optional / later | Optional | `sec_opt` |

After add: say `§N` + line + “canvas synced”.

---

## Done / not done

### `/todo-done`
1. In ROADMAP: flip matching open items to `- [x]`  
   - `/todo-done 1` → all open boxes under `## 1.`  
   - `/todo-done employee create bill` → match text  
2. Run **canvas sync** (below).  
3. Confirm what flipped + section status (NOT DONE / PARTIAL / DONE).

### `/todo-undone`
Same, reverse: `- [x]` → `- [ ]`, then sync.

---

## Canvas sync (required after every ROADMAP change)

**Path:** `obsidian/FriendsBattery/Role Chain Workflow.canvas`  
Stable node ids: `title`, `sec_0` … `sec_6`, `sec_done`, `sec_opt`, `flow`, `build`, `legend`.

### Per section node (`sec_N`)

1. Read ROADMAP section checkboxes (ignore tables).  
2. Count open / done.  
3. Rewrite node `text` as:

```markdown
## §N Title
**Status: NOT DONE|PARTIAL|DONE** (done/total)

☐ item still open
☑ item done
```

Map: `- [ ]` → `☐` · `- [x]` → `☑`  
Use short item text (same meaning as ROADMAP).

4. Set node `color` by status:
   - **NOT DONE** (done=0) → `"1"` (red)
   - **PARTIAL** → `"3"` (yellow)
   - **DONE** (all done, total>0) → `"4"` (green)

### `title` node

```markdown
# Role chain & workflow
`SUPER ADMIN → ADMIN → SELLER → EMPLOYEE`
Source: `docs/ROADMAP.md` · `/todo` · `/todo-sync`
**Next:** §N Title   ← first section with any open box (0–6, else Optional)
Status: ☐ not done · ☑ done
```

### `sec_done`

Baseline “Already done” from ROADMAP — always DONE / green `"4"`.

### No inner scroll (critical)

Obsidian cards **scroll inside** if text taller than `height`. Always:
- Short lines (one todo per line, blank line between todos)
- `height` ≥ ~50 + 36 × (line count including blanks/title)
- Prefer split nodes (`sec_5a` / `sec_5b` / `sec_5c`) over one tall wall of text
- After rewriting `text`, if lines increased, **increase `height`** — never shrink height below content

### Keep fixed

Do **not** shrink heights. Only grow height when content grows.  
Update `text` + `color` (+ `height` if needed). Keep edges.

### Companion md (light)

On sync, set **Next** in `Role Chain Workflow.md` to match title next-up (one line). Don’t rewrite whole file unless broken.

### If canvas missing

Recreate from ROADMAP using current layout (role row §0–4, §5–6 + optional, edges §0→…→§4→§5→§6).

---

## `/todo` overview format

| # | Section | Open | Done | Status |
|---|---------|------|------|--------|
| 0 | Roles foundation | … | … | … |

**Next up:** …  
**Canvas:** `obsidian/FriendsBattery/Role Chain Workflow.canvas`

---

## Hygiene

- ROADMAP is source of truth; canvas is a view.  
- Always sync canvas after add/done/undone.  
- Short replies; no full ROADMAP dump on `/todo`.  
- Don’t reorder role chain.  
