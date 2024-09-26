import numpy as np
import serial
import time
import sys
import sqlite3

# find out what file to log to
if len(sys.argv) == 1:
    fname = 'room.db'
else:
    fname = sys.argv[1]

# check if table SPS30 exists in database, create if not
with sqlite3.connect(fname) as con:
    cur = con.cursor()
    res = cur.execute("SELECT name FROM sqlite_master WHERE name='SPS30'")
    if res.fetchone() is None:
        cur.execute("""CREATE TABLE SPS30(timestamp INTEGER, mc_2p5 REAL)""")

# main loop of the program
try:
    with serial.Serial('/dev/ttyUSB0', timeout=1) as SPS30:
        time.sleep(3)
        while True:
            # get 1 min of data from sensor
            data = []
            for i in range(60):
                SPS30.write(b'r\r\n')
                resp = SPS30.readline().decode().strip()
                num = float(resp.split(',')[1])
                try:
                    data.append(num)
                except IndexError:
                    continue
                print(time.ctime(time.time()), ':', num, end='\r')
                time.sleep(1)

            # write average of 1 min into database
            with sqlite3.connect(fname, timeout=10) as con:
                cur = con.cursor()
                data = [int(time.time()), np.average(data)]
                cur.execute("INSERT INTO SPS30 VALUES(?,?)", data)
                con.commit()
except KeyboardInterrupt:
    pass
