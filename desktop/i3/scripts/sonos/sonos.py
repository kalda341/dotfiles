#!/bin/env python3
import sys
import soco

if __name__ == '__main__':
    device = soco.SoCo('192.168.1.47')

    if sys.argv[1] in ['play', 'pause', 'stop', 'previous', 'next']:
        getattr(device, sys.argv[1])()
    elif sys.argv[1] == 'current':
        track = device.get_current_track_info()
        resp = '{} - {} - {} ({}%)'.format(track['title'], track['artist'], track['position'], device.volume)
        if len(sys.argv) >= 3 and sys.argv[2] == '--escape':
            print(resp.replace('"', '\\"'))
        else:
            print(resp)
    elif sys.argv[1] == 'volume':
        if sys.argv[2].startswith('+') or sys.argv[2].startswith('-'):
            device.volume += int(sys.argv[2])
        else:
            device.volume = sys.argv[2]
