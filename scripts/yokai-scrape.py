from selenium import webdriver
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import requests
import json


options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")
options.add_argument('--log-level=3')
options.add_argument('--headless')


driver = webdriver.Chrome(options=options)
driver.set_window_size(1920,1080)

def getIcons():
    driver.get("https://yokaiwatch.fandom.com/wiki/List_of_Yo-kai_by_Medallium_Number_(Yo-kai_Watch_2)")
    base = driver.find_element(By.CSS_SELECTOR, 'body > div:nth-of-type(4) > div:nth-of-type(4) > div:nth-of-type(3) > main').find_element(By.CLASS_NAME, 'mw-parser-output')
    images = []


    for i in range(1,10):
        table1 = base.find_element(By.CSS_SELECTOR, f'table:nth-of-type({i}) > tbody')
        rows = table1.find_elements(By.XPATH, './/tr')
        for i in range(len(rows)):
            if(i == 0):
                continue
            row = rows[i]
            img = row.find_element(By.CSS_SELECTOR, 'td:nth-of-type(2) > img')
            src = img.get_attribute('data-src')
            images.append(src)

    print(images)

    for i in range(len(images)):
        if images[i] == None:
            continue
        response = requests.get(images[i], stream=True)
        response.raise_for_status()

        with open(f'./../yokai/icons/{i+1}.png', 'wb') as file:
            for chunk in response.iter_content(8192):
                file.write(chunk)
    
    driver.quit()

def getAttributes():
    driver.get("https://yokaiwatch.fandom.com/wiki/List_of_Yo-kai_by_Medallium_Number_(Yo-kai_Watch_2)")
    base = driver.find_element(By.CSS_SELECTOR, 'body > div:nth-of-type(4) > div:nth-of-type(4) > div:nth-of-type(3) > main').find_element(By.CLASS_NAME, 'mw-parser-output')
    images = []


    for i in range(1,10):
        table1 = base.find_element(By.CSS_SELECTOR, f'table:nth-of-type({i}) > tbody')
        rows = table1.find_elements(By.XPATH, './/tr')
        for i in range(len(rows)):
            if(i == 0):
                continue
            row = rows[i]
            img = row.find_element(By.CSS_SELECTOR, 'td:nth-of-type(6) > a > img')
            src = img.get_attribute('data-src')
            images.append(src)

    print(images)

    for i in range(len(images)):
        if images[i] == None:
            continue
        response = requests.get(images[i], stream=True)
        response.raise_for_status()

        with open(f'./../yokai/attributes/{i+1}.png', 'wb') as file:
            for chunk in response.iter_content(8192):
                file.write(chunk)
    
    driver.quit()

def getImages(obj):
    for i in range(1,355):
        if i == 200:
            print("Kyrin not available on the database, please download manually")
            continue
        name = obj[i-1]["name"]
        num_str = str(i).zfill(3)
        response = requests.get(f"http://yokaiwatch.github.io/common/Images/{num_str}.png", stream=True)
        response.raise_for_status()

        with open(f'./../yokai/images/{i}-{name}.jpg', 'wb') as file:
            for chunk in response.iter_content(8192):
                file.write(chunk)


def getLinks3():
    hrefs = []

    driver.get("https://yokaiwatch.fandom.com/wiki/List_of_Yo-kai_by_Medallium_Number_(Yo-kai_Watch_3)")
    base = driver.find_element(By.CSS_SELECTOR, 'body > div:nth-of-type(4) > div:nth-of-type(4) > div:nth-of-type(3) > main').find_element(By.CLASS_NAME, 'mw-parser-output')

    time.sleep(5)

    for i in range(1,14):
        table1 = base.find_element(By.CSS_SELECTOR, f'table:nth-of-type({i}) > tbody')
        rows = table1.find_elements(By.XPATH, './/tr')
        for j in range(len(rows)):
            if(j == 0):
                continue
            row = rows[j]
            src = row.find_element(By.CSS_SELECTOR, 'td:nth-of-type(3) > a').get_attribute('href')
            print(src)
            hrefs.append(src)
    # write json to a file
    with open('./../yokai/yokai3links.json', 'w') as file:
        json.dump(hrefs, file)

def getStats3():
    # getLinks3() # call if you want to get the links again
    with open('./../yokai/yokai3links.json', 'r') as file:
        data = json.load(file)
    
    yokai = []
    images = []

    for i in range(len(data)):
        driver.get(data[i])
        attributes = {}
        attributes["number"] = i+1
        
        # Wait for the base element to be loaded
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, 'body > div:nth-of-type(4) > div:nth-of-type(4) > div:nth-of-type(3) > main'))
        )
        
        base = driver.find_element(By.CSS_SELECTOR, 'body > div:nth-of-type(4) > div:nth-of-type(4) > div:nth-of-type(3) > main').find_element(By.CLASS_NAME, 'mw-parser-output')
            
        # name
        attributes["name"] = base.find_element(By.CSS_SELECTOR, 'h2').text

        # tribe
        tribe_name = base.find_element(By.CSS_SELECTOR, 'aside > section > nav > a > img').get_attribute('alt')
        start = tribe_name.find("WibWob") + len("WibWob")
        end = tribe_name.find("Icon")
        attributes["tribe"] = tribe_name[start:end].strip()
        print(attributes["tribe"])

        # rank
        try:
            rank_img = WebDriverWait(base, 10).until(
                EC.presence_of_element_located((By.XPATH, ".//img[starts-with(@alt, 'Rank')]"))
            )
            attributes["rank"] = rank_img.get_attribute('alt')
            start = attributes["rank"].find("Rank") + len("Rank")
            end = attributes["rank"].find("icon")
            attributes["rank"] = attributes["rank"][start:end].strip()
        except TimeoutException:
            attributes["rank"] = "Not Found"
        # start = attributes["rank"].find("Rank") + len("Rank")
        # end = attributes["rank"].find("Icon")
        # attributes["rank"] = attributes["rank"][start:end].strip()
        print(attributes["rank"])




