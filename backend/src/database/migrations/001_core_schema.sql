-- Enable pgcrypto for UUID generation
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Enums
CREATE TYPE user_role AS ENUM ('SUPER_ADMIN', 'SELLER');
CREATE TYPE product_unit_status AS ENUM ('IN_WAREHOUSE', 'AT_SHOP', 'SOLD', 'RETURNED', 'UNDER_INSPECTION', 'REPLACED', 'SCRAPPED');
CREATE TYPE owner_type AS ENUM ('WHOLESALER', 'SHOP', 'CUSTOMER');
CREATE TYPE transaction_type AS ENUM ('RECEIVED', 'TRANSFERRED', 'SOLD', 'RETURNED', 'REPLACED', 'SCRAPPED');
CREATE TYPE stock_request_status AS ENUM ('PENDING', 'APPROVED', 'REJECTED');
CREATE TYPE return_status AS ENUM ('PENDING', 'UNDER_INSPECTION', 'APPROVED', 'REJECTED', 'REPLACED', 'REPAIRED', 'SCRAPPED');

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
    shop_name TEXT NOT NULL,
    owner_name TEXT NOT NULL,
    mobile TEXT NOT NULL,
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
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4.5. products
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_subgroup_id UUID NOT NULL REFERENCES product_subgroups(id),
    brand_name TEXT NOT NULL,
    model_name TEXT NOT NULL,
    capacity TEXT NOT NULL,
    warranty_months INT NOT NULL,
    minimum_selling_price NUMERIC NOT NULL,
    is_serialized BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. product_units
CREATE TABLE product_units (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    serial_number TEXT UNIQUE NOT NULL,
    product_id UUID NOT NULL REFERENCES products(id),
    manufacturing_date DATE,
    received_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    status product_unit_status NOT NULL DEFAULT 'IN_WAREHOUSE',
    current_owner_type owner_type NOT NULL,
    current_owner_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. customers
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name TEXT NOT NULL,
    mobile TEXT UNIQUE NOT NULL,
    vehicle_number TEXT,
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 7. inventory_transactions
CREATE TABLE inventory_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_unit_id UUID REFERENCES product_units(id),
    product_id UUID REFERENCES products(id),
    quantity INT NOT NULL DEFAULT 1,
    transaction_type transaction_type NOT NULL,
    from_owner_type owner_type NOT NULL,
    from_owner_id UUID,
    to_owner_type owner_type NOT NULL,
    to_owner_id UUID,
    performed_by_user_id UUID NOT NULL REFERENCES users(id),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 8. sales
CREATE TABLE sales (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_unit_id UUID UNIQUE REFERENCES product_units(id),
    product_id UUID REFERENCES products(id),
    quantity INT NOT NULL DEFAULT 1,
    customer_id UUID NOT NULL REFERENCES customers(id),
    shop_id UUID NOT NULL REFERENCES shops(id),
    sold_by_user_id UUID NOT NULL REFERENCES users(id),
    sale_price NUMERIC NOT NULL,
    sale_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 8. stock_requests
CREATE TABLE stock_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES shops(id),
    status stock_request_status NOT NULL DEFAULT 'PENDING',
    requested_by_user_id UUID NOT NULL REFERENCES users(id),
    reviewed_by_user_id UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 8.5 stock_request_items
CREATE TABLE stock_request_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    stock_request_id UUID NOT NULL REFERENCES stock_requests(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id),
    requested_quantity INT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 9. customers
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name TEXT NOT NULL,
    mobile TEXT UNIQUE NOT NULL,
    vehicle_number TEXT,
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 10. returns
CREATE TABLE returns (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sale_id UUID NOT NULL REFERENCES sales(id),
    product_unit_id UUID NOT NULL REFERENCES product_units(id),
    return_reason TEXT NOT NULL,
    status return_status NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 11. replacements
CREATE TABLE replacements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    return_id UUID UNIQUE NOT NULL REFERENCES returns(id),
    old_product_unit_id UUID NOT NULL REFERENCES product_units(id),
    new_product_unit_id UUID NOT NULL REFERENCES product_units(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 12. audit_logs
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    entity_name TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    action TEXT NOT NULL,
    old_data JSONB,
    new_data JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 13. shop_inventory_aggregates
CREATE TABLE shop_inventory_aggregates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID NOT NULL REFERENCES shops(id),
    product_id UUID NOT NULL REFERENCES products(id),
    quantity INT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(shop_id, product_id)
);

-- Indexes
CREATE INDEX idx_product_units_serial_number ON product_units(serial_number);
CREATE INDEX idx_product_units_status_owner ON product_units(status, current_owner_id);
CREATE INDEX idx_inventory_transactions_product_unit_id ON inventory_transactions(product_unit_id);
CREATE INDEX idx_sales_shop_id ON sales(shop_id);
CREATE INDEX idx_sales_customer_id ON sales(customer_id);
CREATE INDEX idx_audit_logs_entity ON audit_logs(entity_name, entity_id);
CREATE INDEX idx_audit_logs_action ON audit_logs(action);
