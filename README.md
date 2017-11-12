# DayNotis

A Programmable linux desktop notifcations based time management system.

### Motivation

Ever find yourself up late and wish someone would have pinged you to go to bed?
Wish it was easy to write down the rhythm of your week? With convienient audible reminders?
Find yourself frequently forgetting regular mundane everyday tasks?
Would a popup and an audible bell be enough of a reminder?

## Overview

`config.yml` is a list of Days, each with a list of times.
A time has a `title` and a `body` field.
DBUS notifications only require a title, but can include a body.
This functions the same.

There are three "level" settings for an alert:

- notice
- urgent
- critical

Urgent will ring the `chime` method in `Notification`, and critical will ring the `bell` method.
There are some nice, hopefully unobtrusive, sound files in the `assets` folders that are used.
These sound files are run through `mplayer` by the `Notification` class. (That should probably be configurable)


## Functionality

DayNotis will run every 10 seconds. It will try to reload `config.yml` to keep things nice and dynamic.
(It should probably be configurable exactly where `config.yml` is kept)

### About

This is a personal weekend project. I'd like to make it a really robust and useful tool, and i hope it helps someone eles out.
Please feel free to file issues, and hopefully this can get to be a really useful and robust utility.

