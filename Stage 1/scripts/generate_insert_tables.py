import random
from datetime import date, timedelta

f = open("dbfiles/insertTables.sql", "a", encoding="utf-8")

random.seed(1)

# -------------------------
# Customers (6–500)
# -------------------------
f.write("\n-- Python generated Customers\n")
for i in range(6, 501):
    f.write(f"INSERT INTO Customer VALUES ({i}, 'Customer {i}', '050{i:07d}');\n")

# -------------------------
# RestaurantTable (6–500)
# -------------------------
statuses = ["available", "reserved", "occupied"]
f.write("\n-- Python generated RestaurantTable\n")
for i in range(6, 501):
    capacity = random.choice([2,4,6,8])
    status = random.choice(statuses)
    f.write(f"INSERT INTO RestaurantTable VALUES ({i}, {capacity}, '{status}');\n")

# -------------------------
# MenuItem (6–500)
# -------------------------
categories = ["Salad", "Main", "Pizza", "Dessert", "Drink"]
f.write("\n-- Python generated MenuItem\n")
for i in range(6, 501):
    name = f"Item {i}"
    category = random.choice(categories)
    price = round(random.uniform(20,100),2)
    availability = random.choice(["true","false"])
    f.write(f"INSERT INTO MenuItem VALUES ({i}, '{name}', '{category}', {price}, {availability});\n")

# -------------------------
# Reservation (6–500)
# -------------------------
start = date(2026,5,1)
f.write("\n-- Python generated Reservation\n")
for i in range(6, 501):
    d = start + timedelta(days=random.randint(0,60))
    t = f"{random.randint(10,22)}:{random.choice(['00','30'])}"
    guests = random.randint(1,8)
    customer = random.randint(1,500)
    table = random.randint(1,500)
    f.write(f"INSERT INTO Reservation VALUES ({i}, '{d}', '{t}', {guests}, {customer}, {table});\n")

# -------------------------
# Orders (1–20000)
# -------------------------
statuses = ["pending","preparing","served","cancelled"]
f.write("\n-- Python generated Orders\n")
for i in range(1, 20001):
    t = f"{random.randint(10,23)}:{random.choice(['00','15','30','45'])}"
    status = random.choice(statuses)
    price = round(random.uniform(20,300),2)
    table = random.randint(1,500)
    f.write(f"INSERT INTO Orders VALUES ({i}, '{t}', '{status}', {price}, {table});\n")

# -------------------------
# OrderItem (1–20000)
# -------------------------
f.write("\n-- Python generated OrderItem\n")
for i in range(1, 20001):
    qty = random.randint(1,5)
    order = random.randint(1,20000)
    item = random.randint(1,500)
    f.write(f"INSERT INTO OrderItem VALUES ({i}, {qty}, {order}, {item});\n")

f.close()
print("DONE ✔")