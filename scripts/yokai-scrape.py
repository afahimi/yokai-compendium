from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests
import json


options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")
options.add_argument('--log-level=3')
options.add_argument('--headless')


driver = webdriver.Chrome(options=options)
driver.set_window_size(1920,1080)

def getImages(name: str):
    for i in range(1,355):
        num_str = str(i).zfill(3)
        response = requests.get(f"http://yokaiwatch.github.io/common/Images/{num_str}.png", stream=True)
        response.raise_for_status()
        time.sleep(3)

        with open(f'./../yokai/{i}-{name}.jpg', 'wb') as file:
            for chunk in response.iter_content(8192):
                file.write(chunk)

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

file_path = "./../yokai/yokai.json"

with open(file_path, 'w') as file:
    json.dump(getStats(), file)

time.sleep(5)
# getImages()