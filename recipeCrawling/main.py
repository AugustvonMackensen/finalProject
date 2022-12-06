import BS4Crawling
import json
import oracle




def start():
    data = open('./kor_eng_foodtitle.json', 'r', encoding='utf-8').read()
    rom_kor_foodDict = json.loads(data)
    food_list = list(rom_kor_foodDict.values())     #음식리스트(한글)
    crawling = BS4Crawling.bs4Crwaling()
    foods = []
    ora = oracle.gammiDB()
    print("====크롤링====")
    for food in food_list:
        food_url = "https://www.10000recipe.com/recipe/list.html?q="+food
        foods.append(crawling.get_url(food_url))
    print("====db저장====")
    for food in foods:
        ora.save_oracle_crawling(food)
    ora.close_cone()

if __name__ == '__main__':
    start()