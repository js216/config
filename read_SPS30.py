import numpy as np
import serial
import time
import sys
import sqlite3

FNAME = sys.argv[1] if len(sys.argv) > 1 else 'room.db'
PORT = '/dev/ttyUSB0'

def init_db():
    """Ensure the SPS30 table exists."""
    with sqlite3.connect(FNAME) as con:
        cur = con.cursor()
        res = cur.execute("SELECT name FROM sqlite_master WHERE name='SPS30'")
        if res.fetchone() is None:
            cur.execute("""CREATE TABLE SPS30(timestamp INTEGER, mc_2p5 REAL)""")

def log_average(data):
    """Write the 1-minute average to the database."""
    if not data:
        return
    with sqlite3.connect(FNAME, timeout=10) as con:
        cur = con.cursor()
        cur.execute(
            "INSERT INTO SPS30 VALUES(?, ?)",
            [int(time.time()), np.average(data)]
        )
        con.commit()

def read_sensor(ser):
    """Read 1 minute of data from the sensor."""
    data = []
    for _ in range(60):
        ser.write(b'r\r\n')
        resp = ser.readline().decode().strip()
        try:
            num = float(resp.split(',')[1])
            data.append(num)
            print(time.ctime(time.time()), ':', num, end='\r')
        except (IndexError, ValueError):
            continue
        time.sleep(1)
    return data

def main():
    init_db()
    while True:
        try:
            with serial.Serial(PORT, timeout=1) as ser:
                time.sleep(3)
                while True:
                    data = read_sensor(ser)
                    log_average(data)
        except serial.SerialException:
            print("Device not found, retrying in 2 seconds...")
            time.sleep(2)
        except KeyboardInterrupt:
            print("\nExiting.")
            break

if __name__ == "__main__":
    main()

