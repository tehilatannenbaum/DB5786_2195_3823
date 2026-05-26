Created using Google AI Studio

# Hotel Management System – Restaurant Module (Dairy Only)

## 📌 Project Overview
This project focuses on the Restaurant & Food module of a hotel management system.  
The system is designed for a **dairy-only restaurant**, meaning all menu items are dairy or vegetarian, with no meat or fish products.

The goal is to provide an intuitive and modern interface for managing restaurant operations, including menu management, orders, reservations, and analytics.

---

## 🖥️ UI Screens (Google AI Studio)

https://ai.studio/apps/3cb0f4c9-3878-4d29-a612-cc7284a6e892

### 🔹 Screen 1 – Dashboard
![Dashboard](images/Dashboard.png)

This dashboard provides an overview of restaurant activity, including total orders, revenue, table occupancy, and popular dishes.  
It helps managers monitor performance and make quick decisions.

---

### 🔹 Screen 2 – Menu Management
![Menu](images/Menu.png)

This screen displays all menu items in a dairy-only restaurant.  
Managers can view dishes, categories, prices, and availability in a clear and organized layout.

---

### 🔹 Screen 3 – Order Management
![Orders](images/Orders.png)

This screen allows staff to manage and track customer orders in real-time.  
Orders are displayed with table number, items, and status (Pending, Preparing, Ready, Served).

---

### 🔹 Screen 4 – Table Reservation
![Reservation](images/Reservation.png)

This screen allows booking and managing table reservations.  
Users can enter customer details, date, time, and number of guests.

---

## 🏢 Organization Description
The system represents a hotel restaurant called **"DairyDelight"**, which serves only dairy and vegetarian food.  
It is designed to improve efficiency in daily operations, enhance user experience, and provide clear management tools for restaurant staff and managers.

---

## 🗄️ ER Diagram

![ER Diagram](images/ERD.png)

The system is based on several main entities:

- Customer – stores customer details (id, name, phone)  
- Reservation – stores reservation details (date, time, number of guests)  
- RestaurantTable – represents tables in the restaurant (capacity, status)  
- Order – represents orders made in the restaurant  
- OrderItem – connects between orders and menu items  
- MenuItem – represents dishes in the menu (name, category, price, availability)  

### Relationships:

- A Customer makes Reservations (one customer can have multiple reservations)  
- Each Reservation is assigned to one Table  
- A Table can have multiple Orders  
- An Order contains multiple OrderItems  
- Each OrderItem is linked to one MenuItem

## 🗂️ Database Schema Diagram (DSD)

![DSD](images/DSD.png)

The Database Schema Diagram (DSD) represents the relational structure of the restaurant module after converting the ERD into database tables.

It shows the primary keys and foreign keys used to connect the entities in the system and reflects how the data will actually be stored in the database.

### Main Tables in the DSD:

- **Customer** – stores customer information such as `customer_id`, `name`, and `phone`
- **Reservation** – stores reservation details such as `reservation_id`, `date`, `time`, `number_of_guests`, and links to the customer and table
- **RestaurantTable** – stores restaurant table details such as `table_id`, `capacity`, and `status`
- **Orders** – stores order information such as `order_id`, `order_time`, `status`, `total_price`, and the related table
- **OrderItem** – a junction table that connects orders with menu items and stores the quantity of each item in the order
- **MenuItem** – stores menu dish information such as `item_id`, `name`, `category`, `price`, and `availability`

### Foreign Key Relationships:

- `Reservation.customer_id` → `Customer.customer_id`
- `Reservation.table_id` → `RestaurantTable.table_id`
- `Orders.table_id` → `RestaurantTable.table_id`
- `OrderItem.order_id` → `Orders.order_id`
- `OrderItem.item_id` → `MenuItem.item_id`

### Purpose of the DSD:

The DSD helps translate the conceptual ERD design into an actual relational database structure.  
It ensures that the tables are properly connected, reduces redundancy, and supports efficient data storage and retrieval.

# Data Dictionary

This data dictionary describes the database tables of the restaurant management system.  
It includes the purpose of each table, its attributes, primary keys, foreign keys, and constraints.

---

## Customer
**Purpose:** Stores information about restaurant customers.

| Field | Type | Description |
|------|------|------------|
| customer_id | INT | Unique identifier for each customer |
| name | VARCHAR(100) | Customer full name |
| phone | VARCHAR(20) | Customer phone number |

**Primary Key:**  
- customer_id  

**Constraints:**  
- All fields are NOT NULL  
- phone is UNIQUE  

---

## RestaurantTable
**Purpose:** Stores information about restaurant tables.

| Field | Type | Description |
|------|------|------------|
| table_id | INT | Unique identifier for each table |
| capacity | INT | Number of seats at the table |
| status | VARCHAR(20) | Current table status |

