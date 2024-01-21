(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects
		warehouse location1 location2 location3 - location

		work_station1 work_station2 work_station3 - work_station

		box1 box2 box3 - box

		amr1 - robotic_agent

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
		(at_work_station work_station1 location1)
		(at_work_station work_station2 location3)
		(at_work_station work_station3 location3)

		; boxes
		(at_container box1 warehouse)
		(not_locked_container box1)
		(empty box1)

		(at_container box2 warehouse)
		(not_locked_container box2)
		(empty box2)

		(at_container box3 warehouse)
		(not_locked_container box3)
		(empty box3)

		;robots
		(at_robotic_agent amr1 warehouse)
		(detached amr1)
		(availiable amr1)

		(= (carrying_capability amr1) 10)
		(= (delivered_supply amr1) 0)

		; carriers
		(at_container carrier1 warehouse)
		(not_locked_container carrier1)
		(= (loaded_volume carrier1) 0)
		(= (max_capacity carrier1) 4)
		(= (carrying_requirements carrier1) 8)

		; supplies
		(at_supply valve1 warehouse)
		(not_locked_supply valve1)

		(at_supply valve2 warehouse)
		(not_locked_supply valve2)

		(at_supply bolt1 warehouse)
		(not_locked_supply bolt1)

		(at_supply bolt2 warehouse)
		(not_locked_supply bolt2)

		(at_supply tool1 warehouse)
		(not_locked_supply tool1)

		(at_supply tool2 warehouse)
		(not_locked_supply tool2)
	)

	(:goal (and
			(delivered valve1 work_station1)
			; (delivered tool1 work_station1)

			; (delivered bolt1 work_station3)
			; (delivered tool2 work_station3)
		)
	)

	(:metric minimize (total-time))
)
