OPERATING ROOM SCHEDULING - INSTANCE generated-day1-input1
===========================================================

Read this instance together with the problem specification. The specification
defines the requirements and how solutions are ranked; this file gives the data.


TIME STRUCTURE
--------------
The planning horizon covers a single day, numbered 1.
Each day has two shifts: a morning shift and an afternoon shift.
Each shift is divided into 5 time slots, numbered 1 to 5.


DAILY WORKLOAD LIMITS
---------------------
The daily workload limits are personal. For each surgeon and each anaesthetist,
the list below gives the maximum total duration, in time slots, of the surgeries
that may be assigned to them in a day, counting both shifts of that day together.
Limits differ from person to person and, where indicated, from day to day.
A person with no daily limit, on a given day or on every day, is bounded on
that day only by the other requirements, in particular by performing one
surgery at a time within the shifts in which they are on duty.

Surgeons:
  Surgeon 10: at most 2 time slots on day 1
  Surgeon 11: no daily limit
  Surgeon 12: no daily limit
  Surgeon 13: at most 2 time slots on day 1
  Surgeon 14: no daily limit
  Surgeon 15: no daily limit
  Surgeon 20: no daily limit
  Surgeon 21: no daily limit
  Surgeon 22: no daily limit
  Surgeon 23: at most 2 time slots on day 1
  Surgeon 24: at most 2 time slots on day 1
  Surgeon 25: no daily limit
  Surgeon 30: at most 2 time slots on day 1
  Surgeon 31: no daily limit
  Surgeon 32: at most 2 time slots on day 1
  Surgeon 33: at most 2 time slots on day 1
  Surgeon 40: no daily limit
  Surgeon 41: at most 2 time slots on day 1
  Surgeon 42: at most 2 time slots on day 1
  Surgeon 43: no daily limit
  Surgeon 50: at most 2 time slots on day 1
  Surgeon 51: at most 2 time slots on day 1
  Surgeon 52: at most 2 time slots on day 1
  Surgeon 53: no daily limit
  Surgeon 54: at most 2 time slots on day 1
  Surgeon 55: at most 2 time slots on day 1

Anaesthetists:
  Anaesthetist 11: at most 5 time slots on day 1
  Anaesthetist 21: no daily limit
  Anaesthetist 22: no daily limit
  Anaesthetist 31: no daily limit
  Anaesthetist 41: no daily limit
  Anaesthetist 51: at most 5 time slots on day 1


MEDICAL SPECIALTIES
-------------------
There are 5 medical specialties, numbered 1 to 5.
A request may only be assigned to a room, a surgeon and an anaesthetist of its
own specialty.


OPERATING ROOMS
---------------
There are 8 operating rooms. Each room is allocated to one specialty and
is open only in the shifts listed.
  Room 1: specialty 1; open in day 1 morning, day 1 afternoon
  Room 2: specialty 1; open in day 1 morning, day 1 afternoon
  Room 3: specialty 2; open in day 1 morning, day 1 afternoon
  Room 4: specialty 2; open in day 1 morning, day 1 afternoon
  Room 5: specialty 3; open in day 1 morning, day 1 afternoon
  Room 6: specialty 4; open in day 1 morning, day 1 afternoon
  Room 7: specialty 5; open in day 1 morning, day 1 afternoon
  Room 8: specialty 5; open in day 1 morning, day 1 afternoon


