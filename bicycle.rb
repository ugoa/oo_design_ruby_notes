module Schedulable
	attr_writer :schedule

	def schedule
		@schedule ||= Schedule.new
	end

	def schedulable?(start_date, end_date)
		!scheduled?(start_date - lead_days, end_date)
	end

	def scheduled?(start_date, end_date)
		schedule.scheduled?(self, start_date, end_date)
	end

	def lead_days
		0
	end
end

class Bicycle
	include Schedulable

	attr_reader :size, :chain, :tire_size

	def initialize(args={})
		@size      = args[:size]
		@chain     = args[:chain] || default_chain
		@tire_size = args[:tire_size] || default_tire_size

		local_initialize(args)
	end

	def local_initialize(args)
		nil
	end

	def spares
		{
			:chain     => chain, 
			:tire_size => tire_size 
		}.merge(local_spares)
	end

	def local_spares
		raise NotImplementedError,
			"Please override me in subclass. "
	end

	def default_chain
		"10-speed"
	end

	def default_tire_size
		{}
	end

	def lead_days
		2
	end
end

class Schedule
	def scheduled?(schedulable, start_date, end_date)
		p "This #{schedulable.class}" + " is not scheduled " + 
			"between #{start_date} and #{end_date}."
			false
	end
end

class Mechanic
	include Schedulable

	def prepare_trip(trip)
		trip.bicycles.each { |i| prepare_bicycle(i) }
	end

	def prepare_bicycle
		
	end

	def lead_days
		5
	end
end


# require 'date'
# starting = Date.parse("2014/09/08")
# ending = Date.parse("2014/09/14")

# b = Mechanic.new
# b.schedulable?(starting, ending)


