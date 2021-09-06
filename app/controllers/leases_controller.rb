class LeasesController < ApplicationController
    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created

    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
        lease = Lease.find_by(id: params[:id])
        if lease
            lease.destroy
            head :no_content
        else
            render json: { error: "Lease not found" }, status: :not_found
        end
    end

    private

    def lease_params
        params.permit(:id, :tenant_id, :apartment_id, :rent)
    end
end
