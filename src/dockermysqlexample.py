import os

import pymysql
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    try:
        connection = pymysql.connect(
            host=os.getenv("MYSQL_HOST", "localhost"),
            user=os.getenv("INSTALLER_USERID", "installer"),
            password=os.getenv("INSTALLER_PWD", "N0Pa55wrd"),
            database=os.getenv("MYSQL_DATABASE", "DockerMySqlExample"),
            port=int(os.getenv("MYSQL_TCP_PORT", 3306)),
        )
        with connection.cursor() as cursor:
            cursor.execute("SHOW DATABASES;")
            databases = cursor.fetchall()
        connection.close()
        return {"databases": databases}
    except Exception as e:
        return {"error": str(e)}
