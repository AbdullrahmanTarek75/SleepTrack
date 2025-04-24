:- dynamic known/2.
:- [facts].

ask(Question) :-
    write(Question), write("? "),
    read(Response),
    assertz(known(Question, Response)),
    Response = yes.

% Rules:
problem('Insomnia') :-
    known(difficulty_falling_asleep, yes),
    known(frequent_waking, yes),
    known(unrefreshed_sleep, yes),
    known(duration_over_week, yes).

problem('Sleep Apnea') :-
    known(loud_snoring, yes),
    known(daytime_sleepiness, yes),
    known(waking_gasping, yes),
    known(morning_headaches, yes).

problem('Delayed Sleep Phase Disorder') :-
    known(go_to_bed_late, yes),
    known(wake_up_late, yes),
    known(feel_alert_at_night, yes),
    known(drowsy_in_morning, yes).

problem('Poor Sleep Hygiene') :-
    known(uses_screens_before_bed, yes);
    known(no_fixed_sleep_schedule, yes);
    known(room_not_dark, yes);
    known(drinks_caffeine_at_night, yes).

problem('Stress-Related Sleep Disorder') :-
    known(feeling_stressed, yes),
    known(racing_thoughts, yes),
    known(work_or_study_pressure, yes).

% Start execution
start :-
    problem(Diagnosis),
    format(" Diagnosis: ~w~n", [Diagnosis]),
    advice(Diagnosis).

start :-
    write(" We could not determine the condition based on the current information.").

% Advice
advice('Insomnia') :-
    write(" Advice: Try to go to bed at the same time every day and avoid caffeine before sleep.").

advice('Sleep Apnea') :-
    write(" Advice: It's recommended to consult a sleep disorder specialist.").

advice('Delayed Sleep Phase Disorder') :-
    write(" Advice: Try adjusting your bedtime gradually and reduce light exposure at night.").

advice('Poor Sleep Hygiene') :-
    write(" Advice: Make sure your room is dark and avoid screens before sleep.").

advice('Stress-Related Sleep Disorder') :-
    write(" Advice: Practice relaxation exercises and talk to a friend or mental health professional.").
