def domain_specific_cut(day, atoms, facts):    
    exam_ids = {}
    mapping_registrations_to_exams = {}
    ts_list = set()
    resource_location = {}
    for atom in facts:
        if atom.name == 'hsf_exam_phase' and atom.arguments[2].number == 1:
            exam_ids[str(atom.arguments[0])] = (str(atom.arguments[1]), atom.arguments[3].number)
        if atom.name == 'hsf_exam_registration':
            mapping_registrations_to_exams[str(atom.arguments[0])] = str(atom.arguments[1])  
        if atom.name == 'hsf_timeslot':
            if str(atom.arguments[0]) == day:
                ts_list.add(atom.arguments[1].arguments[0].number)
        if atom.name == 'hsf_resource_allocation':
            resource_id, resource_type, room = str(atom.arguments[0].arguments[0]), str(atom.arguments[0].arguments[1]), str(atom.arguments[1])
            resource_location[(resource_id, resource_type)] = room
    
    patient_to_duration_of_first_phase = {}
    for atom in atoms:            
        if atom.name == 'hsf_assign_ts_to_phase':
            # hsf_assign_ts_to_phase(RegID,D,Treatment,ts(Start,Shift),Phase)
            registration_id, day_, ts_start, phase = str(atom.arguments[0]), str(atom.arguments[1]), atom.arguments[3].arguments[0].number, atom.arguments[4].number
            if phase == 1 and day_ == day and registration_id in mapping_registrations_to_exams:
                exam_id = mapping_registrations_to_exams[registration_id]
                if exam_id in exam_ids:
                    for i in range(ts_start, ts_start + exam_ids[exam_id][1]):
                        if registration_id not in patient_to_duration_of_first_phase:
                            patient_to_duration_of_first_phase[registration_id] = []
                        patient_to_duration_of_first_phase[registration_id].append(i)

    constraints = []    
    for ts in ts_list:      
        conflict_atoms = []
        for atom in atoms:                
            if atom.name == 'hsf_assign_ts_to_phase':
                registration_id, day_, phase = str(atom.arguments[0]), str(atom.arguments[1]), atom.arguments[4].number
                if phase == 1 and day_ == day:
                    assert registration_id in patient_to_duration_of_first_phase, \
                        f"missing anamnesis interval for registration {registration_id} on day {day}"
                    if ts in patient_to_duration_of_first_phase[registration_id]:
                        conflict_atoms.append((registration_id, atom))
        if len(conflict_atoms) > 2:
            elements = "; ".join(f"{r} : {a}" for r, a in conflict_atoms)
            constraints.append(f":- #count{{ {elements} }} > 2.")

    patient_resources = {}
    for atom in atoms:
        if atom.name == 'hsf_assign_resource':
            # hsf_assign_resource(RegID,D,(RID,ResourceType))
            registration_id, day_, resource_id, resource_type = str(atom.arguments[0]), str(atom.arguments[1]), str(atom.arguments[2].arguments[0]), str(atom.arguments[2].arguments[1])
            if day_ == day:
                if registration_id not in patient_resources:
                    patient_resources[registration_id] = {}
                assert str(resource_type) in ["chair", "tomograph"]                    
                patient_resources[registration_id][resource_type] = (atom, resource_location[(resource_id, resource_type)])

    for patient in patient_resources:
        if "chair" in patient_resources[patient] and "tomograph" in patient_resources[patient]:   
            if patient_resources[patient]["chair"][1] != patient_resources[patient]["tomograph"][1]:
                constraints.append(f":- {patient_resources[patient]['chair'][0]}, {patient_resources[patient]['tomograph'][0]}.")

    if not constraints:
        print("No constraints generated, something went wrong. Created file master_model.lp for debugging.")        
        with open("master_model.lp", "w") as f:
            f.write(".\n".join([str(atom) for atom in atoms]) + ".\n" + ".\n".join([str(fact) for fact in facts]) + ".\n")
            f.close()
        exit(1)
    return " ".join(constraints) if constraints else None