-- Enable pgcrypto for UUID generation
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Enums
CREATE TYPE user_role AS ENUM ('SUPER_ADMIN', 'SELLER');
CREATE TYPE product_unit_status AS ENUM ('IN_WAREHOUSE', 'IN_TRANSIT', 'WITH_SHOP', 'SOLD');
CREATE TYPE owner_type AS ENUM ('WHOLESALER', 'SHOP');
CREATE TYPE transaction_type AS ENUM ('TRANSFER', 'SALE', 'RESTOCK_APPROVED');
CREATE TYPE stock_request_status AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- 1. users
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role user_role NOT NULL,
    shop_id UUID, -- FK to shops (added later to avoid circular dependency since shops is created next)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. shops
CREATE TABLE shops (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add foreign key from users to shops now that shops exists
ALTER TABLE users ADD CONSTRAINT fk_users_shop FOREIGN KEY (shop_id) REFERENCES shops(id);

-- 3. product_groups
CREATE TABLE product_groups (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. product_subgroups
CREATE TABLE product_subgroups (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_group_id UUID NOT NULL REFERENCES product_groups(id),
    name TEXT NOT NULL,
    min_selling_price NUMERIC NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. product_units
CREATE TABLE product_units (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    serial_number TEXT UNIQUE NOT NULL,
    product_subgroup_id UUID NOT NULL REFERENCES product_subgroups(id),
    status product_unit_status NOT NULL DEFAULT 'IN_WAREHOUSE',
    current_owner_type owner_type NOT NULL,
    current_owner_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. inventory_transactions
CREATE TABLE inventory_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_unit_id UUID NOT NULL REFERENCES product_units(id),
    transaction_type transaction_type NOT NULL,
    from_owner_type owner_type,
    from_owner_id UUID,
    to_owner_type owner_type,
    to_owner_id UUID,
    performed_by_user_id UUID NOT NULL REFERENCES users(id),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 7. sales
CREATE TABLE sales (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_unit_id UUID UNIQUE NOT NULL REFERENCES product_units(id),
    shop_id UUID NOT NULL REFERENCES shops(id),
    sold_by_user_id UUID NOT NULL REFERENCES users(id),
    customer_name TEXT NOT NULL,
    customer_mobile TEXT NOT NULL,
    sale_price NUMERIC NOT NULL,
    min_price_at_sale NUMERIC NOT NULL,
    sale_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 8. stock_requests
CREATE TABLE stock_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES shops(id),
    product_subgroup_id UUID NOT NULL REFERENCES product_subgroups(id),
    requested_quantity INT NOT NULL,
    status stock_request_status NOT NULL DEFAULT 'PENDING',
    requested_by_user_id UUID NOT NULL REFERENCES users(id),
    reviewed_by_user_id UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_product_units_serial_number ON product_units(serial_number);
CREATE INDEX idx_product_units_status_owner ON product_units(status, current_owner_id);
CREATE INDEX idx_inventory_transactions_product_unit_id ON inventory_transactions(product_unit_id);
CREATE INDEX idx_sales_shop_id ON sales(shop_id);
