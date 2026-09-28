% Instance generated-day5-input1, transcribed from generated-day5-input1.nl
% Usage: clingo framework.lp ors_converter.lp generated-day5-input1.lp

% Time structure: 5 days, two shifts per day of 5 slots numbered 1 to 5.
horizon(5).
slots_per_shift(5).
first_slot(1).

% Operating rooms: room(Room, Specialty, Day, Shift). All rooms are open in every shift.
room(1,1,1..5,(morning;afternoon)).
room(2,1,1..5,(morning;afternoon)).
room(3,2,1..5,(morning;afternoon)).
room(4,2,1..5,(morning;afternoon)).
room(5,3,1..5,(morning;afternoon)).
room(6,4,1..5,(morning;afternoon)).
room(7,5,1..5,(morning;afternoon)).
room(8,5,1..5,(morning;afternoon)).

% Surgeons: surgeon(Id, Specialty, Day, Shift). Everyone works the same shift on all days.
surgeon(10,1,1..5,morning).   surgeon(11,1,1..5,morning).   surgeon(12,1,1..5,morning).
surgeon(13,1,1..5,afternoon). surgeon(14,1,1..5,afternoon). surgeon(15,1,1..5,afternoon).
surgeon(20,2,1..5,morning).   surgeon(21,2,1..5,morning).   surgeon(22,2,1..5,morning).
surgeon(23,2,1..5,afternoon). surgeon(24,2,1..5,afternoon). surgeon(25,2,1..5,afternoon).
surgeon(30,3,1..5,morning).   surgeon(31,3,1..5,morning).
surgeon(32,3,1..5,afternoon). surgeon(33,3,1..5,afternoon).
surgeon(40,4,1..5,morning).   surgeon(41,4,1..5,morning).
surgeon(42,4,1..5,afternoon). surgeon(43,4,1..5,afternoon).
surgeon(50,5,1..5,morning).   surgeon(51,5,1..5,morning).   surgeon(52,5,1..5,morning).
surgeon(53,5,1..5,afternoon). surgeon(54,5,1..5,afternoon). surgeon(55,5,1..5,afternoon).

% Anaesthetists: anaesthetist(Id, Specialty, Day, Shift). All on duty in every shift.
anaesthetist(11,1,1..5,(morning;afternoon)).
anaesthetist(21,2,1..5,(morning;afternoon)).
anaesthetist(22,2,1..5,(morning;afternoon)).
anaesthetist(31,3,1..5,(morning;afternoon)).
anaesthetist(41,4,1..5,(morning;afternoon)).
anaesthetist(51,5,1..5,(morning;afternoon)).

% Daily workload limits (Id, Day, MaxSlots); no fact for a person and day = no limit that day.
surgeon_limit(11,(2;4),2).       surgeon_limit(12,(2;3;5),2).   surgeon_limit(13,(2;3),2).
surgeon_limit(14,(1;5),2).       surgeon_limit(15,(1;2;5),2).
surgeon_limit(20,(2;3;4),2).     surgeon_limit(21,(2;4;5),2).   surgeon_limit(22,(2;4),2).
surgeon_limit(23,(1;3;4;5),2).   surgeon_limit(24,1,2).         surgeon_limit(25,(4;5),2).
surgeon_limit(30,(1;2;3;5),2).   surgeon_limit(31,(1;2;3;4),2).
surgeon_limit(32,1..5,2).        surgeon_limit(33,(1;2;4;5),2).
surgeon_limit(40,(1;2;3),2).     surgeon_limit(41,2,2).
surgeon_limit(42,(1;5),2).       surgeon_limit(43,(1;2;3;4),2).
surgeon_limit(50,(3;4),2).       surgeon_limit(51,(1;3;4),2).   surgeon_limit(52,(3;5),2).
surgeon_limit(53,(1;4),2).       surgeon_limit(54,(2;3;4;5),2). surgeon_limit(55,4,2).

anaesthetist_limit(11,(2;3;4),5).
anaesthetist_limit(21,(1;2;4;5),5).
anaesthetist_limit(22,(1;5),5).
anaesthetist_limit(31,1..5,5).
anaesthetist_limit(41,1..5,5).

