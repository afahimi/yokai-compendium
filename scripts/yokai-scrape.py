from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests


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
        
attributes = {}

driver.get("https://yokaiwatch.github.io/characters/#/view/1")
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



print(stats)

print(attributes)


print(t1.get_attribute("class"))
print(attributes['class'])
time.sleep(5)

# getImages()