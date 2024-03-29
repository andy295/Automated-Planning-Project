(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects
		location1 location2 location3 - location

		work_station1 work_station2 work_station3 - work_station

		box1 box2 box3 box4 - box

		drone1 - drone
		amr1 - amr

		carrier1 carrier2 - carrier

		valve1 - valve
		bolt1 - bolt
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
		(at_l work_station1 location1)
		(at_l work_station2 location3)
		(at_l work_station3 location3)

		; boxes
		(at_l box1 warehouse)
		(not_locked box1)
		(empty box1)

		(at_l box2 warehouse)
		(not_locked box2)
		(empty box2)

		(at_l box3 warehouse)
		(not_locked box3)
		(empty box3)

		(at_l box4 warehouse)
		(not_locked box4)
		(empty box4)

		;robots
		(at_l amr1 warehouse)
		(detached amr1)
		(availiable amr1)
		(= (carrying_capability amr1) 10)
		(= (delivered_supply amr1) 0)

		(at_l drone1 warehouse)
		(detached drone1)
		(availiable drone1)
		(= (carrying_capability drone1) 5)
		(= (delivered_supply drone1) 0)

		; carriers
		(at_l carrier1 warehouse)
		(not_locked carrier1)
		(= (loaded_volume carrier1) 0)
		(= (max_capacity carrier1) 3)
		(= (carrying_requirements carrier1) 8)

		(at_l carrier2 warehouse)
		(not_locked carrier2)
		(= (loaded_volume carrier2) 0)
		(= (max_capacity carrier2) 2)
		(= (carrying_requirements carrier2) 4)

		; supplies
		(at_l valve1 warehouse)
		(not_locked valve1)

		(at_l bolt1 warehouse)
		(not_locked bolt1)

		(at_l tool1 warehouse)
		(not_locked tool1)

		(at_l tool2 warehouse)
		(not_locked tool2)
	)

	(:goal (and
			(delivered bolt1 work_station1)
			(delivered_tool work_station1)
			(delivered_tool work_station3)
			(delivered valve1 work_station3)
		)
	)

	(:metric minimize (total-time))
)
