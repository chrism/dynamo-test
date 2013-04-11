# Dynamo Images Test

View online at

http://dynamo-test.herokuapp.com/

## Introduction

This is a quick proof of concept which pulls images from the Orange Valley WM1 feed of the Dynamo images and displays them in a way similar to the exhibition display.

All of the client is written in Javascript - the sever is only needed to proxy the authentication token request from Orange Valley.

Effectively the XML data is all parsed in Javascript and then polls the server every 5 seconds to download new images as they become available.

At the moment it is a very basic implementation (there is still plenty of polish to do).


## File structure

The built files are located in `/public`the other files are the source & server

## Setup

Assuming you have ruby / bundler on your machine you should be able to run

```
bundle install
shotgun dynamo.rb
```

to run the application locally.

## Server

I've had to use a small server (Sinatra) basically to proxy the XML response from

```
http://rmn.memory-life.com/Connect/?msidn=prod
```

Otherwise I was getting cross domain errors.

## Javascript

Coded it in coffeescript, but left the compiled JS uncompressed.

Uses jQuery.

## HTML & CSS

Should be responsive (try draggin the window in and out)

## Know Problems

At the moment this isn't working on IE - in the process of working out why.