SURGEONS
--------
There are 26 surgeons. Each is qualified for one specialty and is on
duty only in the shifts listed.
  Surgeon 10: specialty 1; on duty in day 1 morning
  Surgeon 11: specialty 1; on duty in day 1 morning
  Surgeon 12: specialty 1; on duty in day 1 morning
  Surgeon 13: specialty 1; on duty in day 1 afternoon
  Surgeon 14: specialty 1; on duty in day 1 afternoon
  Surgeon 15: specialty 1; on duty in day 1 afternoon
  Surgeon 20: specialty 2; on duty in day 1 morning
  Surgeon 21: specialty 2; on duty in day 1 morning
  Surgeon 22: specialty 2; on duty in day 1 morning
  Surgeon 23: specialty 2; on duty in day 1 afternoon
  Surgeon 24: specialty 2; on duty in day 1 afternoon
  Surgeon 25: specialty 2; on duty in day 1 afternoon
  Surgeon 30: specialty 3; on duty in day 1 morning
  Surgeon 31: specialty 3; on duty in day 1 morning
  Surgeon 32: specialty 3; on duty in day 1 afternoon
  Surgeon 33: specialty 3; on duty in day 1 afternoon
  Surgeon 40: specialty 4; on duty in day 1 morning
  Surgeon 41: specialty 4; on duty in day 1 morning
  Surgeon 42: specialty 4; on duty in day 1 afternoon
  Surgeon 43: specialty 4; on duty in day 1 afternoon
  Surgeon 50: specialty 5; on duty in day 1 morning
  Surgeon 51: specialty 5; on duty in day 1 morning
  Surgeon 52: specialty 5; on duty in day 1 morning
  Surgeon 53: specialty 5; on duty in day 1 afternoon
  Surgeon 54: specialty 5; on duty in day 1 afternoon
  Surgeon 55: specialty 5; on duty in day 1 afternoon


ANAESTHETISTS
-------------
There are 6 anaesthetists. Each is qualified for one specialty and is
on duty only in the shifts listed. Anaesthetist identifiers are independent of
surgeon identifiers: surgeon 11 and anaesthetist 11 are different people.
  Anaesthetist 11: specialty 1; on duty in day 1 morning, day 1 afternoon
  Anaesthetist 21: specialty 2; on duty in day 1 morning, day 1 afternoon
  Anaesthetist 22: specialty 2; on duty in day 1 morning, day 1 afternoon
  Anaesthetist 31: specialty 3; on duty in day 1 morning, day 1 afternoon
  Anaesthetist 41: specialty 4; on duty in day 1 morning, day 1 afternoon
  Anaesthetist 51: specialty 5; on duty in day 1 morning, day 1 afternoon


SURGICAL REQUESTS
-----------------
There are 30 requests.
  Request 1000: priority 1, specialty 1, duration 2 time slots
  Request 1001: priority 2, specialty 1, duration 2 time slots
  Request 1002: priority 2, specialty 1, duration 1 time slot
  Request 1003: priority 2, specialty 1, duration 2 time slots
  Request 1004: priority 3, specialty 1, duration 1 time slot
  Request 2000: priority 1, specialty 2, duration 1 time slot
  Request 2001: priority 2, specialty 2, duration 3 time slots
  Request 2002: priority 2, specialty 2, duration 2 time slots
  Request 2003: priority 2, specialty 2, duration 1 time slot
  Request 2004: priority 2, specialty 2, duration 2 time slots
  Request 2005: priority 2, specialty 2, duration 2 time slots
  Request 2006: priority 3, specialty 2, duration 2 time slots
  Request 2007: priority 3, specialty 2, duration 2 time slots
  Request 2008: priority 3, specialty 2, duration 2 time slots
  Request 2009: priority 3, specialty 2, duration 1 time slot
  Request 2010: priority 3, specialty 2, duration 2 time slots
  Request 2011: priority 3, specialty 2, duration 2 time slots
  Request 2012: priority 3, specialty 2, duration 1 time slot
  Request 2013: priority 3, specialty 2, duration 1 time slot
  Request 2014: priority 3, specialty 2, duration 3 time slots
  Request 3000: priority 1, specialty 3, duration 2 time slots
  Request 3001: priority 2, specialty 3, duration 2 time slots
  Request 3002: priority 3, specialty 3, duration 2 time slots
  Request 4000: priority 1, specialty 4, duration 2 time slots
  Request 4001: priority 2, specialty 4, duration 2 time slots
  Request 5000: priority 1, specialty 5, duration 1 time slot
  Request 5001: priority 2, specialty 5, duration 1 time slot
  Request 5002: priority 2, specialty 5, duration 2 time slots
  Request 5003: priority 3, specialty 5, duration 2 time slots
  Request 5004: priority 3, specialty 5, duration 3 time slots


REQUEST COUNTS BY PRIORITY
--------------------------
  Priority 1: 5 requests (all of them must be scheduled)
  Priority 2: 12 requests
  Priority 3: 13 requests
