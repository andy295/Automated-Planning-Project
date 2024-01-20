(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects
		location1 location2 location3 location4 - location

		work_station1 work_station2 work_station3 work_station4 - work_station

		box1 box2 box3 - box

		robot1 robot2 - robotic_agent

		carrier1 carrier2 - carrier

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
		(empty box1)
		(at box2 warehouse)
		(empty box2)
		(at box3 warehouse)
		(empty box3)

		;robots
		(at robot1 warehouse)
		(free robot1)
		(= (carrying_capability robot1) 10)
		(= (delivered_supply robot1) 0)

		(at robot2 warehouse)
		(free robot2)
		(= (carrying_capability robot2) 10)
		(= (delivered_supply robot2) 0)

		(= (value cnt) 0)

		; carriers
		(at carrier1 warehouse)
		(= (loaded_volume carrier1) 0)
		(= (max_capacity carrier1) 3)
		(= (carrying_requirements carrier1) 8 )

		(at carrier2 warehouse)
		(= (loaded_volume carrier2) 0)
		(= (max_capacity carrier2) 3)
		(= (carrying_requirements carrier1) 8 )

		; supplies
		(at valve1 warehouse)
		(at valve2 warehouse)

		(at bolt1 warehouse)
		(at bolt2 warehouse)

		(at tool1 warehouse)
		(at tool2 warehouse)
	)

	(:goal (and

			(exists (?v - valve) (delivered ?v work_station1))
			(exists (?t - tool) (delivered ?t work_station1))
			
			(exists (?b - bolt) (delivered ?b work_station2))
			(exists (?t - tool) (delivered ?t work_station4))

			(exists (?b - bolt) (delivered ?b work_station3))

			; enable them if you want to enforce the usage of both robots
			; (> (delivered_supply robot1) 1)
			; (> (delivered_supply robot2) 1)
		)
	)

	(:metric minimize (value cnt) )
)
