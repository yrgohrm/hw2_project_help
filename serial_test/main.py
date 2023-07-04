import re
import serial
import sys

from time import sleep

serial_device = "/dev/ttyS0"
if len(sys.argv) == 2:
    serial_device = sys.argv[1]

ser = serial.Serial(serial_device, 9600, timeout=10)
while True:
    sleep(1)
    data = ser.read_until()
    if len(data) > 0:
        print(data)
        if data[-1] != 10:
            print("The data is not sent with a newline")
            continue

        data_str = data.decode("UTF-8").strip()
        parts = data_str.split(" ")
        if len(parts) != 3:
            print("The data is not separated correctly with space")
            continue

        for part in parts[0:2]:
            if not re.match("^[A-Fa-f0-9]+$", part):
                print("An id was not sent in proper hex format:", part)

        try:
            float(parts[2])
        except ValueError:
            print("The temperature is not a properly formatted number:", parts[2])
