# Role chain workflow

**Canvas (open this in Obsidian):** [[Role Chain Workflow]]  
**Todos:** `docs/ROADMAP.md` · commands: `/todo` · `/todo-done` · `/todo-undone` · `/todo-sync`

**Next:** §1 Super Admin

## Chain

```text
SUPER ADMIN → ADMIN → SELLER → EMPLOYEE
```

```mermaid
flowchart LR
  SA[Super Admin]
  AD[Admin]
  SE[Seller]
  EM[Employee]
  SA -->|shop| AD
  AD -->|seller| SE
  SE -->|staff| EM
```

## Status on canvas

| Color | Meaning |
|-------|---------|
| Red | NOT DONE (0 done) |
| Yellow | PARTIAL |
| Green | DONE |

- `☐` = not done · `☑` = done  
- After any `/todo-done` or `/todo-undone`, canvas is re-synced from ROADMAP  

## Build order

```mermaid
flowchart LR
  F[§0 Roles] --> S1[§1 Super Admin]
  S1 --> S2[§2 Admin]
  S2 --> S3[§3 Seller]
  S3 --> S4[§4 Employee]
  S4 --> S5[§5 Shared sell]
```

## Stock flow

```mermaid
flowchart LR
  A[WH stock SA] --> B[Ship]
  B --> C[Accept Admin/Seller]
  C --> D[Bill Admin/Seller/Emp]
  D --> E[Shared tools]
```
