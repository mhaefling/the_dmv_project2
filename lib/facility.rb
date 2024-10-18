require 'date'

class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :register_vehicle,
              :collected_fees

  def initialize(facility_details)
    @name = facility_details[:name]
    @address = facility_details[:address]
    @phone = facility_details[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    unless services.include?('Vehicle Registration')
      exit
    else
      if vehicle.antique? == true
        @collected_fees += 25
        vehicle.plate_type = :antique
        vehicle.registration_date = Date.today
      elsif vehicle.electric_vehicle? == true
        @collected_fees += 200
        vehicle.plate_type = :ev
        vehicle.registration_date = Date.today
      else
        @collected_fees = 100
        vehicle.plate_type = :regular
        vehicle.registration_date = Date.today
      end
    end
      @registered_vehicles << vehicle
  end
end
