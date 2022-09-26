require 'rails_helper'


RSpec.describe 'When I visit the doctors show page' do
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

    describe 'I see all the doctors information including:' do
        it 'Their name' do
            visit doctor_path(@greg)

            expect(page).to have_content("Name: #{@greg.name}")
            expect(page).to_not have_content("Name: #{@mark.name}")
        end

        it 'Their specialty' do
            visit doctor_path(@greg)

            expect(page).to have_content("Specialty: #{@greg.specialty}")
            expect(page).to_not have_content("Specialty: #{@mark.specialty}")
        end

        it 'Their university' do
            visit doctor_path(@greg)

            expect(page).to have_content("University: #{@greg.university}")
            expect(page).to_not have_content("University: #{@mark.university}")
        end

        it 'The hospital they work at' do
            visit doctor_path(@greg)

            expect(page).to have_content("Hospital: #{@aurora.name}")
            expect(page).to_not have_content("Hospital: #{@denver.name}")
        end

        it 'The names of all their patients' do
            visit doctor_path(@greg)

            expect(page).to have_content("Patient: #{@mary.name}")
            expect(page).to have_content("Patient: #{@grace.name}")
            expect(page).to_not have_content("Patient: #{@leo.name}")
        end

        it 'Next to each patients name, I see a button to remove that patient from that doctors caseload' do
            visit doctor_path(@greg)

            expect(page).to have_button("Remove Patient: #{@grace.name}")
            expect(page).to have_button("Remove Patient: #{@mary.name}")
            expect(page).to_not have_button("Remove Patient: #{@leo.name}")
        end

        it 'When I click that button for one patient, Im brought back to the Doctors show page And I no longer see that patients name listed' do
            visit doctor_path(@greg)
 
            click_button "Remove Patient: #{@mary.name}"
            expect(current_path).to eq(doctor_path(@greg))

            expect(page).to_not have_content("Patient: #{@mary.name}")
            expect(page).to have_content("Patient: #{@grace.name}")
        end
    end
end