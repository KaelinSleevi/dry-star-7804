require 'rails_helper'


RSpec.describe 'When I visit the patients index page' do
    before(:each) do
        @aurora = Hospital.create!(name: 'Aurora General')
        @denver = Hospital.create!(name: 'Denver Metro')

        @greg = @aurora.doctors.create!(name: 'Greg', specialty: 'Surgery', university: 'CSU')
        @mark = @denver.doctors.create!(name: 'Mark', specialty: 'Cardiology', university: 'CU')

        @mary = Patient.create!(name: 'Mary', age: 29)
        @grace = Patient.create!(name: 'Grace', age: 17)
        @leo = Patient.create!(name: 'Leo', age: 42)

        DoctorPatient.create!(doctor_id: @greg.id, patient_id: @mary.id)
        DoctorPatient.create!(doctor_id: @greg.id, patient_id: @grace.id)
        DoctorPatient.create!(doctor_id: @mark.id, patient_id: @leo.id)
    end

    it 'I see the names of all adult patients (age is greater than 18)' do
        visit patients_path

        expect(page).to have_content("List of Patients")
        expect(page).to have_content("#{@mary.name}")
        expect(page).to have_content("#{@leo.name}")
        expect(page).to_not have_content("#{@grace.name}")
    end

    it 'I see the names are in ascending alphabetical order(A-Z)' do
        visit patients_path

        expect("Leo").to appear_before("Mary")
        expect("Mary").to_not appear_before("Leo")
    end
end