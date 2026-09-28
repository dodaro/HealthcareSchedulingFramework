OPERATING ROOM SCHEDULING - INSTANCE generated-day5-input1
===========================================================

Read this instance together with the problem specification. The specification
defines the requirements and how solutions are ranked; this file gives the data.


TIME STRUCTURE
--------------
The planning horizon covers 5 days, numbered 1 to 5.
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
  Surgeon 10: no daily limit
  Surgeon 11: no limit on day 1; at most 2 time slots on day 2; no limit on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 12: no limit on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; no limit on day 4; at most 2 time slots on day 5
  Surgeon 13: no limit on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; no limit on day 4; no limit on day 5
  Surgeon 14: at most 2 time slots on day 1; no limit on day 2; no limit on day 3; no limit on day 4; at most 2 time slots on day 5
  Surgeon 15: at most 2 time slots on day 1; at most 2 time slots on day 2; no limit on day 3; no limit on day 4; at most 2 time slots on day 5
  Surgeon 20: no limit on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 21: no limit on day 1; at most 2 time slots on day 2; no limit on day 3; at most 2 time slots on day 4; at most 2 time slots on day 5
  Surgeon 22: no limit on day 1; at most 2 time slots on day 2; no limit on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 23: at most 2 time slots on day 1; no limit on day 2; at most 2 time slots on day 3; at most 2 time slots on day 4; at most 2 time slots on day 5
  Surgeon 24: at most 2 time slots on day 1; no limit on day 2; no limit on day 3; no limit on day 4; no limit on day 5
  Surgeon 25: no limit on day 1; no limit on day 2; no limit on day 3; at most 2 time slots on day 4; at most 2 time slots on day 5
  Surgeon 30: at most 2 time slots on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; no limit on day 4; at most 2 time slots on day 5
  Surgeon 31: at most 2 time slots on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 32: at most 2 time slots on each day
  Surgeon 33: at most 2 time slots on day 1; at most 2 time slots on day 2; no limit on day 3; at most 2 time slots on day 4; at most 2 time slots on day 5
  Surgeon 40: at most 2 time slots on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; no limit on day 4; no limit on day 5
  Surgeon 41: no limit on day 1; at most 2 time slots on day 2; no limit on day 3; no limit on day 4; no limit on day 5
  Surgeon 42: at most 2 time slots on day 1; no limit on day 2; no limit on day 3; no limit on day 4; at most 2 time slots on day 5
  Surgeon 43: at most 2 time slots on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 50: no limit on day 1; no limit on day 2; at most 2 time slots on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 51: at most 2 time slots on day 1; no limit on day 2; at most 2 time slots on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 52: no limit on day 1; no limit on day 2; at most 2 time slots on day 3; no limit on day 4; at most 2 time slots on day 5
  Surgeon 53: at most 2 time slots on day 1; no limit on day 2; no limit on day 3; at most 2 time slots on day 4; no limit on day 5
  Surgeon 54: no limit on day 1; at most 2 time slots on day 2; at most 2 time slots on day 3; at most 2 time slots on day 4; at most 2 time slots on day 5
  Surgeon 55: no limit on day 1; no limit on day 2; no limit on day 3; at most 2 time slots on day 4; no limit on day 5

Anaesthetists:
  Anaesthetist 11: no limit on day 1; at most 5 time slots on day 2; at most 5 time slots on day 3; at most 5 time slots on day 4; no limit on day 5
  Anaesthetist 21: at most 5 time slots on day 1; at most 5 time slots on day 2; no limit on day 3; at most 5 time slots on day 4; at most 5 time slots on day 5
  Anaesthetist 22: at most 5 time slots on day 1; no limit on day 2; no limit on day 3; no limit on day 4; at most 5 time slots on day 5
  Anaesthetist 31: at most 5 time slots on each day
  Anaesthetist 41: at most 5 time slots on each day
  Anaesthetist 51: no daily limit


MEDICAL SPECIALTIES
-------------------
There are 5 medical specialties, numbered 1 to 5.
A request may only be assigned to a room, a surgeon and an anaesthetist of its
own specialty.


