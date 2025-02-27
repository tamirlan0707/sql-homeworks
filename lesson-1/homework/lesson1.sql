Users
---------
id (PK)
name
email
password
created_at

Products
-----------
id (PK)
name
description
price
stock
category_id FK >- Categories.id

Categories
------------
id (PK)
name

Order
--------
id (PK)
user_id FK - Users.id
total_price
status
created_at

Order_Items
------------
id PK
order_id FK >- Order.id
product_id FK >- Products.id
quantity
price

Payments
-----------
id PK
order_id FK >- Order.id
payment_method
amount
status
created_at

Reviews
-----------
id (PK)
user_id FK >- Users.id
product_id FK >- Products.id
rating
comment
created_at
