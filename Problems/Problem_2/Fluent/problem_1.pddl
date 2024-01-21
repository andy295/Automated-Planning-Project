(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects
		location1 location2 location3 - location

		work_station1 work_station2 work_station3 - work_station

		box1 box2 box3 box4 - box

		amr1 - amr

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

		(adjacent location2 warehouse)
		(adjacent location2 location1)
		(adjacent location2 location3)

		; work stations
		(at work_station1 location1)
		(at work_station2 location3)
		(at work_station3 location3)

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
		(at amr1 warehouse)
		(detached amr1)
		(= (carrying_capability amr1) 10)
		(= (delivered_supply amr1) 0)

		; counters
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
			(exists (?b - bolt) (delivered ?b work_station2))
			(exists (?b - bolt) (delivered ?b work_station3))
		)
	)

	(:metric minimize (value cnt))
)
