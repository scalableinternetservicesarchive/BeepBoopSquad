#!/bin/bash
  
read -p 'Tsung Address: ' address

scp -r /home/BeepBoopSquad/BeepBoopSquad/tsung/ $address:
scp -r /home/BeepBoopSquad/BeepBoopSquad/db/data/ $address:tsung/
