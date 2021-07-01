from datetime import datetime, timedelta
from bs4 import BeautifulSoup
import requests
import telegram
from hotdeal_app.models import Deal

BOT_TOKEN = "1773367772:AAEnUykGiSM1QP5RnmkdnRW0zSQMLtZ6g9w"

response = requests.get("http://www.ppomppu.co.kr/zboard/zboard.php?id=ppomppu")
soup = BeautifulSoup(response.text, "html.parser")

bot = telegram.Bot(token=BOT_TOKEN)
def run():
    
    row, _ = Deal.objects.filter(create_at__lte = datetime.now() - timedelta(days=3)).delete()
    print(row,"deals deleted")

    for item in soup.find_all("tr", {'class': ["list1", "list0"]}):
        try: 
            image = item.find("img", class_="thumb_border").get("src")[2:]
            image = "http://" + image
            title = item.find("font", class_="list_title").text
            title = title.strip()
            link = item.find("font", class_="list_title").parent.get("href")
            link = "http://www.ppomppu.co.kr/zboard/" + link
            reply_count = item.find("span", class_="list_comment2").text
            reply_count = int(reply_count)
            up_count = item.find_all("td")[-2].text
            up_count = up_count.split("-")[0]
            up_count = int(up_count)
            if up_count >= 5:
                if (Deal.objects.filter(link__iexact = link).count() == 0):
                    Deal(image_url=image, title=title, link=link, reply_count=reply_count, up_count=up_count).save()
                    bot.sendMessage(-1001450739267,'{}{}'.format(title, link))
        except Exception as e:
            continue
