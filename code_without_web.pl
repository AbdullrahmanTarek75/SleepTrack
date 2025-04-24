:- dynamic known/2.

% Entry point
start :-
    nl, write('Welcome to SleepTrack Pro+'), nl,
    write('Your personal sleep consultation starts now.'), nl,
    consult_user,
    undo.

% Consultation logic
consult_user :-
    hypothesize(Diagnosis),
    nl, write('--- Consultation Result ---'), nl,
    format('Based on your responses, you may be experiencing: ~w~n', [Diagnosis]),
    provide_advice(Diagnosis), !.

consult_user :-
    nl, write('We could not determine a specific issue. Please consult a sleep specialist.').

% Hypothesis rules
hypothesize(insomnia) :-
    symptom(difficulty_falling_asleep),
    symptom(frequent_waking),
    symptom(unrefreshed_sleep),
    symptom(duration_over_week).

hypothesize(sleep_apnea) :-
    symptom(loud_snoring),
    symptom(daytime_sleepiness),
    symptom(waking_gasping),
    symptom(morning_headaches).

hypothesize(circadian_rhythm_disorder) :-
    symptom(go_to_bed_late),
    symptom(wake_up_late),
    symptom(feel_alert_at_night),
    symptom(drowsy_in_morning).

hypothesize(poor_sleep_hygiene) :-
    symptom(uses_screens_before_bed),
    symptom(no_fixed_sleep_schedule),
    symptom(room_not_dark),
    symptom(drinks_caffeine_at_night).

hypothesize(general_stress) :-
    symptom(feeling_stressed),
    symptom(racing_thoughts),
    symptom(work_or_study_pressure).

% Symptom handling
symptom(Symptom) :- known(Symptom, yes), !.
symptom(Symptom) :- known(Symptom, no), !, fail.
symptom(Symptom) :-
    question(Symptom, QuestionText),
    ask(Symptom, QuestionText),
    symptom(Symptom).

% Mapping symptom IDs to question text
question(difficulty_falling_asleep, 'Do you have trouble falling asleep?').
question(frequent_waking, 'Do you wake up often during the night?').
question(unrefreshed_sleep, 'Do you wake up feeling unrefreshed?').
question(duration_over_week, 'Have these issues lasted more than a week?').
question(loud_snoring, 'Has anyone told you that you snore loudly?').
question(daytime_sleepiness, 'Do you feel very sleepy or fatigued during the day?').
question(waking_gasping, 'Do you ever wake up gasping or choking for air?').
question(morning_headaches, 'Do you often wake up with headaches?').
question(go_to_bed_late, 'Do you usually go to bed very late?').
question(wake_up_late, 'Do you usually wake up late or miss mornings?').
question(feel_alert_at_night, 'Do you feel most awake or productive late at night?').
question(drowsy_in_morning, 'Are you drowsy or sluggish in the morning?').
question(uses_screens_before_bed, 'Do you use your phone or watch TV in bed?').
question(no_fixed_sleep_schedule, 'Do you have an irregular sleep schedule?').
question(room_not_dark, 'Is your room not fully dark at night?').
question(drinks_caffeine_at_night, 'Do you drink coffee or energy drinks in the evening?').
question(feeling_stressed, 'Do you feel stressed or anxious lately?').
question(racing_thoughts, 'Do you experience racing thoughts at bedtime?').
question(work_or_study_pressure, 'Are work or school responsibilities affecting your sleep?').

% Asking logic
ask(SymptomID, QuestionText) :-
    nl, write(QuestionText), write(' (y/n)'), nl,
    read_line_to_string(user_input, UserInput),
    normalize_response(UserInput, Response),
    handle_response(SymptomID, Response).

% Normalize user input
normalize_response(Input, yes) :-
    member(Input, ["y", "Y", "yes", "Yes", "YES"]), !.
normalize_response(Input, no) :-
    member(Input, ["n", "N", "no", "No", "NO"]), !.
normalize_response(_, unknown).

% Response handling
handle_response(Key, yes) :-
    asserta(known(Key, yes)).
handle_response(Key, no) :-
    asserta(known(Key, no)), fail.
handle_response(Key, unknown) :-
    write('Invalid input. Please answer with "y" or "n".'), nl,
    question(Key, QuestionText),
    ask(Key, QuestionText).

% Diagnosis advice
provide_advice(insomnia) :-
    write('- You may have insomnia. Try Cognitive Behavioral Therapy for Insomnia (CBT-I).'), nl,
    write('- Practice sleep restriction, stimulus control, and avoid clock watching.'), nl.

provide_advice(sleep_apnea) :-
    write('- You may have signs of sleep apnea. Please consult a sleep specialist.'), nl,
    write('- Consider undergoing a polysomnography (overnight sleep study).'), nl.

provide_advice(circadian_rhythm_disorder) :-
    write('- Your symptoms align with a circadian rhythm disorder.'), nl,
    write('- Try light therapy in the morning and avoid blue light at night.'), nl.

provide_advice(poor_sleep_hygiene) :-
    write('- Improve your sleep hygiene:'), nl,
    write('  * Go to bed and wake up at the same time daily.'), nl,
    write('  * Avoid caffeine after 2PM and remove screens from the bedroom.'), nl.

provide_advice(general_stress) :-
    write('- Stress may be affecting your sleep.'), nl,
    write('- Practice relaxation techniques such as meditation, deep breathing, and journaling.'), nl.

% Clear memory
undo :- retract(known(_, _)), fail.
undo.