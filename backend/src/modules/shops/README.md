# Shop Module

## Overview
This module handles CRUD operations for the `Shop` entity. It relies on Prisma ORM to interact with the underlying PostgreSQL database.

## Entities

### Shop
The `Shop` model in Prisma has the following schema:
- `id`: UUID (Primary Key)
- `shopName`: String (Mapped to `shop_name` in DB)
- `ownerName`: String (Mapped to `owner_name` in DB)
- `mobile`: String
- `address`: String
- `created_at`: DateTime
- `updated_at`: DateTime

## Endpoints

All endpoints are prefixed with `/shops` and require JWT authentication via the `auth.middleware`. Modification endpoints (POST, PATCH, DELETE) require the `SUPER_ADMIN` role.

### 1. Create a Shop
- **Method:** `POST /shops`
- **Auth:** Requires JWT token & `SUPER_ADMIN` role.
- **Body:**
  ```json
  {
    "shopName": "My Awesome Shop",
    "ownerName": "John Doe",
    "mobile": "1234567890",
    "address": "123 Main St"
  }
  ```
- **Response:** 201 Created with the created shop object.

### 2. Get All Shops
- **Method:** `GET /shops`
- **Auth:** Requires JWT token.
- **Response:** 200 OK with an array of shop objects, ordered by newest first.

### 3. Get Shop By ID
- **Method:** `GET /shops/:id`
- **Auth:** Requires JWT token.
- **Response:** 200 OK with the shop object. Returns 404 if not found.

### 4. Update a Shop
- **Method:** `PATCH /shops/:id`
- **Auth:** Requires JWT token & `SUPER_ADMIN` role.
- **Body:** (Any of the fields can be optional)
  ```json
  {
    "shopName": "Updated Shop Name",
    "mobile": "0987654321"
  }
  ```
- **Response:** 200 OK with the updated shop object.

### 5. Delete a Shop
- **Method:** `DELETE /shops/:id`
- **Auth:** Requires JWT token & `SUPER_ADMIN` role.
- **Response:** 200 OK. Returns 404 if the shop was not found.
