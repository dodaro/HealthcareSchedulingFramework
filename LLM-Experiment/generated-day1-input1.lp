% Instance generated-day1-input1, transcribed from generated-day1-input1.nl
% Usage: clingo framework.lp ors_converter.lp generated-day1-input1.lp

% Time structure: 1 day, two shifts of 5 slots numbered 1 to 5.
horizon(1).
slots_per_shift(5).
first_slot(1).

% Operating rooms: room(Room, Specialty, Day, Shift).
room(1,1,1,(morning;afternoon)).
room(2,1,1,(morning;afternoon)).
room(3,2,1,(morning;afternoon)).
room(4,2,1,(morning;afternoon)).
room(5,3,1,(morning;afternoon)).
room(6,4,1,(morning;afternoon)).
room(7,5,1,(morning;afternoon)).
room(8,5,1,(morning;afternoon)).

% Surgeons: surgeon(Id, Specialty, Day, Shift).
surgeon(10,1,1,morning).   surgeon(11,1,1,morning).   surgeon(12,1,1,morning).
surgeon(13,1,1,afternoon). surgeon(14,1,1,afternoon). surgeon(15,1,1,afternoon).
surgeon(20,2,1,morning).   surgeon(21,2,1,morning).   surgeon(22,2,1,morning).
surgeon(23,2,1,afternoon). surgeon(24,2,1,afternoon). surgeon(25,2,1,afternoon).
surgeon(30,3,1,morning).   surgeon(31,3,1,morning).
surgeon(32,3,1,afternoon). surgeon(33,3,1,afternoon).
surgeon(40,4,1,morning).   surgeon(41,4,1,morning).
surgeon(42,4,1,afternoon). surgeon(43,4,1,afternoon).
surgeon(50,5,1,morning).   surgeon(51,5,1,morning).   surgeon(52,5,1,morning).
surgeon(53,5,1,afternoon). surgeon(54,5,1,afternoon). surgeon(55,5,1,afternoon).

% Anaesthetists: anaesthetist(Id, Specialty, Day, Shift).
anaesthetist(11,1,1,(morning;afternoon)).
anaesthetist(21,2,1,(morning;afternoon)).
anaesthetist(22,2,1,(morning;afternoon)).
anaesthetist(31,3,1,(morning;afternoon)).
anaesthetist(41,4,1,(morning;afternoon)).
anaesthetist(51,5,1,(morning;afternoon)).

% Daily workload limits (Id, Day, MaxSlots); people not listed have no daily limit.
surgeon_limit(10,1,2). surgeon_limit(13,1,2).
surgeon_limit(23,1,2). surgeon_limit(24,1,2).
surgeon_limit(30,1,2). surgeon_limit(32,1,2). surgeon_limit(33,1,2).
surgeon_limit(41,1,2). surgeon_limit(42,1,2).
surgeon_limit(50,1,2). surgeon_limit(51,1,2). surgeon_limit(52,1,2).
surgeon_limit(54,1,2). surgeon_limit(55,1,2).

anaesthetist_limit(11,1,5).
anaesthetist_limit(51,1,5).

% Requests: request(Id, Priority, Specialty, Duration).
request(1000,1,1,2). request(1001,2,1,2). request(1002,2,1,1). request(1003,2,1,2).
request(1004,3,1,1).
request(2000,1,2,1). request(2001,2,2,3). request(2002,2,2,2). request(2003,2,2,1).
request(2004,2,2,2). request(2005,2,2,2). request(2006,3,2,2). request(2007,3,2,2).
request(2008,3,2,2). request(2009,3,2,1). request(2010,3,2,2). request(2011,3,2,2).
request(2012,3,2,1). request(2013,3,2,1). request(2014,3,2,3).
request(3000,1,3,2). request(3001,2,3,2). request(3002,3,3,2).
request(4000,1,4,2). request(4001,2,4,2).
request(5000,1,5,1). request(5001,2,5,1). request(5002,2,5,2). request(5003,3,5,2).
request(5004,3,5,3).
