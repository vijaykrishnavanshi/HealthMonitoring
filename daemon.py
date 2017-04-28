from bs4 import BeautifulSoup
import urllib
import sqlite3
import smtplib

# TODO Add mailing serving and send messages if possible

conn = sqlite3.connect('cons.db')
update = 0
while TURE:
	r = urllib.urlopen('http://IP').read()
	soup = BeautifulSoup(r)
	dict = {}
	lists = soup.findAll("li"):
	dict["temp"] = lists[0]
	dict["heart_beat"] = lists[1]

	sql_update_string = "insert into user_1 values ({},{})".format(dict["temp"],dict["heart_beat"])

	c = conn.cursor()
	c.execute(sql_update_string)
	update = update + 1

	if(update == 5):
		conn.commit()
		update = 0

conn.close()
