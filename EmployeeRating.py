import mariadb 
import pandas as pd
import plotly.express as px
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

query = """
SELECT employee_id, change_date, average_rating
FROM EmployeeRatingHistory
ORDER BY employee_id, change_date;
"""

df = pd.read_sql(query, conn)


conn.close()


fig = px.line(
    df,
    x="change_date",
    y="average_rating",
    color="employee_id",
    title="Employee average rating over time",
    labels={
        "change_date": "Date",
        "average_rating": "Rate",
        "employee_id": "employee_id"
    },
    markers=True 
)

fig.show()
