# Friends Battery Backend Architecture & Guidelines

This document is the source of truth for backend implementation, containing both the architectural diagrams and coding guidelines. All developers and AI agents must follow these guidelines. Do not introduce new architectural patterns without updating this document.

---

## Part 1: Architecture Diagrams

### 1. High-Level System Architecture Diagram

```mermaid
graph TD
    %% Clients
    subgraph Clients["Clients"]
        A[Admin Flutter App]
        S[Seller Flutter App]
    end

    %% Deployment Environment
    subgraph Railway["Railway Cloud Platform"]
        %% API Gateway / Express Server
        API["Node.js / Express Server"]
        
        %% Middleware
        subgraph Middlewares["Middlewares"]
            Auth[JWT Auth Middleware]
            RBAC[Role-Based Access Control]
        end
        
        API --> Auth
        Auth --> RBAC
        
        %% Backend Modules
        subgraph Modules["Business Modules"]
            AuthMod[Auth]
            UserMod[User]
            ProdMod[Product]
            InvMod[Inventory]
            ShipMod[Shipment]
            SalesMod[Sales]
            ReqMod[Stock Request]
            DashMod[Dashboard]
            AuditMod[Audit]
        end
        
        RBAC --> Modules
    end

    %% Database Environment
    subgraph Neon["Neon PostgreSQL Cloud"]
        DB[(PostgreSQL Database)]
    end

    %% Connections
    A -->|HTTPS / REST API| API
    S -->|HTTPS / REST API| API
    Modules -->|Prisma Client| DB
```

### 2. Backend Internal Architecture Diagram

```mermaid
graph TD
    %% API Layer
    subgraph API_Layer["1. API Routing Layer"]
        Routes[Express Routes]
    end

    %% Middleware Layer
    subgraph Middleware_Layer["2. Middleware Layer"]
        AuthM[Authentication]
        RoleM[Authorization / RBAC]
        ValM[Zod Validation]
    end

    %% Business Layer
    subgraph Controller_Layer["3. Controller Layer"]
        C_Auth[Auth Controller]
        C_Inv[Inventory Controller]
        C_Sales[Sales Controller]
        C_Etc[...Other Controllers]
    end

    subgraph Service_Layer["4. Service Layer"]
        S_Auth[Auth Service]
        S_Inv[Inventory Service]
        S_Sales[Sales Service]
        S_Etc[...Other Services]
    end

    %% Data Access Layer
    subgraph Repository_Layer["5. Repository Layer"]
        R_Auth[Auth Repository]
        R_Inv[Inventory Repository]
        R_Sales[Sales Repository]
        R_Etc[...Other Repositories]
    end

    %% Database Layer
    subgraph DB_Layer["6. Database Layer"]
        Prisma[Prisma ORM]
        DB[(PostgreSQL)]
    end

    Routes --> AuthM
    AuthM --> RoleM
    RoleM --> ValM
    ValM --> C_Auth & C_Inv & C_Sales & C_Etc
    
    C_Auth --> S_Auth
    C_Inv --> S_Inv
    C_Sales --> S_Sales
    C_Etc --> S_Etc
    
    S_Auth --> R_Auth
    S_Inv --> R_Inv
    S_Sales --> R_Sales
    S_Etc --> R_Etc
    
    R_Auth & R_Inv & R_Sales & R_Etc --> Prisma
    Prisma --> DB
```

### 3. Request Flow Diagram

```mermaid
sequenceDiagram
    participant Client as Flutter App
    participant Route as Express Router
    participant Auth as Auth Middleware
    participant RBAC as Role Middleware
    participant Val as Zod Validation
    participant Ctrl as Controller
    participant Svc as Service
    participant Repo as Repository
    participant DB as PostgreSQL

    Client->>Route: HTTP Request (e.g., POST /sales)
    Route->>Auth: Verify JWT
    alt Invalid Token
        Auth-->>Client: 401 Unauthorized
    else Valid Token
        Auth->>RBAC: Check User Role
        alt Insufficient Role
            RBAC-->>Client: 403 Forbidden
        else Authorized Role
            RBAC->>Val: Validate Payload (Zod)
            alt Invalid Payload
                Val-->>Client: 400 Bad Request
            else Valid Payload
                Val->>Ctrl: Pass Request
                Ctrl->>Svc: Invoke Business Logic
                Svc->>Repo: Data Operations
                Repo->>DB: Prisma Query
                DB-->>Repo: Query Result
                Repo-->>Svc: Formatted Data
                Svc-->>Ctrl: Service Response
                Ctrl-->>Client: HTTP 200/201 (Response Utility)
            end
        end
    end
```

### 4. Inventory Transfer Flow Diagram

```mermaid
sequenceDiagram
    participant Admin as Admin (Wholesaler)
    participant API as Shipment Module
    participant InvSvc as Inventory Service
    participant AuditSvc as Audit Service
    participant DB as PostgreSQL (Prisma)

    Admin->>API: Initiate Transfer (Seller ID, Serial Numbers)
    API->>InvSvc: Process Transfer
    
    %% Business Logic
    InvSvc->>DB: Check Unit Availability & Ownership
    DB-->>InvSvc: Units Status
    
    alt Units not available or not owned
        InvSvc-->>API: Throw Error
        API-->>Admin: 400 Bad Request
    else Units valid
        %% Core Architectural Rule: Immutable Ledger & Unit-based inventory
        InvSvc->>DB: UPDATE product_units (set owner = Seller)
        InvSvc->>DB: INSERT INTO inventory_transactions (Admin to Seller, Unit-based)
        InvSvc->>AuditSvc: Log Activity (Transfer successful)
        AuditSvc->>DB: INSERT audit_log
        
        DB-->>InvSvc: Commit Success
        InvSvc-->>API: Transfer Complete
        API-->>Admin: 200 OK (Transfer Successful)
    end
```

