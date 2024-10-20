require 'date'
require './lib/vehicle'
require './lib/registrant'

# The Facility class stores the attributes of each Facility created.
class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :register_vehicle,
              :collected_fees

# Each Facility should be created with a name, address, and phone number attribute.
# Each Facility should keep track of the services offered, the vehicles that were registered, and the registraction fees collected.
  def initialize(facility_details)
    @name = facility_details[:name]
    @address = facility_details[:address]
    @phone = facility_details[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  # Method: add_service will accept a single String argument that adds to the services array, String elements
  # of the services offered at this facility
  def add_service(service)
    @services << service
    return @services
  end

=begin
  Method: register_vehicle accepts a single Object argument that will check the Objects attributes by first confirming.
  a. is the vehicle considered an antique by calling the vehicle class method "antique?"
  If this is true it collects a 25 dollar fee by adding 25 to the collected_fees variable
  b. is the vehicle considered an electric vehicle by calling the vehicle class method "electric_vehicle?"
  If this is true it collects a 200 dollar fee by adding 200 to the collected_fees variable
  c. If none of the above are true the vehicle is considered "regular"
  If this is true it collects a 100 dollar fee by adding 100 to the collected_fees variable

  It then applies a plate type by calling the vehicle class method "plate_type"
  It then applies a registration date by calling the vehicle class method "reg_date"
  It then adds the vehicle object to the registered_vehicles array
=end

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
      return vehicle
  end

# Method: administer_written_test accepts a single Object argument and starts by checking if the facility offers the service
# "Written Test" if it doesn't, it will return false.
# If it does it calls the registrant class method "take_written_test"
  def administer_written_test(registrant)
    unless @services.include?('Written Test')
      return false
    else
      registrant.take_written_test
    end
  end

# Method: administer_road_test accepts a single Object argument and starts by checking if the facility offers the service
# "Road Test" if it doesn't, it will return false.
# If it does it calls the registrant class method "take_road_test"
  def administer_road_test(registrant)
    unless @services.include?('Road Test')
      return false
    else
      registrant.take_road_test
    end
  end

# Method: renew_drivers_license accepts a single Object argument and starts by checking if the facility offers the service
# "Renew License" if it doesn't, it will return false.
# If it does it calls the registrant class method "renewed_license"
  def renew_drivers_license(registrant)
    unless @services.include?('Renew License')
      return false
    else
      registrant.renewed_license
    end
  end
end