**Primary Key:**  
- table_id  

**Constraints:**  
- capacity > 0  
- status IN ('available', 'reserved', 'occupied')  

---

## Reservation
**Purpose:** Stores reservations made by customers.

| Field | Type | Description |
|------|------|------------|
| reservation_id | INT | Unique identifier for each reservation |
| date | DATE | Reservation date |
| time | TIME | Reservation time |
| number_of_guests | INT | Number of guests |
| customer_id | INT | Related customer |
| table_id | INT | Assigned table |

**Primary Key:**  
- reservation_id  

**Foreign Keys:**  
- customer_id → Customer(customer_id)  
- table_id → RestaurantTable(table_id)  

**Constraints:**  
- number_of_guests > 0  
- All fields are NOT NULL  

---

## Orders
**Purpose:** Stores food orders in the restaurant.

| Field | Type | Description |
|------|------|------------|
| order_id | INT | Unique identifier for each order |
| order_time | TIME | Time of the order |
| status | VARCHAR(20) | Order status |
| total_price | DECIMAL(10,2) | Total order price |
| table_id | INT | Table that placed the order |

**Primary Key:**  
- order_id  

**Foreign Keys:**  
- table_id → RestaurantTable(table_id)  

**Constraints:**  
- total_price >= 0  
- status IN ('pending', 'preparing', 'served', 'cancelled')  
- All fields are NOT NULL  

---

## MenuItem
**Purpose:** Stores menu items offered by the restaurant.

| Field | Type | Description |
|------|------|------------|
| item_id | INT | Unique identifier for each item |
| name | VARCHAR(100) | Item name |
| category | VARCHAR(50) | Item category |
| price | DECIMAL(10,2) | Item price |
| availability | BOOLEAN | Availability status |

**Primary Key:**  
- item_id  

**Constraints:**  
- price >= 0  
- All fields are NOT NULL  

---

## OrderItem
**Purpose:** Links orders with menu items and stores quantities.

| Field | Type | Description |
|------|------|------------|
| order_item_id | INT | Unique identifier |
| quantity | INT | Quantity ordered |
| order_id | INT | Related order |
| item_id | INT | Related menu item |

**Primary Key:**  
- order_item_id  

**Foreign Keys:**  
- order_id → Orders(order_id)  
- item_id → MenuItem(item_id)  

**Constraints:**  
- quantity > 0  
- All fields are NOT NULL  

---

## Summary
The database is designed in Third Normal Form (3NF).  
Each table represents a single entity, and all attributes depend only on the primary key.  
Constraints are used to ensure data integrity and prevent invalid data entry.

### createTables.sql


### dropTables.sql

This file contains DROP TABLE commands for deleting all database tables in an order that respects the foreign key dependencies between them.  
The dependent tables are dropped first, allowing the script to run smoothly without constraint errors.

### Backup Process:

We created a backup of the database using two different methods:

1. Command line:
We used the pg_dump command through Docker:
docker exec db_postgres pg_dump -U admin -d restaurant > backup_01_05_26.sql

2. pgAdmin UI:
We used the Backup option from pgAdmin.

To verify the backup, we restored it into a new database named "restaurant_backup" using:
Get-Content backup_01_05_26.sql | docker exec -i db_postgres psql -U admin -d restaurant_backup

We confirmed that the restore was successful by checking that all tables and data were correctly loaded.

### STAGE 2:
# הסבר על השאילתות

## Query 1A – לקוחות עם מספר ההזמנות הגבוה ביותר (JOIN)

מטרת השאילתה היא להציג את הלקוחות שביצעו את מספר ההזמנות הגבוה ביותר במסעדה.

השאילתה מציגה:
- מזהה לקוח
- שם לקוח
- טלפון
- מספר ההזמנות
- מספר הסועדים הכולל

השאילתה משתמשת ב־JOIN בין הטבלאות Customer ו־Reservation ולאחר מכן מבצעת GROUP BY ו־COUNT לצורך חישוב מספר ההזמנות לכל לקוח.

---

## Query 1B – לקוחות עם מספר ההזמנות הגבוה ביותר (Subquery)

שאילתה זו מבצעת את אותה פעולה כמו Query 1A, אך משתמשת בתת־שאילתה (Subquery).

תחילה מתבצע חישוב של מספר ההזמנות ומספר הסועדים לכל לקוח בתוך השאילתה הפנימית, ולאחר מכן מתבצע JOIN מול טבלת Customer כדי להציג את פרטי הלקוח.

### הבדל בין שתי הצורות

- Query 1A משתמשת ב־JOIN ישיר.
- Query 1B משתמשת ב־Subquery פנימית.

### מה יותר יעיל ומדוע

בדרך כלל JOIN ישיר יעיל יותר משום שמנוע בסיס הנתונים מבצע פחות שלבים ופחות יצירת טבלאות זמניות.

