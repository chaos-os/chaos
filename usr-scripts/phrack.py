#!/bin/env python

import os,subprocess

N = subprocess.getoutput("echo '' | dmenu -p 'enter article section number:'")

if not N:
    exit()
else:
    G = subprocess.getoutput("echo '' | dmenu -p 'enter article number:'")
    if not G:
        exit()
    else:
        try:
            os.chdir(os.path.expanduser("~/phrack"))
        except:
            os.chdir(os.path.expanduser("~"))
            os.mkdir("phrack")
            os.chdir("phrack")
        subprocess.getoutput("aria2c -Umozilla/5.0 -x 10 -s 10 -c http://phrack.org/issues/{0}/{1}.html && pandoc {1}.html -o text-{0}-{1}.txt && rm {1}.html".format(N,G))
