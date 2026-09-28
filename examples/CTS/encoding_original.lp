{x(RID,DAY,TS,PH4,0,S): ats(TS), day(DAY)}=1 :- registration(RID,0,_,PH4,PH3,PH2,PH1,S).
% {x(RID,DAY,TS,PH4,0,S): ts(TS), day(DAY)}=1 :- registration(RID,0,_,PH4,PH3,PH2,PH1,S).

%% WEEKLY SCHEDULE
{x(RID,DAY+DAY2,TS,PH4,ORDER,C): ats(TS)}=1 :- x(RID,DAY,_,_,N,_), reg(RID,ORDER,DAY2,PH4,PH3,PH2,PH1,C),ORDER=N+1,day(DAY+DAY2).

assigned(RID,Order) :- x(RID,_,_,_,Order,_).
:- registration(RID,Order,_,_,_,_,_,_), not assigned(RID,Order).

:- x(RID,DAY,TS,_,ORDER,_), registration(RID,ORDER,_,_,PH3,PH2,PH1,S), TS-PH3-PH2-PH1<1.
:- x(RID,DAY,TS,PH4,_,_), PH4>50, TS<24.
1 {bed(ID,RID,DAY): bed(ID); chair(ID,RID,DAY): chair(ID)} 1 :- x(RID,DAY,_,_,_,_).
res(RID,DAY,TS..TS+PH4-1) :- x(RID,DAY,TS,PH4,_,_), PH4>0.
chair(ID,RID,DAY,TS) :- chair(ID,RID,DAY), res(RID,DAY,TS).
bed(ID,RID,DAY,TS) :- bed(ID,RID,DAY), res(RID,DAY,TS).
% :-#count{RID: chair(ID,RID,DAY,TS)} > 1, chair(ID), day(DAY), ts(TS).
% :-#count{RID: bed(ID,RID,DAY,TS)} > 1, bed(ID), day(DAY), ts(TS).
:-#count{RID: chair(ID,RID,DAY,TS)} > 1, chair(ID), day(DAY), ats(TS).
:-#count{RID: bed(ID,RID,DAY,TS)} > 1, bed(ID), day(DAY), ats(TS).
support(RID,DAY,StartPH2) :- x(RID,DAY,PH4,_,ORDER,_), registration(RID,ORDER,_,_,PH3,PH2,_,_), PH2>0, PH4-PH3-PH2=StartPH2, ats(StartPH2).
numbReg(DAY,N,TS) :- N = #count{RID: support(RID,DAY,TS)}, day(DAY), ats(TS).
numMax(DAY,T) :- T = #max{N: numbReg(DAY,N,_)}, day(DAY).
numMin(DAY,T) :- T = #min{N: numbReg(DAY,N,_), N != 0}, day(DAY).
numbDay(DAY,N) :- N = #count{RID: support(RID,DAY,_)}, day(DAY).
numMaxDay(T) :- T = #max{N:numbDay(DAY,N)}.
:~ x(RID,DAY,_,_,_,1), chair(_,RID,DAY). [1@4,DAY,RID,bed]
:~ x(RID,DAY,_,_,_,0), bed(_,RID,DAY). [1@4,DAY,RID,chair]
:~ numMax(DAY,M). [M@3,DAY]
:~ numMax(DAY,M), numMin(DAY,N). [M-N@2]
:~ numMaxDay(T). [T@1]

#show bed/3.
#show chair/3.
#show x/6.