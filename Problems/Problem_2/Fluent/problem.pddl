(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects
		location1 location2 location3 location4 - location

		work_station1 work_station2 work_station3 work_station4 - work_station

		box1 box2 box3 - box

		robot1 - robotic_agent

		carrier1 - carrier

		valve1 valve2 - valve
		bolt1 bolt2 - bolt
		tool1 tool2 - tool
	)

	(:init
		; locations
		(adjacent warehouse location2)
		(adjacent location1 location2)
		(adjacent location3 location2)
		(adjacent location4 location2)

		(adjacent location2 warehouse)
		(adjacent location2 location1)
		(adjacent location2 location3)
		(adjacent location2 location4)

		; work stations
		(at work_station1 location1)
		(at work_station2 location3)
		(at work_station3 location4)
		(at work_station4 location4)

		; boxes
		(at box1 warehouse)
		(not_locked box1)
		(empty box1)

		(at box2 warehouse)
		(not_locked box2)
		(empty box2)

		(at box3 warehouse)
		(not_locked box3)
		(empty box3)

		;robots
		(at robot1 warehouse)
    	(detached robot1)

		(= (carrying_capability robot1) 10)
		(= (delivered_supply robot1) 0)

		(= (value cnt) 0)

		; carriers
		(at carrier1 warehouse)
		(not_locked carrier1)
		(= (loaded_volume carrier1) 0)
		(= (max_capacity carrier1) 4)
		(= (carrying_requirements carrier1) 8)

		; supplies
		(at valve1 warehouse)
		(not_locked valve1)

		(at valve2 warehouse)
		(not_locked valve2)

		(at bolt1 warehouse)
		(not_locked bolt1)

		(at bolt2 warehouse)
		(not_locked bolt2)

		(at tool1 warehouse)
		(not_locked tool1)

		(at tool2 warehouse)
		(not_locked tool2)
	)

	(:goal (and

			(exists (?v - valve) (delivered ?v work_station1))
			(exists (?t - tool) (delivered ?t work_station1))

			(exists (?b - bolt) (delivered ?b work_station3))
			(exists (?t - tool) (delivered ?t work_station4))
		)
	)

	(:metric minimize (value cnt))
)
