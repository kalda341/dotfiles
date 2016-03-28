#!/usr/bin/python3
import subprocess
import json

test = subprocess.Popen(["i3-msg","-t","get_marks"], stdout=subprocess.PIPE)
output = test.communicate()[0]

data = json.loads(output.decode())
data = sorted(data)
for i in data:
  print(i)
