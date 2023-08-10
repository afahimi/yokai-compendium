from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests


options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")
options.add_argument('--log-level=3')
# options.add_argument('--headless')


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
        

driver.get("https://yokaiwatch.github.io/characters/#/view/1")
time.sleep(1)
base = driver.find_element(By.CSS_SELECTOR, 'body > div > div:nth-of-type(2) > div > div > div')
name = base.find_element(By.CSS_SELECTOR, 'div').text
rest = base.find_element(By.CSS_SELECTOR, 'div:nth-of-type(2)')
print(rest.get_attribute("class"))
print("done")
time.sleep(5)

# getImages()