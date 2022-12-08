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

    def save_news_crawling(self, title, date, link):
        tp_value = ()
        cursor = ''
        for i in range(len(title)):
            #tp_value = ("'"+title[i]+"'", "to_date('"+date[i]+"','YYYY/MM/DD HH24:MI:SS')", link[i])
            tp_value = (title[i], date[i], link[i])
            query = "insert into news(NEWS_NO,NEWS_TITLE,NEWS_DATE,NEWS_LINK) values (default, :1, :2, :3)"
            try:
                cursor = self.conn.cursor()
                cursor.execute(query, tp_value)  # execute할때 튜플을 넣어 쿼리문에 적용시킴
                self.commit_conn()
            except Exception as msg:
                print(msg)
                print("오류 발생")
                self.conn.rollback()
                cursor.close()
                continue
            finally:
                continue