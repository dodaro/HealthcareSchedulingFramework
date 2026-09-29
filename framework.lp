hsf_has_multiple_treatments(RegID) :- hsf_exam_registration(RegID,_), #count{Treatment: hsf_next_treatment(RegID,Treatment,_,_)}>0.

% Assign a registration for the first treatment to a day: 1 denotes the first treatment. For daily scheduling, it is always 1.
{hsf_assign_day(RegID,D,1) : hsf_day(D)} <= 1 :- hsf_exam_registration(RegID, ExamID), hsf_allow_partial_assignment, not hsf_has_multiple_treatments(RegID).
{hsf_assign_day(RegID,D,1) : hsf_day(D)} = 1 :- hsf_exam_registration(RegID, ExamID), not hsf_allow_partial_assignment, not hsf_has_multiple_treatments(RegID).

{hsf_assign_day(RegID,D,1) : hsf_day(D), hsf_treatment_days(RegID,N), hsf_day(D+N)} = 1 :- hsf_exam_registration(RegID, ExamID), not hsf_allow_partial_assignment, hsf_has_multiple_treatments(RegID).
hsf_treatment_days(RegID,N) :- N = #sum{WaitingDays,Treatment: hsf_next_treatment(RegID,Treatment,NextTreatment,WaitingDays)}, hsf_exam_registration(RegID,_), hsf_has_multiple_treatments(RegID).

% For multiple days schedules, we might have consecutive treatments. We deterministically infer the next day.
hsf_assign_day(RegID,D2,NextTreatment) :- hsf_assign_day(RegID,D1,Treatment), hsf_next_treatment(RegID,Treatment,NextTreatment,WaitingDays), D2 = D1 + WaitingDays, hsf_day(D2), hsf_has_multiple_treatments(RegID).

% Compute the first time slot.
hsf_first_ts(D,Min) :- hsf_day(D), Min=#min{TS: hsf_timeslot(D,ts(TS,_))}.
% We compute the last phase.
hsf_last_phase(ExamID,Last) :- Last = #max{Phase : hsf_exam_phase(ExamID,_,Phase,_)}, hsf_exam_registration(RegID,ExamID).

% Compute the exam duration. If the last phase can overflow, the last phase is ignored.
hsf_exam_duration_without_last_phase(ExamID,Treatment,NumTStot) :- hsf_last_phase(ExamID,Last), hsf_exam_phase(ExamID,Treatment,_,_), NumTStot = #sum{NumTS,Phase: hsf_exam_phase(ExamID,Treatment,Phase,NumTS), Phase < Last}.
hsf_exam_duration(ExamID,Treatment,NumTStot) :- NumTStot = #sum{NumTS,Phase : hsf_exam_phase(ExamID,Treatment,Phase,NumTS)}, hsf_exam_phase(ExamID,Treatment,_,_).

hsf_distance_among_phases(RegID,Phase1,Phase2,Distance) :- hsf_exam_registration(RegID,ExamID), hsf_exam_phase(ExamID,Treatment,Phase1,_), hsf_exam_phase(ExamID,Treatment,Phase2,_), Phase1<Phase2, Distance = #sum{NumTS+K,Phase : hsf_exam_phase(ExamID,Treatment,Phase,NumTS), Phase1<=Phase<Phase2, hsf_increase_time_window(K)}.
hsf_real_distance_among_phases(RegID,Phase1,Phase2,Distance) :- hsf_exam_registration(RegID,ExamID), hsf_exam_phase(ExamID,Treatment,Phase1,_), hsf_exam_phase(ExamID,Treatment,Phase2,_), Phase1<Phase2, RealDistance = #sum{NumTS,Phase : hsf_exam_phase(ExamID,Treatment,Phase,NumTS), Phase1<=Phase<Phase2}, Distance=RealDistance.
hsf_distance_among_phases(RegID,Phase1,Phase2,Distance) :- hsf_real_distance_among_phases(RegID,Phase1,Phase2,Distance), not hsf_increase_time_window.

