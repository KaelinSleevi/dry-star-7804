require 'rails_helper'

RSpec.describe Patient do
  it { should have_many :doctor_patients }
  it { should have_many(:doctors).through(:doctor_patients) }

    describe "instance methods" do
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

    it '#adults' do
      expect(Patient.adults).to eq([@mary, @leo])
    end

    it '#alphabetical_names' do
      expect(Patient.alphabetical_names).to eq([@grace, @leo, @mary])
    end
  end
end