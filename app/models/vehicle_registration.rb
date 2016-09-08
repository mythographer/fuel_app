class VehicleRegistration < ApplicationRecord
  has_many :vehicles

  # VRO - vehicle registration office
  belongs_to :vro_subject, class_name: Subject
  belongs_to :vehicle
  belongs_to :vehicle_registration_color
  belongs_to :vehicle_body_type, optional: true

  validates :doc_series, length: { maximum: 5 },
               uniqueness: { scope: :doc_no, case_sensitive: false,
                             unless: :without_sn? },
               allow_nil: true
  validates :doc_no, length: { maximum: 10 }, allow_nil: true
  validates :without_sn, inclusion: { in: [true, false] }
  validates :reg_date, inclusion: { in: Date.new(1900, 1, 1)..Date.today },
                       presence: true
  validates :temporary, inclusion: { in: [true, false] }
  validates :vin, vin: true, presence: true
  validates :reg_no, length: { maximum: 10 }, presence: true
  validates :manufacture_year, numericality: { greater_than_or_equal_to: 1990,
                                               less_than_or_equal_to: 2050 },
                               presence: true
  validates :vehicle_registration_color, presence: true
  validates :total_weight, numericality: { greater_than: 0 }, allow_nil: true
  validates :engine_capacity_cc, numericality: { greater_than: 0 },
                                 allow_nil: true
  validates :seating_capacity, numericality: { greater_than_or_equal_to: 0 },
                               allow_nil: true
  validates :special_notes, length: { maximum: 255 }, allow_nil: true
  validates :ext_reference, length: { maximum: 255 }, allow_nil: true

# def doc_serial_no
#   unless without_sn?
#     serial_no 
#   else
#     id.to_s
#   end 
# end

  def serial_no
    [doc_series, doc_no].join(' ')
  end

  private
    def without_sn?
      without_sn
    end
end
