# AutoNSE

Massive NSE (Nmap Scripting Engine) AutoSploit and AutoScanner. The Nmap Scripting Engine (NSE) is one of Nmap's most powerful and flexible features. It allows users to write (and share) simple scripts (using the Lua programming language ) to automate a wide variety of networking tasks. Those scripts are executed in parallel with the speed and efficiency you expect from Nmap. Users can rely on the growing and diverse set of scripts distributed with Nmap, or write their own to meet custom needs. For more informations https://nmap.org/book/man-nse.html

![screen](https://raw.githubusercontent.com/m4ll0k/AutoNSE/master/screen.png)

## Installation
```bash
$ git clone https://github.com/m4ll0k/AutoNSE.git
$ cd AutoNSE 
$ bash autonse.sh
```

## Examples

```bash
$ bash autonse.sh
```
![screen1](https://raw.githubusercontent.com/m4ll0k/AutoNSE/master/screen1.png)
![screen2](https://raw.githubusercontent.com/m4ll0k/AutoNSE/master/screen2.png)

## Docker

You can deploy [AutoNSE](https://github.com/m4ll0k/AutoNSE) using the provided `Dockerfile` locally or remotly.  
The image is Alpine based, meaning it's very light and fast.  

A `/loot` volume is created on launch to easily save nmap's output

```bash
$ git clone https://github.com/m4ll0k/AutoNSE.git
$ docker build -t autonse ./AutoNSE
$ docker run -it --name autonse

[...]

AutoNSE@Sploit: 2
   [+] Output path >> /loot

```