% Requests: request(Id, Priority, Specialty, Duration).
request(1000,1,1,2). request(1001,2,1,2). request(1002,2,1,2). request(1003,3,1,2).
request(1004,3,1,2). request(1005,1,1,2). request(1006,2,1,1). request(1007,2,1,2).
request(1008,2,1,2). request(1009,2,1,2). request(1010,2,1,2). request(1011,2,1,1).
request(1012,3,1,3). request(1013,3,1,1). request(1014,1,1,2). request(1015,2,1,2).
request(1016,3,1,2). request(1017,1,1,2). request(1018,2,1,1). request(1019,2,1,1).
request(1020,2,1,2). request(1021,3,1,2). request(1022,3,1,2). request(1023,3,1,3).
request(1024,3,1,1). request(1025,3,1,2). request(1026,1,1,2). request(1027,2,1,2).
request(1028,2,1,3). request(1029,2,1,1). request(1030,3,1,2).

request(2000,1,2,2). request(2001,2,2,3). request(2002,2,2,2). request(2003,2,2,2).
request(2004,2,2,1). request(2005,2,2,2). request(2006,2,2,2). request(2007,2,2,1).
request(2008,3,2,2). request(2009,3,2,2). request(2010,3,2,2). request(2011,3,2,2).
request(2012,3,2,3). request(2013,1,2,1). request(2014,2,2,2). request(2015,2,2,1).
request(2016,2,2,1). request(2017,3,2,3). request(2018,3,2,1). request(2019,3,2,2).
request(2020,1,2,1). request(2021,2,2,3). request(2022,2,2,1). request(2023,2,2,2).
request(2024,3,2,3). request(2025,3,2,2). request(2026,3,2,3). request(2027,3,2,1).
request(2028,1,2,2). request(2029,2,2,2). request(2030,2,2,2). request(2031,2,2,3).
request(2032,2,2,1). request(2033,2,2,3). request(2034,3,2,1). request(2035,3,2,3).
request(2036,3,2,1). request(2037,3,2,3). request(2038,3,2,1). request(2039,3,2,2).
request(2040,1,2,1). request(2041,2,2,1). request(2042,2,2,3). request(2043,2,2,2).
request(2044,2,2,2). request(2045,3,2,3). request(2046,3,2,1). request(2047,3,2,1).
request(2048,3,2,1). request(2049,3,2,2).

request(3000,1,3,1). request(3001,3,3,2). request(3002,1,3,1). request(3003,2,3,2).
request(3004,3,3,1). request(3005,1,3,1). request(3006,2,3,3). request(3007,2,3,1).
request(3008,2,3,1). request(3009,3,3,1). request(3010,3,3,2). request(3011,3,3,2).
request(3012,1,3,1). request(3013,2,3,1). request(3014,2,3,1). request(3015,1,3,1).
request(3016,2,3,3). request(3017,3,3,1).

request(4000,1,4,1). request(4001,2,4,2). request(4002,2,4,3). request(4003,3,4,2).
request(4004,3,4,1). request(4005,3,4,2). request(4006,1,4,1). request(4007,2,4,2).
request(4008,3,4,3). request(4009,3,4,2). request(4010,1,4,1). request(4011,3,4,2).
request(4012,3,4,3). request(4013,3,4,1). request(4014,1,4,2). request(4015,2,4,1).
request(4016,3,4,2). request(4017,1,4,1). request(4018,2,4,2). request(4019,2,4,1).
request(4020,3,4,3).

request(5000,1,5,2). request(5001,2,5,2). request(5002,3,5,1). request(5003,3,5,1).
request(5004,1,5,1). request(5005,2,5,2). request(5006,3,5,1). request(5007,3,5,3).
request(5008,3,5,2). request(5009,3,5,2). request(5010,3,5,2). request(5011,1,5,2).
request(5012,2,5,2). request(5013,2,5,3). request(5014,2,5,2). request(5015,2,5,2).
request(5016,2,5,2). request(5017,3,5,2). request(5018,3,5,3). request(5019,1,5,2).
request(5020,2,5,1). request(5021,3,5,1). request(5022,1,5,1). request(5023,2,5,2).
request(5024,2,5,2). request(5025,3,5,2). request(5026,3,5,2). request(5027,3,5,1).
request(5028,3,5,2). request(5029,3,5,2).
