0 {x(ID, D, TS, PrID, 0) : avail(TS, D)} 1 :- reg(ID, D, PrID).
{x(ID, D, START, PrID, P+1) : avail(START,D), START >= TS+NumTS, START < TS+NumTS+6} = 1 :- x(ID, D, TS, PrID, P), exam(PrID, P, NumTS), P >= 0, P < 3.
:- x(ID, _, TS, PrID, 3), exam(PrID, 3, NumTS), TS + NumTS >= 120.
:- #count{ID: timeAnamnesis(ID, TS)} > 2, avail(TS, D).
timeAnamnesis(ID, TS..TS+NumTS-1) :- x(ID, D, TS, PrID, 0), exam(PrID, 0, NumTS).
timeOccupation(ID, D, TS, END, PrID) :- x(ID, D, TS, PrID, 1), x(ID, D, END, PrID, 3).
res(ID, D, TS..END-1,0) :- timeOccupation(ID, D, TS, END, PrID), required_chair(PrID).
res(ID, D, TS..TS+NumTS-1,1) :- x(ID, D, TS, PrID, 3), exam(PrID, 3, NumTS), required_chair(PrID).
res(ID, D, TS..END+NumTS-1,1) :- timeOccupation(ID, D, TS, END, PrID), exam(PrID, 3, NumTS), not required_chair(PrID).
:- #count{ID: tomograph(T, ID, D), x(ID, D, _, X, _)} > N, limit(X, N), tomograph(T,_).
1 {chair(C, ID, D) : chair(C, _)} 1 :- x(ID, D, _, PrID, _), required_chair(PrID).
1 {tomograph(T, ID, D) : tomograph(T, _)} 1 :- x(ID, D, _, PrID, _).
:- chair(C, ID, D), tomograph(T, ID, D), chair(C, R1), tomograph(T, R2), R1 != R2.
chair(C, ID, D, TS) :- chair(C, ID, D), res(ID, D, TS, 0).
tomograph(T, ID, D, TS) :- tomograph(T, ID, D), res(ID, D, TS, 1).
:- #count{ID : chair(C, ID, D, TS)} > 1, chair(C,_), avail(TS, D).
:- #count{ID: tomograph(T, ID, D, TS)} > 1, tomograph(T,_), avail(TS, D).
:~ not x(ID, D, _, _,0), reg(ID, D, _), reg(ID, D, _). [1@2, ID]
:~ x(ID, _, START, PrID, 0), x(ID, _, END, _, 3), cost(PrID, NumTS), END - START - NumTS >= 0. [END - START - NumTS@1, ID]