import yaml
import random
import socket

#with open("config.yaml", "r") as f:
#    config_file = yaml.safe_load(f)

#interface_thread = threading.Thread(target=interface.start_interface())

port = 4000
def get_ip_addr():
    global ip_addr
    auto_ip_addr = input()
    if auto_ip_addr.lower() == "y":
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("1.1.1.1", 80))
        ip_addr = s.getsockname()[0]
        s.close()
    elif auto_ip_addr.lower() == "n":
        print("Please enter your IP-Adress now:")
        ip_addr = input()
    else:
        print("You have done something wrong!")
        print("I'll start the connection-process. To obtain your IP-Adress (local), I'll do a request to 1.1.1.1. Is it ok for you? [Y/n]")
        get_ip_addr()



try:
    with open("config.yaml", "r") as f:
        content = yaml.safe_load(f)
    if content["Config"]["Key"] is not None:
        print("The config-file already exists. I won't overwrite it, so you could delete the file.")
except:
    print("I'll start the connection-process. To obtain your IP-Adress (local), I'll do a request to 1.1.1.1. Is it ok for you? [Y/n]")
    get_ip_addr()
    print("Let's start verification! Please enter the following Things on your other device:")
    print(f"IP_Adress: {ip_addr}:{port}")
    pin = random.randint(10**(8-1), (10**8)-1)
    print(f"PIN: {pin}")
    with open("config.yaml", "w") as f:
        f.write(yaml.dump({"Config": {"Key": pin, "Port": port}, "Mappings": {"a": ["CTRL", "esc", "l"]}}))







