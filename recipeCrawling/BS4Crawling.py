from bs4 import BeautifulSoup
import requests

class bs4Crwaling:
    def get_url(self, url):
        headers = {"User-Agent": "Chrome/63.0.3239.132 (Windows NT 6.3; Win64; x64)"}
        request = requests.get(url, headers=headers)
        soup = BeautifulSoup(request.text, "html.parser")

        list = soup.find_all("li", class_='common_sp_list_li')  # 제목 링크
        self.food_list = []
        for data in list:
            self.food_list_data = []
            title = data.find("div", class_="common_sp_caption_tit line2").text
            img = data.select("div.common_sp_thumb > a > img")[0]["src"]
            readcount = data.find("span", class_="common_sp_caption_buyer").text  # 레시피 제목
            readcount = int((((readcount.replace("조회수", "")).replace("만", "000")).replace(".", "")).replace(",", ""))
            recipe_link = "https://www.10000recipe.com/"+data.a.attrs.get("href")
            self.food_list_data.append(title)
            self.food_list_data.append(img)
            self.food_list_data.append(recipe_link)
            self.food_list_data.append(readcount)
            self.food_list.append(self.food_list_data)

        return self.food_list