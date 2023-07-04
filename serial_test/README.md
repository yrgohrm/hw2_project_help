# Test of serial data sending

NB! This is a little helper program for the course "Hårdvarunära programmering
2" at Yrgo. It does not make much sens outside of that course.

This is a simple program to validate the data sent on the serial line. If you
are using Raspberry Pi it should work out of the box by simply installing the
requirements `pip install -r requirements.txt` and then running the program with
`python main.py` from within a venv.

If you are running a serial to USB converter from Windows you need to supply
the correct serial port when starting the program. E.g. `python main.py COM3`.
