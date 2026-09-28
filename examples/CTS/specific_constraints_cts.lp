% % ---- Specific of CTS problem ----
:- hsf_assign_ts_to_phase(RegID,D,Treatment,ts(TS,_),4), hsf_exam_registration(RegID, ExamID), hsf_exam_phase(ExamID,Treatment,4,NumTS), NumTS>50, TS<24.
numbReg(D,N,TS):- N = #count{RegID: hsf_assign_ts_to_phase(RegID,D,Treatment,TS,2)}, hsf_day(D), hsf_timeslot(D,TS).
numMax(D,T) :- T = #max{N: numbReg(D,N,_)}, hsf_day(D).
numMin(D,T) :- T = #min{N: numbReg(D,N,_), N != 0}, hsf_day(D).
numbDay(D,N) :- N = #count{RegID: hsf_assign_ts_to_phase(RegID,D,Treatment,_,2)}, hsf_day(D).
numMaxDay(T) :- T = #max{N:numbDay(D,N)}.
:~ numMax(DAY,M). [M@3,DAY]
:~ numMax(DAY,M), numMin(DAY,N). [M-N@2]
:~ numMaxDay(T). [T@1]

