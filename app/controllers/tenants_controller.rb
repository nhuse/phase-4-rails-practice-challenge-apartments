class TenantsController < ApplicationController
    
    def index
        render json: Tenant.all, include: ["leases", "apartments"]
    end

    def show
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            render json: tenant, include: ["leases", "apartments"]
        else
            render json: { error: "Tenant not found"}, status: :not_found
        end
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.update!(tenant_params)
            render json: tenant, status: :accepted
        else
            render json: { error: "Tenant not found" }, status: :not_found
        end
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
        tenant = Tenant.find_by(id: params[:id])
        if tenant
            tenant.destroy
            head :no_content
        else
            render json: { error: "Tenant not found" }, status: :not_found
        end
    end

    private

    def tenant_params
        params.permit(:id, :name, :age)
    end
end
