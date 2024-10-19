class Registrant
    attr_reader :name,
                :age,
                :permit,
                :license_data

    def initialize(name, age, permit = false)
        @name = name
        @age = age
        @permit = permit
        @license_data = {
            written: false,
            license: false,
            renewed: false
        }
    end

    def permit?
        @permit
    end

    def earn_permit
        @permit = true
    end

    def take_written_test
        if @permit == true && @age >= 16
            @license_data[:written] = true
        else
            false
        end
    end

    def take_road_test
        if @license_data[:written] == true
            @license_data[:license] = true
        else
            false
        end
    end

    def renewed_license
        if @license_data[:license] == true
            @license_data[:renewed] = true
        else
            false
        end
    end
end