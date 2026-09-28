def domain_specific_cut(day, atoms, facts):
    long_exam_ids = {}
    mapping_registrations_to_exams = {}
    possible_cuts = []
    
    for atom in facts:
        if atom.name == 'hsf_exam_phase':
            # hsf_exam_phase(ExamID,Treatment,Phase,NumTS)
            exam_id, treatment, phase, num_ts = str(atom.arguments[0]), str(atom.arguments[1]), atom.arguments[2].number, atom.arguments[3].number
            if num_ts > 50 and phase == 4:
                if exam_id not in long_exam_ids:
                    long_exam_ids[exam_id] = set()
                long_exam_ids[exam_id].add(treatment)
        if atom.name == 'hsf_exam_registration':
            # hsf_exam_registration(RegID, ExamID)
            mapping_registrations_to_exams[str(atom.arguments[0])] = str(atom.arguments[1])
    for atom in atoms:    
        if atom.name == 'hsf_assign_ts_to_phase':
            # hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),Phase)
            registration_id, day_, treatment, ts_start, phase = str(atom.arguments[0]), str(atom.arguments[1]), str(atom.arguments[2]), atom.arguments[3].arguments[0].number, atom.arguments[4].number
            if phase == 4 and day_ == day and ts_start < 24:
                if registration_id in mapping_registrations_to_exams:
                    exam_id = mapping_registrations_to_exams[registration_id]
                    if exam_id in long_exam_ids and treatment in long_exam_ids[exam_id]:
                        possible_cuts.append(str(atom))

    constraint = ""
    for cut in possible_cuts:    
        constraint += ":- " + cut + ". " 
    if not possible_cuts:
        print("No constraints generated, something went wrong. Created file master_model.lp for debugging.")        
        with open("master_model.lp", "w") as f:
            f.write(".\n".join([str(atom) for atom in atoms]) + ".\n" + ".\n".join([str(fact) for fact in facts]) + ".\n")
            f.close()
        exit(1)
    return constraint if possible_cuts else None