% Guess the starting time slot for the last phase.
{hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),Last): hsf_timeslot(D,ts(Start,Shift)), hsf_first_ts(D,Min), Start-NumTS >= Min, hsf_timeslot(D,ts(Start+Duration-1,Shift)), hsf_exam_duration_without_last_phase(ExamID,Treatment,NumTS), hsf_exam_phase(ExamID,Treatment,Last,Duration)} = 1 :- hsf_last_phase(ExamID,Last), hsf_exam_registration(RegID, ExamID), hsf_assign_day(RegID,D,Treatment), not hsf_last_phase_can_overflow.

{hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),Last): hsf_timeslot(D,ts(Start,Shift)), hsf_first_ts(D,Min), Start-NumTS >= Min, hsf_exam_duration_without_last_phase(ExamID,Treatment,NumTS)} = 1 :- hsf_last_phase(ExamID,Last), hsf_exam_registration(RegID, ExamID), hsf_assign_day(RegID,D,Treatment), hsf_last_phase_can_overflow.

% Compute the previous phase for a given registration and phase.
hsf_previous_phase(RegID,ExamID,Treatment,Phase,Phase1) :- hsf_exam_registration(RegID, ExamID), hsf_exam_phase(ExamID,Treatment,Phase,NumTS), Phase1=#max{P: hsf_exam_phase(ExamID,Treatment,P,NumTS1), NumTS1>0, P<Phase}, Phase1!=#inf.

% Derive if time window is increased. Often, it is needed to have a waiting time before and after a phase.
hsf_increase_time_window :- hsf_increase_time_window(X).

% Assign the starting timeslot to previous phases (if any). In this way we prevent that a phase p_i starts before p_{i-1} is completed.
hsf_assign_ts_to_phase(RegID,D,Treatment,ts(TS1,Shift),Phase1) :- hsf_assign_ts_to_phase(RegID,D,Treatment,ts(TS2,Shift),Phase2), hsf_previous_phase(RegID,ExamID,Treatment,Phase2,Phase1), hsf_exam_registration(RegID, ExamID), hsf_exam_phase(ExamID,Treatment,Phase1,NumTS), TS1=TS2-NumTS, hsf_timeslot(D,ts(TS1,Shift)), not hsf_increase_time_window.

% Assign the starting timeslot to previous phases (if any), and leave a time window.
{hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),Phase1) : hsf_timeslot(D,ts(Start,Shift)), hsf_timeslot(D,ts(TS-NumTS-K,Shift)), TS-NumTS-K<Start <= TS-NumTS} = 1 :- hsf_assign_ts_to_phase(RegID,D,Treatment,ts(TS,Shift),Phase), hsf_previous_phase(RegID,ExamID,Treatment,Phase,Phase1), hsf_exam_registration(RegID, ExamID), hsf_exam_phase(ExamID,Treatment,Phase1,NumTS), hsf_increase_time_window(K).

% Derive the shift where a registration is assigned in a given day.
hsf_assigned_shift(RegID,D,Treatment,Shift) :- hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),P).

% Assign exactly one required resource for (category, specialty).
{hsf_assign_resource(RegID,D,R) : hsf_resource(R), hsf_resource_category(R, ResourceCategory), hsf_resource_specialty(R,ResSpecialty,D,Shift), hsf_exam_registration(RegID,ExamID), hsf_exam_specialty(ExamID,ResSpecialty)} = 1 :- hsf_assigned_shift(RegID,D,Treatment,Shift), hsf_required_resource(RegID,ResourceCategory,_,_).

hsf_time_occupation(RegID, D, ts(Start,Shift), ts(Start2-1,Shift), ResourceType) :- hsf_assign_resource(RegID,D,(RID,ResourceType)), hsf_required_resource(RegID, ResourceCategory,StartPhase,EndPhase), hsf_resource_category((RID, ResourceType), ResourceCategory), hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),StartPhase), hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start2,Shift),NextPhase), hsf_previous_phase(RegID,ExamID,Treatment,NextPhase,EndPhase), hsf_real_distance_among_phases(RegID,StartPhase,NextPhase,RealDistance), Start2-Start >= RealDistance, Start2-Start<=Distance, hsf_distance_among_phases(RegID,StartPhase,NextPhase,Distance).

