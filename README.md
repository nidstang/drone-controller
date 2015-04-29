# Drone Controller
This is a library for a Client/Server AR Drone control written in Scheme language.

The server side uses the libraries Scheme Spheres and Gamsock. However the cliente side only uses HTML and Javascipt.

The connection to server from the cliente is made through the AJAX calls. Equally the connection to the AR Drone from the server is made with a UPD Socket.
## Important
Now we're at BETA version

The GUI for this moment is only HTML, however in the final version will be Canvas.
## Installation
You only need download this library in your workstation. You may edit the router.scm file for you add more functionality.

Drone Controller requires the [Gambit Scheme compiler](http://gambitscheme.org) and the [Scheme Spheres](https://github.com/fourthbit/spheres)

You first must install Gambit and then Scheme Spheres.

Inside the ar-drone folder you will find [the ar-drone library](https://github.com/nidstang/ar-drone)
## Usage
Execute in your console or terminal the following command for server up:
```sh
$ gsi server.scm
```
Fine, now go to the "http://localhost:3005" on your browser.
You must see a interface for the drone control (HTML only)

## Version
We're still in version *0.5 Beta*.
