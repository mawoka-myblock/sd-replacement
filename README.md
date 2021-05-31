# Sd-Reploacement
A program (actually 2) to use an old PC as a StreamDeck-replacement.

### Why I did this?
I had an old 32-Bit laptop lying around and thought `What could I do with it?` and 
I wanted to have a StreamDeck, but it is too expensive imho. So I programmed this stupid thing.

# Highlights
- Easy2use
- Cheap
- Use old computers

# How2use?
At first, you should have 2 devices. One is your Main-Computer where everything gets executed.
From Now on `Main-Computer`.
Then you have the other (from now on `Client-Computer`). On the Main-Computer you can specify what happens if
you push a button on the Client-Computer.
1. Download the Software on both computers.
2. Install the right requirements (`pip install -r [client/server]-requirements.txt`)
3. On the Main-Computer run `python3 main.py`
4. On the client-computer run `python3 main.py`
5. Add `server.py` to the autostart on your main-computer and edit the configuration
to your needs.
6. Add `main.py` to the autostart on your client-computer.
7. Have fun!


# Example Configuration
```yaml
Config:
  Key: 193749 # The key required for authentication 
  Port: 4000 # To adjust the port manually
Mappings: # Here you can specify everything
  c:   # If the button "c" gets pressed, do the following:
    - alt # Press ALT
    - f4  # And F4
  b:
    - ctrl
    - c 
```
 Note, It doesn't press them after each other, it does it like this:
1. Alt -> Down
2. F4 -> Down

**Now it is done, so it releases the keys:**
3. Alt -> Up
4. F4 -> Up

A list of all buttons which can be pushed is [Here](https://pyautogui.readthedocs.io/en/latest/keyboard.html#keyboard-keys)



# Roadmap
- Add the ability to execute commands
- Add a non-graphical interface for the client