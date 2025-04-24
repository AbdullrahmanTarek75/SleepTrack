import streamlit as st
import subprocess
import os

# User interface
st.set_page_config(page_title="🛌 Sleep Expert System", page_icon="🌙", layout="centered")

st.title("💤 SleepTrack Pro+")
st.subheader("Expert System for Diagnosing Sleep Issues")
st.markdown("Answer the following questions to identify the potential sleep problem you may be facing.")

# Define questions
questions = {
    "difficulty_falling_asleep": "Do you have trouble falling asleep when going to bed?",
    "frequent_waking": "Do you wake up several times during the night?",
    "unrefreshed_sleep": "Do you wake up feeling unrefreshed?",
    "duration_over_week": "Has the problem persisted for more than a week?",

    "loud_snoring": "Do you suffer from loud snoring?",
    "daytime_sleepiness": "Do you feel sleepy during the day?",
    "waking_gasping": "Do you wake up gasping for air or feeling suffocated?",
    "morning_headaches": "Do you suffer from headaches upon waking?",

    "go_to_bed_late": "Do you always go to bed late?",
    "wake_up_late": "Do you wake up late?",
    "feel_alert_at_night": "Do you feel more alert at night?",
    "drowsy_in_morning": "Do you feel drowsy in the morning?",

    "uses_screens_before_bed": "Do you use your phone or computer before bed?",
    "no_fixed_sleep_schedule": "Do you not have a regular sleep schedule?",
    "room_not_dark": "Is the room not dark while sleeping?",
    "drinks_caffeine_at_night": "Do you drink caffeine at night?",

    "feeling_stressed": "Do you feel stressed or anxious?",
    "racing_thoughts": "Do you have racing thoughts when trying to sleep?",
    "work_or_study_pressure": "Is work or study pressure affecting your sleep?"
}

# Collect answers
user_answers = {}

with st.form("sleep_form"):
    for key, question in questions.items():
        user_answers[key] = st.radio(question, ("Yes", "No"), horizontal=True, index=1)
    submitted = st.form_submit_button("Diagnose")

# Write answers to facts.pl
if submitted:
    with open("facts.pl", "w", encoding="utf-8") as f:
        for key, answer in user_answers.items():
            if answer == "Yes":
                f.write(f"known({key}, yes).\n")

    st.info("📋 Your answers have been saved, and the analysis is in progress...")

    # Run Prolog
    try:
        result = subprocess.run(
            ["swipl", "-s", "sleep_expert.pl", "-g", "start", "-t", "halt"],
            capture_output=True, text=True
        )
        output = result.stdout.strip()
        st.success("✅ Diagnosis:")
        st.code(output, language="markdown")
    except Exception as e:
        st.error(f"An error occurred while running the system: {e}")