### 5. Battery Traceability Flow Diagram

```mermaid
stateDiagram-v2
    [*] --> Wholesaler_Inventory : Battery Added to System (Admin)
    
    state Wholesaler_Inventory {
        [*] --> In_Stock_Admin
        In_Stock_Admin --> Transfer_Pending : Transfer Initiated
        Transfer_Pending --> Dispatched : Transfer Approved
    }
    
    Wholesaler_Inventory --> Seller_Inventory : Shipment Received by Seller
    
    state Seller_Inventory {
        [*] --> In_Stock_Seller
        In_Stock_Seller --> Reserved : Added to Cart/Order Pending
        Reserved --> In_Stock_Seller : Order Cancelled
        Reserved --> Sold : Sale Completed
    }
    
    Seller_Inventory --> Customer_Ownership : Battery Sold
    
    state Customer_Ownership {
        [*] --> Active_Warranty
        Active_Warranty --> Warranty_Claimed : Defect Reported
        Active_Warranty --> Warranty_Expired : Time Elapsed
    }
    
    note right of Seller_Inventory
        Every state change generates 
        a new row in the immutable
        inventory_transactions table
        tied to the Unit Serial Number.
    end note
```

---

## Part 2: Architecture Guidelines

### Architecture Flow

Every request must follow:

Route
→ Authentication Middleware
→ Authorization Middleware
→ Validation Middleware
→ Controller
→ Service
→ Repository
→ Prisma
→ PostgreSQL

Never bypass layers.

Controllers must never access Prisma directly.

Services must never access Express request/response objects.

Repositories are the only layer allowed to access Prisma.

---

### Folder Structure

src/

routes/
controllers/
services/
repositories/
models/
validators/
middleware/
utils/
config/

---

### Authentication

Authentication is mandatory for all protected APIs.

Login returns:

{
"auth_id": "",
"auth_key": ""
}

Authentication middleware must:

1. Verify auth_id exists.
2. Verify auth_key is valid.
3. Load authenticated user.
4. Attach user information to request.

Example:

req.user = {
id,
role,
shop_id
}

Never trust values sent from frontend.

Always use authenticated user data from middleware.

---

### Authorization

Authorization is mandatory.

Every protected API must verify permissions.

Roles:

ADMIN
SELLER

Rules:

ADMIN:

* Access all data
* Manage sellers
* Manage inventory
* Approve requests

SELLER:

* Access only own data
* Access only own inventory
* Access only own sales
* Create stock requests

A seller must never access another seller's data.

Always enforce ownership validation.

Never skip authorization.

---

### Validation

Use Zod for validation.

Every API must have:

Request Schema
Response Schema

Validation must execute before controller.

Never trust frontend payloads.

---

### API Response Format

Success:

{
"success": true,
"message": "",
"data": {}
}

Error:

{
"success": false,
"message": "",
"error_code": ""
}

All APIs must use the same format.

---

### Controller Rules

Controllers are thin.

Responsibilities:

* Receive request
* Call service
* Return response

Controllers must not:

* Write business logic
* Access database
* Contain calculations

Bad:

Controller
→ Prisma

Good:

Controller
→ Service

---

### Service Rules

Services contain business logic.

Examples:

* Transfer inventory
* Create sale
* Approve stock request

Services may call multiple repositories.

Services must not call other module models directly.

Services should reuse existing services when appropriate.

Before creating a new function:

1. Check if implementation already exists.
2. Reuse existing logic.
3. Avoid duplicate business logic.

---

### Repository Rules

Repositories handle database access.

Responsibilities:

* Prisma queries
* Data retrieval
* Data persistence

Repositories must not contain business logic.

Bad:

InventoryRepository:

* Check permissions
* Calculate stock

Good:

InventoryRepository:

* findInventory()
* updateInventory()
* createInventory()

---

### Model Rules

Separate models properly.

Request Models

Example:

CreateSaleRequest

Response Models

Example:

CreateSaleResponse

Domain Models

Example:

SaleModel

Do not mix request and response models.

Do not reuse unrelated models between modules.

Use Generic API Models.

Example:

ApiResponse<T>

PaginatedResponse<T>

---

### Inventory Rules

Current MVP:

Quantity Based Inventory

Example:

Battery Type A = 100

Future:

Serial Number Based Inventory

Architecture must support future migration.

Do not hardcode quantity-only assumptions.

---

### Soft Delete Rules

Never permanently delete records.

Use:

is_deleted = true

or

deleted_at timestamp

All queries must exclude deleted records by default.

---

### Audit Logging

Automatically create audit logs for:

* Login
* User Creation
* Inventory Transfer
* Sale Creation
* Stock Request Creation
* Stock Request Approval
* Inventory Adjustment

Audit logs must never be skipped.

---

### Reusability Rules

Before creating:

* Repository
* Service
* Validator
* Utility

Check existing implementation.

Reuse existing code whenever possible.

Avoid duplicate functions.

Avoid duplicate queries.

Avoid duplicate validators.

---

### Security Rules

Never expose passwords.

Never expose internal IDs unnecessarily.

Never trust frontend role values.

Never trust frontend ownership values.

Always validate authenticated user.

Always verify seller ownership.

Always verify permissions.

Authentication and authorization are mandatory.

Never skip them.

---

### AI Agent Instructions

Before generating code:

1. Read this file.
2. Follow architecture exactly.
3. Reuse existing modules where possible.
4. Do not introduce new patterns.
5. Do not bypass middleware.
6. Do not bypass repositories.
7. Do not skip authentication.
8. Do not skip authorization.
9. Do not duplicate logic.
10. Maintain consistency across modules.