Subquery עלולה להיות פחות יעילה כאשר עובדים עם כמויות מידע גדולות.

---

## Query 2A – שולחנות ללא הזמנות (LEFT JOIN)

מטרת השאילתה היא למצוא שולחנות במסעדה שאין להם כלל הזמנות.

השאילתה מציגה:
- מספר שולחן
- קיבולת
- סטטוס
- מספר הזמנות

השאילתה משתמשת ב־LEFT JOIN בין RestaurantTable ל־Reservation ולאחר מכן מסננת באמצעות HAVING את השולחנות שאין להם הזמנות.

---

## Query 2B – שולחנות ללא הזמנות (NOT EXISTS)

שאילתה זו מבצעת את אותה פעולה כמו Query 2A, אך משתמשת ב־NOT EXISTS במקום LEFT JOIN.

השאילתה בודקת עבור כל שולחן האם קיימת עבורו הזמנה בטבלת Reservation.  
אם לא קיימת הזמנה, השולחן יוצג בתוצאה.

### הבדל בין שתי הצורות

- Query 2A משתמשת ב־LEFT JOIN + HAVING.
- Query 2B משתמשת ב־NOT EXISTS.

### מה יותר יעיל ומדוע

במקרים רבים NOT EXISTS יעיל יותר בטבלאות גדולות משום שהמערכת יכולה לעצור את הבדיקה ברגע שנמצאה התאמה.

לעומת זאת LEFT JOIN יוצר צירוף מלא של הטבלאות לפני הסינון.

---

## Query 3 – סטטיסטיקת הזמנות לפי חודש ושנה

מטרת השאילתה היא להציג סטטיסטיקות של הזמנות לפי חודש ושנה.

השאילתה מציגה:
- שנה
- חודש
- מספר הזמנות
- מספר סועדים כולל
- ממוצע סועדים להזמנה

השאילתה משתמשת בפונקציות EXTRACT כדי לפרק את שדה התאריך לשנה וחודש ולאחר מכן מבצעת GROUP BY לצורך חישוב הנתונים הסטטיסטיים.

שאילתה זו מתאימה למסך Dashboard או Analytics במערכת.

---

## Query 4 – הכנסות לפי קטגוריית מנות

מטרת השאילתה היא לחשב את ההכנסות מכל קטגוריית מנות במסעדה.

השאילתה מציגה:
- קטגוריית מנה
- מספר מנות בקטגוריה
- כמות פריטים שנמכרו
- הכנסה כוללת
- מחיר ממוצע

השאילתה משתמשת ב־JOIN בין MenuItem ל־OrderItem ולאחר מכן מבצעת GROUP BY לפי קטגוריה.

שאילתה זו מאפשרת למנהל המסעדה להבין אילו קטגוריות הן הרווחיות ביותר.

---

# הסבר על שאילתות UPDATE

## Update 1 – עדכון מנות לא זמינות

מטרת השאילתה היא לעדכן מנות שלא הוזמנו מעולם כלא זמינות (`availability = false`).

השאילתה בודקת אילו מנות אינן מופיעות בטבלת OrderItem ומעדכנת את סטטוס הזמינות שלהן.

---

## Update 2 – עדכון סטטוס שולחנות

מטרת השאילתה היא לעדכן את סטטוס השולחנות ל־`reserved` אם קיימת עבורם הזמנה עתידית.

השאילתה משתמשת בתת־שאילתה כדי למצוא שולחנות עם הזמנות עתידיות ולאחר מכן מעדכנת את הסטטוס שלהם.

---

## Update 3 – חישוב מחדש של מחיר הזמנה

מטרת השאילתה היא לחשב מחדש את המחיר הכולל של כל הזמנה לפי:
- כמות המנות
- מחיר כל מנה

השאילתה משתמשת ב־JOIN בין OrderItem ל־MenuItem ולאחר מכן מבצעת SUM של מחיר המנות כפול הכמות.

---

# הסבר על שאילתות DELETE

## Delete 1 – מחיקת הזמנות שבוטלו

מטרת השאילתה היא למחוק הזמנות שבוטלו (`cancelled`) מטבלת Orders.

השאילתה מסירה מידע שאינו רלוונטי יותר למערכת.

---

## Delete 2 – מחיקת הזמנות ישנות

מטרת השאילתה היא למחוק הזמנות משנים קודמות.

השאילתה משתמשת בפונקציית EXTRACT על שדה התאריך כדי לבדוק את שנת ההזמנה.

---

## Delete 3 – מחיקת מנות לא זמינות

מטרת השאילתה היא למחוק מנות שסומנו כלא זמינות מהתפריט.

השאילתה מסירה מנות שאינן פעילות יותר במערכת.
