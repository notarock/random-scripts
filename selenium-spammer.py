from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

message = "You are a nice person"

count = 100

driver = webdriver.Firefox()

while count != 0:
    driver.get("http://website-to-spam.xyz")

    u = driver.find_element_by_id("username")
    p = driver.find_element_by_id("password")

    u.send_keys(message)
    p.send_keys(message)

    p.send_keys(Keys.RETURN)

    count -= 1

driver.close()


