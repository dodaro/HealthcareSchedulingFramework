registration(0,1,2,11,1,0,1). registration(1,2,1,9,1,0,1). registration(2,2,3,10,1,0,1). registration(3,3,2,8,1,0,1). registration(4,3,2,7,1,1,1).
registration(5,1,2,12,2,0,1). registration(6,2,2,10,2,0,1). registration(7,2,1,8,2,0,1). registration(8,3,3,9,2,0,0). registration(9,3,1,6,2,2,0).

#const totRegsP1 = 2. #const totRegsP2 = 4. #const totRegsP3 = 4.


mss(1,1,1,1). mss(1,2,1,1). mss(2,1,1,1). mss(2,2,1,1). mss(3,1,2,1). mss(3,2,2,1). mss(4,1,2,1). mss(4,2,2,1).

#const shift_duration = 5.


time(1,1..5). time(2,1..5).


surgeon(10,1,1). surgeon(11,1,1). surgeon(12,1,2). surgeon(13,1,2).
surgeon(21,2,1). surgeon(22,2,1). surgeon(23,2,2). surgeon(24,2,2).


#const sWT = 4.
surgeryTime(sWT,10,1). surgeryTime(sWT,11,1). surgeryTime(sWT,12,1). surgeryTime(sWT,13,1).
surgeryTime(sWT,21,1). surgeryTime(sWT,22,1). surgeryTime(sWT,23,1). surgeryTime(sWT,24,1).


an(11,1,1). an(12,1,1). an(11,1,2). an(12,1,2).
an(21,2,1). an(22,2,1). an(21,2,2). an(22,2,2).


#const aWT = 6.
anaesthetistWT(aWT,11,1). anaesthetistWT(aWT,12,1).
anaesthetistWT(aWT,21,1). anaesthetistWT(aWT,22,1).
