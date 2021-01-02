# Doctors-Office-SQL
Conceptual database design that is to be used to store, track, and retrieve doctor and patient information

Business Requirements:

1. One patient can see multiple doctors in the same office on the same day.
2. One doctor can see multiple patients on the same day
3. If one doctor see's the same patient multiple times in one day, it will only be recorded once in the database
4. Only primary phone numbers are recorded for each patient
5. A doctor can also be a patient
6. A doctor cannot be his/her own patient
7. Each patient can be given multiple prescriptions
8. Each patient can be given many medical tests
9. A patient cannot be given a new prescription or test without a prior visit to a doctor
10. Doctor ID starts with the the first two initials of thier first name preceeded by numbers (Jeff Green JE0294)
11. Patient ID is a system generated number
12. Data retrieval speed is a priority
