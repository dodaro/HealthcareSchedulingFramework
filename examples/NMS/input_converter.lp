%Input converte NMS problem
hsf_day(D) :- reg(ID,D,PrID).
hsf_timeslot(D,ts(TS,none)) :- avail(TS,D), TS < 119.
hsf_exam_registration(ID, PrID) :- reg(ID,D,PrID).
hsf_exam_specialty(PrID,none) :- reg(ID,D,PrID).

hsf_exam_phase(PrID,1,P+1,NumTS) :- exam(PrID,P,NumTS).

hsf_resource((T,tomograph)) :- tomograph(T,R).
hsf_resource_category((T,tomograph),tomograph) :- tomograph(T,R).
hsf_resource_specialty((T,tomograph),none,D,none) :- tomograph(T,R), hsf_day(D).
hsf_resource_shareability((T,tomograph),1) :- tomograph(T,R).
hsf_resource_allocation((T,tomograph),R) :- tomograph(T,R).

hsf_resource((C,chair)) :- chair(C,R).
hsf_resource_category((C,chair),chair) :- chair(C,R).
hsf_resource_specialty((C,chair),none,D,none) :- chair(C,R), hsf_day(D).
hsf_resource_shareability((C,chair),1) :- chair(C,R).
hsf_resource_allocation((C,chair),R) :- chair(C,R).

hsf_required_resource(RegID,tomograph,2,4) :- reg(RegID,D,PrID), not required_chair(PrID).
hsf_required_resource(RegID,chair,2,3) :- reg(RegID,D,PrID), required_chair(PrID).
hsf_required_resource(RegID,tomograph,4,4) :- reg(RegID,D,PrID), required_chair(PrID).

hsf_limit(ExamID,(T,tomograph),D,N) :- hsf_day(D), tomograph(T,_), limit(ExamID,N).

#const k = 6.
hsf_increase_time_window(k).
hsf_allow_partial_assignment.
hsf_enable_maximization_of_registrations(2).
hsf_enable_avoid_time_waste(1).