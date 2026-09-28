% Instance generated-day2-input1, transcribed from generated-day2-input1.nl
% Usage: clingo framework.lp ors_converter.lp generated-day2-input1.lp

% Time structure: 2 days, two shifts per day of 5 slots numbered 1 to 5.
horizon(2).
slots_per_shift(5).
first_slot(1).

% Operating rooms: room(Room, Specialty, Day, Shift). All rooms are open in every shift.
room(1,1,(1;2),(morning;afternoon)).
room(2,1,(1;2),(morning;afternoon)).
room(3,2,(1;2),(morning;afternoon)).
room(4,2,(1;2),(morning;afternoon)).
room(5,3,(1;2),(morning;afternoon)).
room(6,4,(1;2),(morning;afternoon)).
room(7,5,(1;2),(morning;afternoon)).
room(8,5,(1;2),(morning;afternoon)).

% Surgeons: surgeon(Id, Specialty, Day, Shift). Everyone works the same shift on both days.
surgeon(10,1,(1;2),morning).   surgeon(11,1,(1;2),morning).   surgeon(12,1,(1;2),morning).
surgeon(13,1,(1;2),afternoon). surgeon(14,1,(1;2),afternoon). surgeon(15,1,(1;2),afternoon).
surgeon(20,2,(1;2),morning).   surgeon(21,2,(1;2),morning).   surgeon(22,2,(1;2),morning).
surgeon(23,2,(1;2),afternoon). surgeon(24,2,(1;2),afternoon). surgeon(25,2,(1;2),afternoon).
surgeon(30,3,(1;2),morning).   surgeon(31,3,(1;2),morning).
surgeon(32,3,(1;2),afternoon). surgeon(33,3,(1;2),afternoon).
surgeon(40,4,(1;2),morning).   surgeon(41,4,(1;2),morning).
surgeon(42,4,(1;2),afternoon). surgeon(43,4,(1;2),afternoon).
surgeon(50,5,(1;2),morning).   surgeon(51,5,(1;2),morning).   surgeon(52,5,(1;2),morning).
surgeon(53,5,(1;2),afternoon). surgeon(54,5,(1;2),afternoon). surgeon(55,5,(1;2),afternoon).

% Anaesthetists: anaesthetist(Id, Specialty, Day, Shift). All on duty in every shift.
anaesthetist(11,1,(1;2),(morning;afternoon)).
anaesthetist(21,2,(1;2),(morning;afternoon)).
anaesthetist(22,2,(1;2),(morning;afternoon)).
anaesthetist(31,3,(1;2),(morning;afternoon)).
anaesthetist(41,4,(1;2),(morning;afternoon)).
anaesthetist(51,5,(1;2),(morning;afternoon)).

% Daily workload limits (Id, Day, MaxSlots); no fact for a person and day = no limit that day.
surgeon_limit(11,1,2).     surgeon_limit(12,2,2).     surgeon_limit(13,(1;2),2).
surgeon_limit(20,(1;2),2). surgeon_limit(22,2,2).     surgeon_limit(23,2,2).
surgeon_limit(24,1,2).     surgeon_limit(25,(1;2),2).
surgeon_limit(30,(1;2),2). surgeon_limit(31,(1;2),2). surgeon_limit(32,2,2).
surgeon_limit(41,(1;2),2). surgeon_limit(42,2,2).     surgeon_limit(43,(1;2),2).
surgeon_limit(50,1,2).     surgeon_limit(51,(1;2),2). surgeon_limit(52,(1;2),2).
surgeon_limit(53,2,2).     surgeon_limit(55,(1;2),2).

anaesthetist_limit(11,1,5).
anaesthetist_limit(22,1,5).
anaesthetist_limit(31,2,5).
anaesthetist_limit(41,2,5).
anaesthetist_limit(51,(1;2),5).

% Requests: request(Id, Priority, Specialty, Duration).
request(1000,1,1,2). request(1001,2,1,2). request(1002,2,1,1). request(1003,2,1,2).
request(1004,2,1,2). request(1005,2,1,2). request(1006,2,1,2). request(1007,3,1,3).
request(1008,3,1,3). request(1009,1,1,1). request(1010,2,1,2). request(1011,2,1,2).
request(1012,2,1,3). request(1013,2,1,2). request(1014,2,1,2). request(1015,3,1,1).
request(2000,1,2,2). request(2001,2,2,2). request(2002,2,2,3). request(2003,3,2,2).
request(2004,3,2,2). request(2005,3,2,2). request(2006,3,2,2). request(2007,1,2,1).
request(2008,2,2,2). request(2009,2,2,2). request(2010,3,2,3). request(2011,3,2,2).
request(2012,3,2,1). request(2013,3,2,2). request(2014,3,2,2). request(2015,3,2,3).
request(2016,3,2,1).
request(3000,1,3,2). request(3001,2,3,1). request(3002,3,3,1). request(3003,3,3,1).
request(3004,3,3,1). request(3005,1,3,1). request(3006,2,3,2). request(3007,3,3,2).
request(3008,3,3,2).
request(4000,1,4,2). request(4001,1,4,2). request(4002,2,4,1). request(4003,3,4,3).
request(5000,1,5,1). request(5001,2,5,2). request(5002,2,5,2). request(5003,2,5,3).
request(5004,3,5,2). request(5005,3,5,3). request(5006,3,5,2). request(5007,3,5,2).
request(5008,1,5,1). request(5009,2,5,3). request(5010,2,5,3). request(5011,2,5,2).
request(5012,3,5,1). request(5013,3,5,2).
