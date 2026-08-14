# FriendsBattery — roadmap

**Role chain:** `SUPER ADMIN → ADMIN → SELLER → EMPLOYEE`  
One stream at a time. Work **down** the chain.  
`- [ ]` todo · `- [x]` done.  
**Next:** §6 Hardening / ops.

```text
SUPER ADMIN     all WH + shops · stock any WH · adjust any shop · PDF/GPS all · sell/accept
    └── ADMIN   own shop · add shop (not WH) · sell · accept · PDF/GPS shop
            └── SELLER   own inventory · sell · accept · returns · staff
                    └── EMPLOYEE   create bill · check-in/out · no accept shipment
```

Shared sell tools (§5) once anyone can sell. Obsidian: `obsidian/FriendsBattery/Role Chain Workflow.canvas` · `/todo-sync`.

## Completed Tasks & Archive

Completed sections and baseline tasks are archived with timestamps/numbers in [completed_tasks.md](file:///c:/Users/DELL/dev/friendsBattery/docs/completed_tasks.md).

---


## Completed Sections & Archive

Finished sections (§0 through §5) are archived with numbers (`#1` through `#6`) and timestamps in [completed_tasks.md](file:///c:/Users/DELL/dev/friendsBattery/docs/completed_tasks.md).

---

## 6. Hardening / ops (suggested)

- [ ] E2E smoke: login → stock → ship → accept → sell → return (all roles that apply)  
- [ ] GPS: no tracking when checked out; only while on shift  

---

## Build order

```text
0 Roles
  → 1 Super Admin
    → 2 Admin
      → 3 Seller re-scope
        → 4 Employee create bill
          → 5 Shared (validate → WA → print → OTP → scrap/mechanic → services → rent)
            → 6 Harden / ops polish
```

Do **not** start §5 rent/service before §4 employee bill works.

---

## Optional later (suggested; only if needed)

- [ ] Location ↔ location stock move (warehouse ↔ shop without full seller reassignment)  
- [ ] Seller stock **request** flow (schema exists; no app flow yet)  
- [ ] Admin attendance **history** reports (beyond live GPS)  
