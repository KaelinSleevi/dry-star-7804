class DoctorsController < ApplicationController
    def show
        @doctor = Doctor.find(params[:id])
        @hospital = @doctor.hospital
    end
    
    def destroy
        @doctor = Doctor.find(params[:id])
        @patient = DoctorPatient.find_by(params[:patient_id])
        @patient.destroy
        redirect_to doctor_path(@doctor)
    end
end   