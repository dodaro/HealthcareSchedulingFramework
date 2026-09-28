%Input converte CTSWeekly problem
hsf_day(D) :- day(D).
hsf_timeslot(D,ts(TimeSlot,none)) :- ats(TimeSlot), day(D).
hsf_exam_registration(RID,RID) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S).
hsf_exam_specialty(RID,none) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S).
hsf_registration_priority(RID,1) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S).
hsf_exam_phase(RID,ORDER+1,1,PH1) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S).
hsf_exam_phase(RID,ORDER+1,2,PH2) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S).
hsf_exam_phase(RID,ORDER+1,3,PH3) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S).
hsf_exam_phase(RID,ORDER+1,4,PH4) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S).

hsf_resource((SID,bed)):- bed(SID).
hsf_resource((SID,chair)):- chair(SID).

hsf_resource_category((SID,bed),seat) :- bed(SID).
hsf_resource_category((SID,chair),seat) :- chair(SID).

hsf_resource_specialty((SID,bed),none,D,none):- bed(SID), day(D).
hsf_resource_specialty((SID,chair),none,D,none):- chair(SID), day(D).

hsf_required_resource(RID,seat,4,4) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,_), PH4>0.

hsf_preferred_resource_type(RID,chair,4,4,Order+1) :- registration(RID,Order,_,PH4,_,_,_,0), PH4 > 0.
hsf_preferred_resource_type(RID,bed,4,4,Order+1) :- registration(RID,Order,_,PH4,_,_,_,1), PH4 > 0.

hsf_resource_shareability((SID,chair),1) :-  chair(SID).
hsf_resource_shareability((SID,bed),1) :-  bed(SID).

hsf_last_phase_can_overflow.


hsf_enable_maximization_of_preferred_resource(4).



%% WEEKLY SCHEDULE
hsf_next_treatment(RID,ORDER,ORDER+1,WDAY) :- registration(RID,ORDER,WDAY,PH4,PH3,PH2,PH1,S), ORDER>0.
