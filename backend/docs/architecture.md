# Friends Battery Backend Architecture

This document contains the architectural diagrams for the Friends Battery inventory and sales management application, designed for scalability and strict inventory traceability.

## 1. High-Level System Architecture Diagram

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

## 2. Backend Internal Architecture Diagram

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

## 3. Request Flow Diagram

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

## 4. Inventory Transfer Flow Diagram

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

## 5. Battery Traceability Flow Diagram

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
