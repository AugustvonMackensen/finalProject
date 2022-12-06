import cx_Oracle

class gammiDB:

    def __init__(self):
        cx_Oracle.init_oracle_client(lib_dir="C:\instantclient_21_6")
        self.conn = cx_Oracle.connect(user="ADMIN", password="Gammiproject!1", dsn="gammi2_high")
        self.conn.autocommit = False

    # conn 닫기
    def close_cone(self):
        self.conn.close()

    # 커밋
    def commit_conn(self):
        self.conn.commit()

    def save_oracle_crawling(self, coun):
        tp_value = ()
        cursor = ''
        for i in coun:
            tp_value = (i[0], i[1], i[2],i[3])

            query = "insert into recipe values (default, :1, :2, :3, :4, default)"
            try:
                cursor = self.conn.cursor()
                cursor.execute(query, tp_value)  # execute할때 튜플을 넣어 쿼리문에 적용시킴
                self.commit_conn()
            except:
                print("오류 발생")
                self.conn.rollback()
                cursor.close()
                continue
            finally:
                continue