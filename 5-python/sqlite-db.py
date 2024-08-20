# Using SQLite database

import sqlite3 as sql

class Database(object):
    def __init__(self):
        global con
        try:
            con = sql.connect("sample.s3db")
            with con:
                cur = con.cursor()
                cur.execute("""
                CREATE TABLE IF NOT EXISTS student(
                    _id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT,
                    course TEXT,
                    phone TEXT
                );""")
        except Exception as e:
            print("Unable to open connection, cause:", e)

    def read(self):
        try:
            with con:
                cur = con.cursor()
                cur.execute("SELECT * FROM student")
                return cur.fetchall()
        except Exception as e:
            print("Unable to read data, cause:", e)

    def insert(self, data):
        try:
            with con:
                cur = con.cursor()
                cur.execute("INSERT INTO student(name, course, phone) VALUES(?, ?, ?);", data)
                return True
        except Exception as e:
            print("Unable to insert data, cause:", e)
            return False

    def delete(self, id):
        try:
            with con:
                cur = con.cursor()
                cur.execute("DELETE FROM student WHERE _id = ?", [id])
                return True
        except Exception as e:
            print("Unable to delete data, cause:", e)
            return False

    def update(self, data):
        try:
            with con:
                cur = con.cursor()
                cur.execute("UPDATE student SET name = ?, course = ?, phone = ? WHERE _id = ?", data)
            return True
        except Exception as e:
            print("Unable to update data, cause:", e)
            return False

print("-" * 30)
print(":: STUDENT MANAGEMENT ::")
print("-" * 30)
print()
print("Press 1: Show all Stuents")
print("Press 2: Add new Student")
print("Press 3: Modify Student")
print("Press 4: Delete Student")
print("Press 0: quit")
print("-" * 30)

db = Database()

while True:
    choice = int(input("\nEnter your choice: "))
    if choice == 0:
        break

    if choice == 1:
        students = db.read()

        for no, student in enumerate(students):
            print("No.: #", no + 1)
            print("\tID: ", student[0])
            print("\tName: ", student[1])
            print("\tCourse: ", student[2])
            print("\tPhone: ", student[3])

    if choice == 2:
        name = input("Enter Student name: ")
        course = input("Enter course taken: ")
        phone = input("Enter student phonee number: ")

        if db.insert([name, course, phone]):
            print("Record inserted successfully!")
        else:
            print("Opps!, Something wants wrong!!!")

    if choice == 3:
        _id = int(input("Enter Student ID: "))
        name = input("Enter new name: ")
        cource = input("Enter New course: ")
        phone = input("Enter new phone no.: ")

        if db.update([name, cource, phone, _id]):
            print("Details updated successfully!")
        else:
            print("Opps!, Something wants wrong!!!")

    if choice == 4:
        id = int(input("Enter Student id: "))

        if db.delete(id):
            print("Student removed successfully!")
        else:
            print("Opps!, Something wants wrong!!!")
