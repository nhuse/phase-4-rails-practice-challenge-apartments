class ApartmentsController < ApplicationController
    
    def index
        render json: Apartment.all
    end

    def show
        apartment = Apartment.find_by(id: params[:id])
        if apartment
            render json: apartment
        else
            render json: { error: "Apartment not found"}, status: :not_found
        end
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        apartment = Apartment.find_by(id: params[:id])
        if apartment
            apartment.update!(apartment_params)
            render json: apartment, status: :accepted
        else
            render json: { error: "Apartment not found" }, status: :not_found
        end
    end

    def destroy
        apartment = Apartment.find_by(id: params[:id])
        if apartment
            apartment.destroy
            head :no_content
        else
            render json: { error: "Apartment not found" }, status: :not_found
        end
    end

    private

    def apartment_params
        params.permit(:id, :number)
    end
end
