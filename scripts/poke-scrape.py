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

for i in range(1,1011):
    driver.get(f'https://pokemondb.net/pokedex/{i}')
    img = driver.find_element(By.CSS_SELECTOR, 'main picture img')
    name = driver.find_element(By.CSS_SELECTOR, 'main h1').text
    print(f"{i}-{name}")
    img_url = img.get_attribute('src')
    response = requests.get(img_url, stream=True)
    response.raise_for_status()

    with open(f'./../images/{i}-{name}.jpg', 'wb') as file:
        for chunk in response.iter_content(8192):
            file.write(chunk)
    

driver.quit()
print("Done")
