#!/bin/sh
xargs -I '$' i3-msg '[con_mark=$]' focus