OPERATING ROOMS
---------------
There are 8 operating rooms. Each room is allocated to one specialty and
is open only in the shifts listed.
  Room 1: specialty 1; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Room 2: specialty 1; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Room 3: specialty 2; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Room 4: specialty 2; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Room 5: specialty 3; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Room 6: specialty 4; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Room 7: specialty 5; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Room 8: specialty 5; open in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon


SURGEONS
--------
There are 26 surgeons. Each is qualified for one specialty and is on
duty only in the shifts listed.
  Surgeon 10: specialty 1; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 11: specialty 1; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 12: specialty 1; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 13: specialty 1; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 14: specialty 1; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 15: specialty 1; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 20: specialty 2; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 21: specialty 2; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 22: specialty 2; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 23: specialty 2; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 24: specialty 2; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 25: specialty 2; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 30: specialty 3; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 31: specialty 3; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 32: specialty 3; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 33: specialty 3; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 40: specialty 4; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 41: specialty 4; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 42: specialty 4; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 43: specialty 4; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 50: specialty 5; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 51: specialty 5; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 52: specialty 5; on duty in day 1 morning, day 2 morning, day 3 morning, day 4 morning, day 5 morning
  Surgeon 53: specialty 5; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 54: specialty 5; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon
  Surgeon 55: specialty 5; on duty in day 1 afternoon, day 2 afternoon, day 3 afternoon, day 4 afternoon, day 5 afternoon


ANAESTHETISTS
-------------
There are 6 anaesthetists. Each is qualified for one specialty and is
on duty only in the shifts listed. Anaesthetist identifiers are independent of
surgeon identifiers: surgeon 11 and anaesthetist 11 are different people.
  Anaesthetist 11: specialty 1; on duty in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Anaesthetist 21: specialty 2; on duty in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Anaesthetist 22: specialty 2; on duty in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Anaesthetist 31: specialty 3; on duty in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Anaesthetist 41: specialty 4; on duty in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon
  Anaesthetist 51: specialty 5; on duty in day 1 morning, day 1 afternoon, day 2 morning, day 2 afternoon, day 3 morning, day 3 afternoon, day 4 morning, day 4 afternoon, day 5 morning, day 5 afternoon


