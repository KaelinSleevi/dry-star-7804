require 'rails_helper'


RSpec.describe 'When I visit the hospitals show page' do
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

    it 'I see the hospitals name' do
        visit hospital_path(@aurora)
        
        expect(page).to have_content("#{@aurora.name}")
        expect(page).to_not have_content("#{@denver.name}")
    end

    it 'And I see the names of all doctors that work at this hospital' do
        visit hospital_path(@aurora)
  
        expect(page).to have_content("Doctors: #{@greg.name}")
        expect(page).to_not have_content(" Doctors: #{@mark.name}")
    end

    it 'And next to each doctor I see the number of patients associated with the doctor' do
        visit hospital_path(@aurora)

        expect(page).to have_content("Patients:")
        expect(page).to have_content("#{@mary.name}")
        expect(page).to have_content("#{@grace.name}")
        expect(page).to_not have_content("#{@leo.name}")
    end

    xit 'And I see the list of doctors is ordered from most number of patients to least number of patients' do
        visit hospital_path(@aurora)

    end
end