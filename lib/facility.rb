require 'date'
require './lib/vehicle'
require './lib/registrant'

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
    unless @services.include?('Vehicle Registration')
      return nil
    else
      if vehicle.antique?
        @collected_fees += 25
        vehicle.reg_plate_type
        vehicle.reg_date
      elsif vehicle.electric_vehicle?
        @collected_fees += 200
        vehicle.reg_plate_type
        vehicle.reg_date
      else
        @collected_fees += 100
        vehicle.reg_plate_type
        vehicle.reg_date
      end
    end
      @registered_vehicles << vehicle
  end

  def administer_written_test(registrant)
    unless @services.include?('Written Test')
      return false
    else
      registrant.take_written_test
    end
  end

  def administer_road_test(registrant)
    unless @services.include?('Road Test')
      return false
    else
      registrant.take_road_test
    end
  end

  def renew_drivers_license(registrant)
    unless @services.include?('Renew License')
      return false
    else
      registrant.renewed_license
    end
  end
end
