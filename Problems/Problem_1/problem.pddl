(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects 
		location1 location2 location3 - location

		work_station1 work_station2 work_station3 - work_station

		; at this stage of the project one box is enough
		; because we have just one robot and we assume 
		;the action of loading and unloading is instantaneous
		box1 - box

		valve1 valve2 - valve
		bolt1 bolt2 - bolt
		tool1 tool2 - tool

		robot1 - robotic_agent
	)

	(:init
		; locations
		(adjacent warehouse location2)
		(adjacent location1 location2)
		(adjacent location3 location2)

		(adjacent location2 warehouse)
		(adjacent location2 location1)
		(adjacent location2 location3)

		; work stations
		(at work_station1 location1)
		(at work_station2 location3)
		(at work_station3 location3)

		; boxes
		(at box1 warehouse)
		(empty box1)

		; robots
		(at robot1 warehouse)
		(free robot1)

		; supplies
		(at valve1 warehouse)
		(at valve2 warehouse)

		(at bolt1 warehouse)
		(at bolt2 warehouse)

		(at tool1 warehouse)
		(at tool2 warehouse)
	)

	(:goal (and
		(exists (?t - tool) (delivered ?t work_station1))
		(exists (?b - bolt) (delivered ?b work_station3))
		(exists (?t - tool) (delivered ?t work_station3))
	))
)
