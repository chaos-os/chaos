#!/bin/env python
import os 
import subprocess
N = subprocess.getoutput("cat ~/.config/script-dependencies/search-engines.txt | cut -d '-' -f1 | dmenu -i -p 'select your search engine:' -l 20")
if not N:
    exit()
Y = subprocess.getoutput("echo '' | dmenu -p {0} -i".format(N))
Z = subprocess.getoutput("cat ~/.config/script-dependencies/search-engines.txt | grep {0} | cut -d '-' -f2".format(N))
if not Y:
    exit()
else:
    if N == "ArchWiki":
        for i in Y.split():
            Z += i + '_'    
        subprocess.Popen(["brave",Z])
    else:
        X=''
        for i in Y.split():
            Z += i + '+' 
        subprocess.Popen(["brave",Z])
