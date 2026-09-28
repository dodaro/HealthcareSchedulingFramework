check_ok.
#show check_ok/0.

x(RegID,D,TS,NumTSPh4,Treatment,S) :- hsf_assign_ts_to_phase(RegID,D,Treatment+1,ts(TS,Shift),Last),hsf_exam_registration(RegID,ExamID), hsf_last_phase(ExamID,Last), hsf_exam_phase(ExamID,Treatment+1,Last,NumTSPh4), registration(RegID,Treatment,_,_,_,_,_,S).
bed(B,RegID,D) :- hsf_assign_resource(RegID,D,(B,bed)).
chair(C,RegID,D) :- hsf_assign_resource(RegID,D,(C,chair)).

%%%:- registration(RID,T,_,_,_,_,_,_), #count{assigned(RID,DAY,TS,T): ats(TS), day(DAY)} != 1.
:- registration(RID,T,_,_,_,_,_,_), assigned(RID,DAY1,_,T), assigned(RID,DAY2,_,T), DAY1!=DAY2.
:- registration(RID,T,_,_,_,_,_,_), assigned(RID,DAY,TS1,T), assigned(RID,DAY,TS2,T), TS1!=TS2.
assigned(RID,DAY,TS,T):-x(RID,DAY,TS,_,T,_).
assigned(RID,T) :- assigned(RID,DAY,TS,T).
:- registration(RID,T,_,_,_,_,_,_), not assigned(RID,T).

:- x(RID,DAY,TS,_,ORDER,_), registration(RID,ORDER,_,_,PH3,PH2,PH1,S), N=TS-PH3-PH2-PH1, N<1.

:- x(RID,DAY,TS,PH4,_,_), PH4>50, TS<24.
res(RID,DAY,TS..TS+PH4-1) :- x(RID,DAY,TS,PH4,_,_), PH4>0.
chair(ID,RID,DAY,TS) :- chair(ID,RID,DAY), res(RID,DAY,TS).
bed(ID,RID,DAY,TS) :- bed(ID,RID,DAY), res(RID,DAY,TS).
:-#count{RID: chair(ID,RID,DAY,TS)} > 1, chair(ID), day(DAY), ats(TS).
:-#count{RID: bed(ID,RID,DAY,TS)} > 1, bed(ID), day(DAY), ats(TS).
support(RID,DAY,StartPH2) :- x(RID,DAY,PH4,_,ORDER,_), registration(RID,ORDER,_,_,PH3,PH2,_,_), PH2>0, PH4-PH3-PH2=StartPH2, ats(StartPH2).
numbReg(DAY,N,TS) :- N = #count{RID: support(RID,DAY,TS)}, day(DAY), ats(TS).
numMax(DAY,T) :- T = #max{N: numbReg(DAY,N,_)}, day(DAY).
numMin(DAY,T) :- T = #min{N: numbReg(DAY,N,_), N != 0}, day(DAY).
numbDay(DAY,N) :- N = #count{RID: support(RID,DAY,_)}, day(DAY).
:~ x(RID,DAY,_,_,_,1), chair(_,RID,DAY). [1@4,DAY,RID,bed]
:~ x(RID,DAY,_,_,_,0), bed(_,RID,DAY). [1@4,DAY,RID,chair]
:~ numMax(DAY,M). [M@3,DAY]
:~ numMax(DAY,M), numMin(DAY,N). [M-N@2]
:~ numMaxDay(T). [T@1]