def getStats():
    yokai = []

    for i in range(1,355):
        attributes = {}
        attributes["number"] = i

        driver.get(f"https://yokaiwatch.github.io/characters/#/view/{i}")
        time.sleep(1)
        base = driver.find_element(By.CSS_SELECTOR, 'body > div > div:nth-of-type(2) > div > div > div')
        attributes["name"] = base.find_element(By.CSS_SELECTOR, 'div').text
        rest = base.find_element(By.CSS_SELECTOR, 'div:nth-of-type(2)')
        t1 = rest.find_element(By.CSS_SELECTOR, 'div:nth-of-type(2) > table > tbody > tr:nth-of-type(2)')
        elements = t1.find_elements(By.XPATH, './*')

        attributes['class'] = elements[0].text
        attributes['rank'] = elements[1].text
        attributes['element'] = elements[2].text

        t1 = rest.find_element(By.CSS_SELECTOR, 'div:nth-of-type(2) > table > tbody > tr:nth-of-type(4)')
        elements = t1.find_elements(By.XPATH, './*')

        attributes['food'] = elements[0].text
        attributes['phrase'] = elements[2].text

        stats = {}

        st = rest.find_element(By.CSS_SELECTOR, "div:nth-of-type(3) > table > tbody")
        l1 = st.find_element(By.CSS_SELECTOR, "tr").find_elements(By.XPATH, './*')
        l99 = st.find_element(By.CSS_SELECTOR, "tr:nth-of-type(2)").find_elements(By.XPATH, './*')

        stats["HP"] = (l1[1].text, l99[1].text)
        stats["strength"] = (l1[2].text, l99[2].text)
        stats["spirit"] = (l1[3].text, l99[3].text)
        stats["defense"] = (l1[4].text, l99[4].text)
        stats["speed"] = (l1[5].text, l99[5].text)
        attributes['stats'] = stats
        attributes["attacks"] = {}

        #normal attack
        attk = rest.find_element(By.CSS_SELECTOR, "div:nth-of-type(5) > table > tbody")
        attk = attk.find_elements(By.XPATH, "./*")
        attributes["attacks"]["normal"] = {}
        attributes["attacks"]["normal"]["name"] = attk[0].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > strong").text
        attributes["attacks"]["normal"]["power"] = attk[1].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > div").text

        #technique
        attk = rest.find_element(By.CSS_SELECTOR, "div:nth-of-type(6) > table > tbody")
        attk = attk.find_elements(By.XPATH, "./*")
        attributes["attacks"]["technique"] = {}
        attributes["attacks"]["technique"]["name"] = attk[0].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > strong").text
        attributes["attacks"]["technique"]["power"] = attk[1].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > div").text
        attributes["attacks"]["technique"]["range"] = attk[2].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > div").text

        #soultimate
        attk = rest.find_element(By.CSS_SELECTOR, "div:nth-of-type(7) > table > tbody")
        attk = attk.find_elements(By.XPATH, "./*")
        attributes["attacks"]["soultimate"] = {}
        attributes["attacks"]["soultimate"]["name"] = attk[0].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > strong").text
        attributes["attacks"]["soultimate"]["attribute"] = attk[1].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > div").text
        attributes["attacks"]["soultimate"]["power"] = attk[2].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > div").text
        attributes["attacks"]["soultimate"]["effect"] = attk[3].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > div").text
        attributes["attacks"]["soultimate"]["range"] = attk[4].find_element(By.CSS_SELECTOR, "td:nth-of-type(2) > div").text

        #inspirit
        attk = rest.find_element(By.CSS_SELECTOR, "div:nth-of-type(8) > table > tbody > tr > td:nth-of-type(2)")
        attributes["attacks"]["inspirit"] = {}
        attributes["attacks"]["inspirit"]["name"] = attk.find_element(By.CSS_SELECTOR, "strong").text
        attributes["attacks"]["inspirit"]["effect"] = attk.find_element(By.CSS_SELECTOR, "div").text

        #skill
        attk = rest.find_element(By.CSS_SELECTOR, "div:nth-of-type(9) > table > tbody > tr > td:nth-of-type(2)")
        attributes["attacks"]["skill"] = {}
        attributes["attacks"]["skill"]["name"] = attk.find_element(By.CSS_SELECTOR, "strong").text
        attributes["attacks"]["skill"]["effect"] = attk.find_element(By.CSS_SELECTOR, "div").text

        yokai.append(attributes)
    return yokai

if __name__ == "__main__":
    # file_path = "./../yokai/yokai.json"

    # with open(file_path, 'w') as file:
    #     json.dump(getStats(), file)

    # with open(file_path, 'r') as file:
    #     data = json.load(file)

    # getImages(data)
    # getIcons()
    # getAttributes()

    getStats3()