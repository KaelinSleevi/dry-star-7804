class PatientsController < ApplicationController
    def index
        @patients = Patient.adults
        @alphabetical_names = Patient.alphabetical_names
    end
end