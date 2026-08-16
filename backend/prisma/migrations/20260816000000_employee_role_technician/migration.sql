-- Job titles for shop sales vs field service. Permissions come later.
INSERT INTO "employee_roles" ("name", "description") VALUES
  ('Cashier', 'Sells batteries at the shop'),
  ('Sales Executive', 'Sells batteries at the shop'),
  ('Technician', 'Goes to other locations to service or repair'),
  ('Warehouse Staff', 'Warehouse stock operations')
ON CONFLICT ("name") DO NOTHING;
