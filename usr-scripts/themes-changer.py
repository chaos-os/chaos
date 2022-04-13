#!/bin/env python

import os,subprocess

N = subprocess.getoutput("cat ~/.config/script-dependencies/themes.txt | dmenu -p 'select your theme:' -l 20")
