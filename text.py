import pyodbc

# Kết nối tới SQL Server
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=TRONGDEPZAI;"
    "DATABASE=Personal_Finance_Bot_Web;"
    "Trusted_Connection=yes;"
)

cursor = conn.cursor()

# Ví dụ: lấy danh sách bảng trong database
cursor.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES")
for row in cursor.fetchall():
    print(row)

conn.close()
