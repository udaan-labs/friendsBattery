# Gemini AI Context & Guidelines

## Project: Friends Battery Backend
This is the backend system for the Friends Battery application. It manages users, shops, product inventory, sales, and restock requests. 

## Technology Stack
- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: PostgreSQL (using `pg` driver, no ORM)
- **Validation**: Zod
- **Authentication**: JWT & bcrypt

## Project Structure
The project follows a modular architecture:
- `src/modules/`: Contains business logic grouped by domain (e.g., `auth/`, `sales/`). Each module typically has its own `routes.js`, `controller.js`, `service.js`, `repository.js`, and `validation.js`.
- `src/shared/`: Contains cross-cutting concerns like middlewares, constants, events, and utilities.
- `src/config/`: Contains environment (`env.js`), database (`db.js`), and logging (`logger.js`) configurations.
- `src/database/migrations/`: Contains raw SQL migration files.

## Core Architectural Rules (CRITICAL FOR AI TO FOLLOW)

1. **Inventory is Unit-Based**: 
   - One row in `product_units` equals one physical battery. 
   - **NEVER** create `quantity`, `stock_count`, or `current_stock` columns in tables like shops or products. The only exception is `stock_requests.requested_quantity`. 

2. **Immutable Ledger**: 
   - The `inventory_transactions` table acts as an immutable ledger. 
   - One row per status/ownership change of a `product_unit`. 
   - **NEVER** UPDATE or DELETE rows in `inventory_transactions` after insertion.

3. **Database Interactions**:
   - We use raw SQL queries via the `pg` pool (`src/config/db.js`). Do not introduce ORMs (like Prisma, Sequelize) unless explicitly requested by the USER.
   - Migrations are managed via standalone `.sql` scripts executed through `npm run migrate`.

4. **Authentication & Authorization**:
   - Endpoints are protected via `auth.middleware.js` (JWT parsing).
   - Role-based Access Control (RBAC) is enforced using `role.middleware.js` (e.g., `SUPER_ADMIN`, `SELLER`).

## Instructions for Gemini CLI & Agentic AI
- When making modifications, strictly adhere to the existing folder structure.
- Validate incoming data using `zod` schemas.
- Use the shared `response.js` utility for standardized API responses (`successResponse`, `errorResponse`).
- Read and respect the database schema rules above before planning any new inventory or sales features.
