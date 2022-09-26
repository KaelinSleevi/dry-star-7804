class HospitalsController < ApplicationController
    def show
        @hospital = Hospital.find(params[:id])
        @doctors = @hospital.doctors
    end
end