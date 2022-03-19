# Sd-Replacement

A program (actually 4) to use an old PC or any other device as a StreamDeck-replacement.

### Why I did this?

I had an old 32-Bit laptop lying around and thought `What could I do with it?` and I wanted to have a StreamDeck, but it
is too expensive, so I programmed this stupid thing.

# Highlights

- Easy2use
- Cheap
- Use old computers

[//]: # (- Web-Version available, [HERE]&#40;https://mawoka-myblock.github.io/sd-replacement/app/&#41;)

# How to use it?

At first, you should have 2 devices. One is your Main-Computer where everything gets executed. From Now
on `Main-Computer`. Then you have the other pc or smartphone (from now on `Client-Computer`). On the Main-Computer you
can specify what happens if you push a button/key on the Client-Computer.

The software you need for the Client-Computer is written with [Flutter](https://flutter.dev/), so it runs everywhere.

The software you need for the Main-Computer is written with [Rust](https://www.rust-lang.org/), so it runs everywhere,
as well.
You just need to download it, write a config-file and run it.

## Example Configuration

```yaml
Config:
  Key: 193749 # The key required for authentication 
  Port: 4000 # To adjust the port manually
Mappings: # Here you can specify everything
  c: # If the button "c" gets pressed, do the following:
    - alt # Press ALT
    - f4  # And F4
  b:
    - ctrl
    - c
Commands: # Here can be put shell-commands
  l: # The button which triggers...
    - brave https://ddg.gg # ...This command
```

Note, It doesn't press them after each other, it does it like this:

1. Alt -> Down
2. F4 -> Down

**Now it is done, so it releases the keys:**

3. Alt -> Up
4. F4 -> Up

A list of all buttons which can be pushed
is [Here](https://pyautogui.readthedocs.io/en/latest/keyboard.html#keyboard-keys)

# Roadmap

- [x] Add the ability to execute commands
- [ ] Add a non-graphical interface for the client
- [x] An android-app (maybe with toga or kivy)

# Build the Client

The client is written with [Cordova](https://cordova.apache.org). To build, install Cordova, add a platform and build.

# Web-Version

- The Production-Web-Version is
  here: [https://sdreplacement.mawoka.eu.org/app/](https://mawoka-myblock.github.io/sd-replacement/app/)
- The Dev-Web-Version which comes directly from last commit is
  here: [https://sdreplacement.mawoka.eu.org/dev/](https://mawoka-myblock.github.io/sd-replacement/dev/)
