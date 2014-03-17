#!/usr/bin/env python

import epics

print epics.caget('rpi:trigger.DESC')
print epics.caget('rpi:trigger')
print epics.caget('rpi:message.DESC')
print epics.caget('rpi:message')

msg = epics.caget('rpi:message')

epics.caput('rpi:message', 'setting trigger')
epics.caput('rpi:trigger', 1)
print epics.caget('rpi:trigger.DESC')
print epics.caget('rpi:trigger')
print epics.caget('rpi:message.DESC')
print epics.caget('rpi:message')

epics.caput('rpi:message', 'clearing trigger')
epics.caput('rpi:trigger', 0)
print epics.caget('rpi:trigger.DESC')
print epics.caget('rpi:trigger')
print epics.caget('rpi:message.DESC')
print epics.caget('rpi:message')

epics.caput('rpi:message', msg)
