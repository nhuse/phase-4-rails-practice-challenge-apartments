class Lease < ApplicationRecord
  belongs_to :apartment
  belongs_to :tenant

  validates :apartment_id, presence: true
  validates :tenant_id, presence: true
end