hsf_time_occupation(RegID, D, ts(Start,Shift), ts(Start2+NumTS-1,Shift), ResourceType) :- hsf_assign_resource(RegID,D,(RID,ResourceType)), hsf_required_resource(RegID, ResourceCategory,StartPhase,EndPhase), hsf_resource_category((RID, ResourceType), ResourceCategory), hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),StartPhase), hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start2,Shift), EndPhase), Start <= Start2, hsf_last_phase(ExamID, EndPhase), StartPhase != EndPhase, hsf_exam_registration(RegID,ExamID), hsf_exam_phase(ExamID,Treatment,EndPhase,NumTS), hsf_real_distance_among_phases(RegID,StartPhase,EndPhase,RealDistance), Start2-Start >= RealDistance, Start2-Start<=Distance, hsf_distance_among_phases(RegID,StartPhase,EndPhase,Distance).

hsf_time_occupation(RegID, D, ts(Start,Shift), ts(Start+NumTS-1,Shift), ResourceType) :- hsf_assign_resource(RegID,D,(RID,ResourceType)), hsf_required_resource(RegID, ResourceCategory,Phase,Phase), hsf_resource_category((RID, ResourceType), ResourceCategory), hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),Phase), hsf_last_phase(ExamID, Phase), hsf_exam_registration(RegID,ExamID), hsf_exam_phase(ExamID,Treatment,Phase,NumTS).

hsf_time_occupation(RegID, D, ts(Start..End,Shift), ResourceType) :- hsf_time_occupation(RegID, D, ts(Start,Shift), ts(End,Shift), ResourceType).


% Each resource can be assigned to at most k patients.
:- hsf_resource_shareability((ResourceID,ResourceType),K), hsf_day(D), hsf_timeslot(D,TS), #count{RegID : hsf_assign_resource(RegID,D,(ResourceID,ResourceType)), hsf_time_occupation(RegID, D, TS, ResourceType)} > K.

% All registrations with a given priority must be scheduled.
:- hsf_priority_to_assign(P), hsf_registration_priority(RegID,P), not hsf_assign_day(RegID,_,_).

% A resource for a specific exam cannot be used in a day more than its working time.
:- hsf_avail(R,NumTS1,D), #sum{NumTS,RegID,Treat: hsf_assign_resource(RegID,D,R), hsf_assign_day(RegID,D,Treat), hsf_exam_registration(RegID,ExamID), hsf_exam_duration(ExamID,Treat,NumTS)} > NumTS1.

% A resource for a specific exam cannot be used in a day more than a fixed limit.
:- hsf_limit(ExamID,R,D,N), #count{RegID: hsf_assign_resource(RegID,D,R), hsf_exam_registration(RegID, ExamID)} > N.

% Give preference to registration with higher priority.
hsf_max_priorities(X) :- #max{P: hsf_registration_priority(_,P)} = X.
:~ not hsf_assign_day(RegID,_,_), hsf_registration_priority(RegID,P), hsf_max_priorities(Max), P != 1, hsf_enable_maximization_of_registrations_by_priority(LEVEL). [1@LEVEL+Max-P, RegID]

% Minimize the missed preferences of resources.
hsf_assigned_resource(RegID,D,ResType) :- hsf_assign_resource(RegID,D,(_,ResType)).
:~ not hsf_assigned_resource(RegID,D,ResType), hsf_assigned_shift(RegID,D,Treatment,_), hsf_preferred_resource_type(RegID,ResType,_,_,Treatment), hsf_enable_maximization_of_preferred_resource(Level). [1@Level,D,RegID,ResType]

%minimize the not assigned patients
:~ hsf_exam_registration(RegID,_), hsf_day(D), not hsf_assign_day(RegID,D,_), hsf_enable_maximization_of_registrations(LEVEL). [1@LEVEL, RegID,D] 

%minimize the unnecessary time spent in the hospital
:~ hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),1), hsf_assign_ts_to_phase(RegID,D,Treatment,ts(End,Shift),Last), hsf_exam_registration(RegID, ExamID), hsf_last_phase(ExamID,Last), hsf_exam_duration_without_last_phase(ExamID,Treatment,NumTStot), End-Start-NumTStot>=0, hsf_enable_avoid_time_waste(LEVEL). [End-Start-NumTStot@LEVEL, RegID]
