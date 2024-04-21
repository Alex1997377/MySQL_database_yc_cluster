import pymysql as MySQLdb
from mysql.connector import errorcode
import mysql.connector
from SQL_values import Value_SQL
import os
from dotenv import load_dotenv
load_dotenv()

class Connect_cloud_ydb:
    def connect_database(self):
        try:
            connect = MySQLdb.connect(
                host = os.getenv("HOST"),
                port = int(os.getenv("PORT")),
                db = os.getenv("NAME_DATABASE"),
                user = os.getenv("NAME_USER"),
                passwd = os.getenv("PASSWORD"),
                ssl = {"ca": os.getenv("SSL_ROOT")})

            cursor = connect.cursor()

            self.add_user = Value_SQL()
            cursor.execute(self.add_user.create_table())
            #     cursor.execute(add_user,(data_user,))
            #     usr_no = cursor.lastrowid


            print(cursor.fetchone()[0])
            print("--successful request--")
            connect.commit()
            cursor.close()
            connect.close()
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Something is wrong with your user name or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print("Database does not exist")
            elif err.errno == errorcode.ER_DUP_ENTRY:
                print('Duplicate user_id')
            elif err.errno == errorcode.ER_DATA_TOO_LONG:
                print('Long iser_id sorry')
            else:
                print(err)

if __name__=="__main__":
    a = Connect_cloud_ydb()
    a.connect_database()