SURGICAL REQUESTS
-----------------
There are 150 requests.
  Request 1000: priority 1, specialty 1, duration 2 time slots
  Request 1001: priority 2, specialty 1, duration 2 time slots
  Request 1002: priority 2, specialty 1, duration 2 time slots
  Request 1003: priority 3, specialty 1, duration 2 time slots
  Request 1004: priority 3, specialty 1, duration 2 time slots
  Request 1005: priority 1, specialty 1, duration 2 time slots
  Request 1006: priority 2, specialty 1, duration 1 time slot
  Request 1007: priority 2, specialty 1, duration 2 time slots
  Request 1008: priority 2, specialty 1, duration 2 time slots
  Request 1009: priority 2, specialty 1, duration 2 time slots
  Request 1010: priority 2, specialty 1, duration 2 time slots
  Request 1011: priority 2, specialty 1, duration 1 time slot
  Request 1012: priority 3, specialty 1, duration 3 time slots
  Request 1013: priority 3, specialty 1, duration 1 time slot
  Request 1014: priority 1, specialty 1, duration 2 time slots
  Request 1015: priority 2, specialty 1, duration 2 time slots
  Request 1016: priority 3, specialty 1, duration 2 time slots
  Request 1017: priority 1, specialty 1, duration 2 time slots
  Request 1018: priority 2, specialty 1, duration 1 time slot
  Request 1019: priority 2, specialty 1, duration 1 time slot
  Request 1020: priority 2, specialty 1, duration 2 time slots
  Request 1021: priority 3, specialty 1, duration 2 time slots
  Request 1022: priority 3, specialty 1, duration 2 time slots
  Request 1023: priority 3, specialty 1, duration 3 time slots
  Request 1024: priority 3, specialty 1, duration 1 time slot
  Request 1025: priority 3, specialty 1, duration 2 time slots
  Request 1026: priority 1, specialty 1, duration 2 time slots
  Request 1027: priority 2, specialty 1, duration 2 time slots
  Request 1028: priority 2, specialty 1, duration 3 time slots
  Request 1029: priority 2, specialty 1, duration 1 time slot
  Request 1030: priority 3, specialty 1, duration 2 time slots
  Request 2000: priority 1, specialty 2, duration 2 time slots
  Request 2001: priority 2, specialty 2, duration 3 time slots
  Request 2002: priority 2, specialty 2, duration 2 time slots
  Request 2003: priority 2, specialty 2, duration 2 time slots
  Request 2004: priority 2, specialty 2, duration 1 time slot
  Request 2005: priority 2, specialty 2, duration 2 time slots
  Request 2006: priority 2, specialty 2, duration 2 time slots
  Request 2007: priority 2, specialty 2, duration 1 time slot
  Request 2008: priority 3, specialty 2, duration 2 time slots
  Request 2009: priority 3, specialty 2, duration 2 time slots
  Request 2010: priority 3, specialty 2, duration 2 time slots
  Request 2011: priority 3, specialty 2, duration 2 time slots
  Request 2012: priority 3, specialty 2, duration 3 time slots
  Request 2013: priority 1, specialty 2, duration 1 time slot
  Request 2014: priority 2, specialty 2, duration 2 time slots
  Request 2015: priority 2, specialty 2, duration 1 time slot
  Request 2016: priority 2, specialty 2, duration 1 time slot
  Request 2017: priority 3, specialty 2, duration 3 time slots
  Request 2018: priority 3, specialty 2, duration 1 time slot
  Request 2019: priority 3, specialty 2, duration 2 time slots
  Request 2020: priority 1, specialty 2, duration 1 time slot
  Request 2021: priority 2, specialty 2, duration 3 time slots
  Request 2022: priority 2, specialty 2, duration 1 time slot
  Request 2023: priority 2, specialty 2, duration 2 time slots
  Request 2024: priority 3, specialty 2, duration 3 time slots
  Request 2025: priority 3, specialty 2, duration 2 time slots
  Request 2026: priority 3, specialty 2, duration 3 time slots
  Request 2027: priority 3, specialty 2, duration 1 time slot
  Request 2028: priority 1, specialty 2, duration 2 time slots
  Request 2029: priority 2, specialty 2, duration 2 time slots
  Request 2030: priority 2, specialty 2, duration 2 time slots
  Request 2031: priority 2, specialty 2, duration 3 time slots
  Request 2032: priority 2, specialty 2, duration 1 time slot
  Request 2033: priority 2, specialty 2, duration 3 time slots
  Request 2034: priority 3, specialty 2, duration 1 time slot
  Request 2035: priority 3, specialty 2, duration 3 time slots
  Request 2036: priority 3, specialty 2, duration 1 time slot
  Request 2037: priority 3, specialty 2, duration 3 time slots
  Request 2038: priority 3, specialty 2, duration 1 time slot
  Request 2039: priority 3, specialty 2, duration 2 time slots
  Request 2040: priority 1, specialty 2, duration 1 time slot
  Request 2041: priority 2, specialty 2, duration 1 time slot
  Request 2042: priority 2, specialty 2, duration 3 time slots
  Request 2043: priority 2, specialty 2, duration 2 time slots
  Request 2044: priority 2, specialty 2, duration 2 time slots
  Request 2045: priority 3, specialty 2, duration 3 time slots
  Request 2046: priority 3, specialty 2, duration 1 time slot
  Request 2047: priority 3, specialty 2, duration 1 time slot
  Request 2048: priority 3, specialty 2, duration 1 time slot
  Request 2049: priority 3, specialty 2, duration 2 time slots
  Request 3000: priority 1, specialty 3, duration 1 time slot
  Request 3001: priority 3, specialty 3, duration 2 time slots
  Request 3002: priority 1, specialty 3, duration 1 time slot
  Request 3003: priority 2, specialty 3, duration 2 time slots
  Request 3004: priority 3, specialty 3, duration 1 time slot
  Request 3005: priority 1, specialty 3, duration 1 time slot
  Request 3006: priority 2, specialty 3, duration 3 time slots
  Request 3007: priority 2, specialty 3, duration 1 time slot
  Request 3008: priority 2, specialty 3, duration 1 time slot
  Request 3009: priority 3, specialty 3, duration 1 time slot
  Request 3010: priority 3, specialty 3, duration 2 time slots
  Request 3011: priority 3, specialty 3, duration 2 time slots
  Request 3012: priority 1, specialty 3, duration 1 time slot
  Request 3013: priority 2, specialty 3, duration 1 time slot
  Request 3014: priority 2, specialty 3, duration 1 time slot
  Request 3015: priority 1, specialty 3, duration 1 time slot
  Request 3016: priority 2, specialty 3, duration 3 time slots
  Request 3017: priority 3, specialty 3, duration 1 time slot
  Request 4000: priority 1, specialty 4, duration 1 time slot
  Request 4001: priority 2, specialty 4, duration 2 time slots
  Request 4002: priority 2, specialty 4, duration 3 time slots
  Request 4003: priority 3, specialty 4, duration 2 time slots
  Request 4004: priority 3, specialty 4, duration 1 time slot
  Request 4005: priority 3, specialty 4, duration 2 time slots
  Request 4006: priority 1, specialty 4, duration 1 time slot
  Request 4007: priority 2, specialty 4, duration 2 time slots
  Request 4008: priority 3, specialty 4, duration 3 time slots
  Request 4009: priority 3, specialty 4, duration 2 time slots
  Request 4010: priority 1, specialty 4, duration 1 time slot
  Request 4011: priority 3, specialty 4, duration 2 time slots
  Request 4012: priority 3, specialty 4, duration 3 time slots
  Request 4013: priority 3, specialty 4, duration 1 time slot
  Request 4014: priority 1, specialty 4, duration 2 time slots
  Request 4015: priority 2, specialty 4, duration 1 time slot
  Request 4016: priority 3, specialty 4, duration 2 time slots
  Request 4017: priority 1, specialty 4, duration 1 time slot
  Request 4018: priority 2, specialty 4, duration 2 time slots
  Request 4019: priority 2, specialty 4, duration 1 time slot
  Request 4020: priority 3, specialty 4, duration 3 time slots
  Request 5000: priority 1, specialty 5, duration 2 time slots
  Request 5001: priority 2, specialty 5, duration 2 time slots
  Request 5002: priority 3, specialty 5, duration 1 time slot
  Request 5003: priority 3, specialty 5, duration 1 time slot
  Request 5004: priority 1, specialty 5, duration 1 time slot
  Request 5005: priority 2, specialty 5, duration 2 time slots
  Request 5006: priority 3, specialty 5, duration 1 time slot
  Request 5007: priority 3, specialty 5, duration 3 time slots
  Request 5008: priority 3, specialty 5, duration 2 time slots
  Request 5009: priority 3, specialty 5, duration 2 time slots
  Request 5010: priority 3, specialty 5, duration 2 time slots
  Request 5011: priority 1, specialty 5, duration 2 time slots
  Request 5012: priority 2, specialty 5, duration 2 time slots
  Request 5013: priority 2, specialty 5, duration 3 time slots
  Request 5014: priority 2, specialty 5, duration 2 time slots
  Request 5015: priority 2, specialty 5, duration 2 time slots
  Request 5016: priority 2, specialty 5, duration 2 time slots
  Request 5017: priority 3, specialty 5, duration 2 time slots
  Request 5018: priority 3, specialty 5, duration 3 time slots
  Request 5019: priority 1, specialty 5, duration 2 time slots
  Request 5020: priority 2, specialty 5, duration 1 time slot
  Request 5021: priority 3, specialty 5, duration 1 time slot
  Request 5022: priority 1, specialty 5, duration 1 time slot
  Request 5023: priority 2, specialty 5, duration 2 time slots
  Request 5024: priority 2, specialty 5, duration 2 time slots
  Request 5025: priority 3, specialty 5, duration 2 time slots
  Request 5026: priority 3, specialty 5, duration 2 time slots
  Request 5027: priority 3, specialty 5, duration 1 time slot
  Request 5028: priority 3, specialty 5, duration 2 time slots
  Request 5029: priority 3, specialty 5, duration 2 time slots


REQUEST COUNTS BY PRIORITY
--------------------------
  Priority 1: 25 requests (all of them must be scheduled)
  Priority 2: 60 requests
  Priority 3: 65 requests
