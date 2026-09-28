%at most two patients at a time slot are allowed during the anamnesis phase
timeAnamnesis(RegID, TS..TS+NumTS-1) :- hsf_assign_ts_to_phase(RegID,D,Treatment,ts(TS,Shift),1), hsf_exam_registration(RegID,ExamID), hsf_exam_phase(ExamID,Treatment,1,NumTS).
:-  hsf_day(D), hsf_timeslot(D,ts(TS,Shift)), #count{RegID: timeAnamnesis(RegID, TS)} >2.

%patients requiring an injection chair must be assigned to the tomograph of the same room
:- hsf_assign_resource(RegID,D,(ChairId,chair)), hsf_assign_resource(RegID,D,(TomId,tomograph)), hsf_resource_allocation((ChairId,chair),Room1), hsf_resource_allocation((TomId,tomograph),Room2), Room1 != Room2.

