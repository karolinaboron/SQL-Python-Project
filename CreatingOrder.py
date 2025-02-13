import mariadb
from datetime import datetime
import random
import os
from dotenv import load_dotenv

load_dotenv()

user = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')
host = os.getenv('DB_HOST')
database = os.getenv('DB_DATABASE')
port = int(os.getenv('DB_PORT'))

conn = mariadb.connect(
    user=user,
    password=password,
    host=host,
    database=database,
    port=port
)

cur = conn.cursor()
 
def display_menu():
    print("\n--- MENU ---")
    cur.execute("SELECT id, name, category, price, availability FROM Menu WHERE availability = TRUE")
    for item in cur:
        print(f"{item[0]}. {item[1]} ({item[2]}) - {item[3]:.2f} PLN")
 
def select_table():
    print("\n--- Available Tables ---")
    cur.execute("SELECT id, seats FROM Tables")
    for table in cur:
        print(f"Table {table[0]}: {table[1]} seats")
    table_id = int(input("\nSelect the table number: "))
    return table_id

 
def select_employee():
    """Manually select a waiter or automatically assign a waiter."""
    print("\nDo you want to select a waiter manually or automatically?")
    print("1. Manually select a waiter")
    print("2. Automatically assign a waiter")
    choice = input("Choose an option: ")
 
    if choice == "1":
        # Manual waiter selection
        print("\n--- Waiters ---")
        cur.execute("SELECT id, name FROM Employees WHERE role = 'Waiter'")
        employees = cur.fetchall()
        if not employees:
            print("No available waiters.")
            return None
        for employee in employees:
            print(f"{employee[0]}. {employee[1]}")
        employee_id = int(input("\nSelect waiter number: "))
        return employee_id
 
    elif choice == "2":
         # Automatic waiter assignment
        print("\n--- Waiters ---")
        cur.execute("SELECT id, name FROM Employees WHERE role = 'Waiter'")
        employees = cur.fetchall()
        if not employees:
            print("No available waiters.")
            return None
        employee = random.choice(employees)  # Randomly select a waiter
        print(f"Selected waiter: {employee[1]}")
        return employee[0]  # Return waiter id
 
    else:
        print("Invalid choice. Please try again.")
        return None
 
def create_reservation(table_id, employee_id):
    print("\n--- Creating a reservation ---")
    # Asking for the name of the person making the reservation
    customer_name = input("Enter the name of the person making the reservation: ")
    reservation_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    # Query to the database
    cur.execute("INSERT INTO Reservations (table_id, employee_id, customer_name, reservation_date, status) VALUES (%s, %s, %s, %s, %s)",
                (table_id, employee_id, customer_name, reservation_date, "Pending"))
    conn.commit()
    reservation_id = cur.lastrowid
 
    print("\nThe reservation has been saved. Details:")
    print(f"Reservation number: {reservation_id}")
    print(f"Table number: {table_id}")
    print(f"Reservation date and time: {reservation_date}")
    # Getting the waiter's name
    cur.execute("SELECT name FROM Employees WHERE id = %s", (employee_id,))
    employee = cur.fetchone()
    print(f"Waiter: {employee[0]}")
    print(f"Reservation status: Pending")
    return reservation_id
 
def create_order(table_id, employee_id):
    """Placing an order within a reservation."""
    print("\n--- Placing an order ---")
    order_items = []
    while True:
        display_menu()
        item_id = int(input("Enter the menu item number (0 to finish): "))
        if item_id == 0:
            break
        order_items.append(item_id)
    if not order_items:
        print("No items selected. The order is canceled.")
        return

    # Calculate the total cost of the order
    total_price = 0
    for item_id in order_items:
        cur.execute("SELECT price FROM Menu WHERE id = ?", (item_id,))
        item = cur.fetchone()
        if item:
            total_price += item[0]  # Summing up the price of the order items

    # Ask for the preferred payment method
    print("\n--- Preferred payment method ---")
    print("1. Cash")
    print("2. Card")
    payment_choice = input("Choose payment method: ")
    if payment_choice == "1":
        payment_method = "Cash"
    elif payment_choice == "2":
        payment_method = "Card"
    else:
        print("Invalid choice. Default set to 'Cash'.")
        payment_method = "Cash"

    # Save the order in the Orders table
    order_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    cur.execute(
        "INSERT INTO Orders (table_id, employee_id, order_date, status) VALUES (?, ?, ?, ?)",
        (table_id, employee_id, order_date, "Pending")
    )
    conn.commit()
    order_id = cur.lastrowid

    # Add the payment to the Payments table
    payment_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    cur.execute(
        "INSERT INTO Payments (order_id, payment_date, amount, payment_method) VALUES (?, ?, ?, ?)",
        (order_id, payment_date, total_price, payment_method)
    )
    conn.commit()
    
    # Display the full order summary
    print("\n--- Order Summary ---")
    # Retrieve the order details
    print(f"Order number: {order_id}")
    print(f"Table number: {table_id}")
    print(f"Order date and time: {order_date}")
    print(f"Payment method: {payment_method}")
    print(f"Total order price: {total_price:.2f} PLN")
    print("\nOrder items:")
    for item_id in order_items:
        cur.execute("SELECT name, price FROM Menu WHERE id = ?", (item_id,))
        item = cur.fetchone()
        if item:
            print(f"- {item[0]}: {item[1]:.2f} PLN")

    # Get the waiter's name
    cur.execute("SELECT name FROM Employees WHERE id = ?", (employee_id,))
    employee = cur.fetchone()
    print(f"\nWaiter: {employee[0]}")
    print(f"Order status: Pending")
 

def main():
    """Main function of the program."""
    print("Welcome to the reservation and ordering system!")
    while True:
        print("\n--- MAIN MENU ---")
        print("1. Make a reservation and place an order")
        print("0. Exit")
        choice = input("Choose an option: ")
        if choice == "1":
            table_id = select_table()
            employee_id = select_employee()  # Waiter assigned manually or automatically
            if employee_id is not None:
                reservation_id = create_reservation(table_id, employee_id)
                create_order(table_id, employee_id)  # Changed here
            else:
                print("Unable to assign a waiter. Please try again later.")
        elif choice == "0":
            print("Goodbye!")
            break
        else:
            print("Invalid choice. Please try again.")
 
main()

conn.close()
