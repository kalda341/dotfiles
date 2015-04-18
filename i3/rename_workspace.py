#!/usr/bin/python3
import subprocess
import sys
import json

new_name = sys.stdin.readlines()[0]

process = subprocess.Popen(["i3-msg", "-t", "get_workspaces"], stdout=subprocess.PIPE)
output = str(process.communicate()[0])[1:].replace("\\n", "")
workspaces = json.loads(output)
workspace = list(filter(lambda i: i['focused'] == True, workspaces))[0]

test = subprocess.Popen(["i3-msg","rename worspace %s to %s" % (workspace['name'], new_name)], stdout=subprocess.PIPE)
