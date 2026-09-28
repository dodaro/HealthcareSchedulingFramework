%Input converte ORS problem
hsf_day(DAY) :- mss(OPROOMID,SHIFT,QUAL,DAY).
hsf_timeslot(DAY,ts(ST,REALSHIFT+1)) :- time(SHIFT,ST), REALSHIFT = (SHIFT+1)\2, mss(OPROOMID,SHIFT,QUAL,DAY).

hsf_exam_registration(REGID, REGID) :- registration(REGID,PRI,SURGDUR,LOSS,SPECID,NDAY,NDAY2).
hsf_exam_specialty(REGID,SPECID) :- registration(REGID,PRI,SURGDUR,LOSS,SPECID,NDAY,NDAY2).
hsf_registration_priority(REGID,PRI) :- registration(REGID,PRI,SURGDUR,LOSS,SPECID,NDAY,NDAY2).
hsf_exam_phase(REGID,1,1,SURGDUR) :- registration(REGID,PRI,SURGDUR,LOSS,SPECID,NDAY,NDAY2). 

hsf_resource((OPROOMID,room)):- mss(OPROOMID,SHIFT,QUAL,DAY).
hsf_resource_category((OPROOMID,room), room) :- mss(OPROOMID,SHIFT,QUAL,DAY).
hsf_resource_specialty((OPROOMID,room),QUAL,DAY,REALSHIFT+1) :- mss(OPROOMID,SHIFT,QUAL,DAY), REALSHIFT = (SHIFT+1)\2.
hsf_required_resource(REGID,room,1,1) :- registration(REGID,PRI,SURGDUR,LOSS,SPECID,NDAY,NDAY2).
hsf_resource_shareability((OPROOMID,room),1) :- mss(OPROOMID,SHIFT,QUAL,DAY).

hsf_resource((SRGID,surgeon)) :- surgeon(SRGID,SPECID,SHIFT).
hsf_resource_category((SRGID,surgeon),surgeon) :- surgeon(SRGID,SPECID,SHIFT).
hsf_resource_shareability((SRGID,surgeon),1) :- surgeon(SRGID,SPECID,SHIFT).
hsf_resource_specialty((SRGID,surgeon),SPECID,DAY+1,REALSHIFT+1) :- surgeon(SRGID,SPECID,SHIFT), DAY=(SHIFT-1)/2, REALSHIFT = (SHIFT+1)\2.
hsf_required_resource(REGID,surgeon,1,1) :- registration(REGID,PRI,SURGDUR,LOSS,SPECID,NDAY,NDAY2).

hsf_resource((ANID,anaesthetist)) :- an(ANID,SPECID,SHIFT).
hsf_resource_category((ANID,anaesthetist), anaesthetist) :- an(ANID,SPECID,SHIFT).
hsf_resource_shareability((ANID,anaesthetist),1) :- an(ANID,SPECID,SHIFT).
hsf_resource_specialty((ANID,anaesthetist),SPECID,DAY+1,REALSHIFT+1) :- an(ANID,SPECID,SHIFT), DAY=(SHIFT-1)/2, REALSHIFT = (SHIFT+1)\2.
hsf_required_resource(REGID,anaesthetist,1,1) :- registration(REGID,PRI,SURGDUR,LOSS,SPECID,NDAY,NDAY2). 

hsf_avail((SRID,surgeon),sWT,DAY) :- surgeryTime(sWT,SRID,DAY).
hsf_avail((ANID,anaesthetist),aWT,DAY) :- anaesthetistWT(aWT,ANID,DAY).

hsf_priority_to_assign(1).
hsf_enable_maximization_of_registrations_by_priority(1).

hsf_allow_partial_assignment.