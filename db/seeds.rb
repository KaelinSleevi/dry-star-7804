# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@aurora = Hospital.create!(name: 'Aurora General')
@denver = Hospital.create!(name: 'Denver Metro')

@greg = @aurora.doctors.create!(name: 'Greg', specialty: 'Surgery', university: 'CSU')
@mark = @denver.doctors.create!(name: 'Mark', specialty: 'Cardiology', university: 'CU')

@mary = Patient.create!(name: 'Mary', age: 29)
@grace = Patient.create!(name: 'Grace', age: 23)
@leo = Patient.create!(name: 'Leo', age: 42)

DoctorPatient.create!(doctor_id: @greg.id, patient_id: @mary.id)
DoctorPatient.create!(doctor_id: @greg.id, patient_id: @grace.id)
DoctorPatient.create!(doctor_id: @mark.id, patient_id: @leo.id)