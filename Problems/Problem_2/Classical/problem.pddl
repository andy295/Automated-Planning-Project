(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects
		location1 location2 location3 - location

		work_station1 work_station2 work_station3 - work_station

		box1 box2 box3 box4 box5 - box

		drone1 - drone
		amr1 - amr

		carrier1 carrier2 - carrier

		valve1 valve2 - valve
		bolt1 bolt2 - bolt
		tool1 tool2 - tool

		n0 n1 n2 n3 n4 - quantity
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

		(at box2 warehouse)
		(empty box2)

		(at box3 warehouse)
		(empty box3)

		(at box4 warehouse)
		(empty box4)

		(at box5 warehouse)
		(empty box5)

		; robots
		(at amr1 warehouse)
		(detached amr1)
		(is_big amr1)

		(at drone1 warehouse)
		(detached drone1)
		(is_small drone1)

		; carriers
		(at carrier1 warehouse)
		(empty carrier1)
		(has_space carrier1)
		(is_big carrier1)
		(contained carrier1 n0)

		(at carrier2 warehouse)
		(empty carrier2)
		(has_space carrier2)
		(is_small carrier2)
		(contained carrier2 n0)

		; supplies
		(at valve1 warehouse)
		(at valve2 warehouse)

		(at bolt1 warehouse)
		(at bolt2 warehouse)

		(at tool1 warehouse)
		(at tool2 warehouse)

		; relations between quantities
		(increased_by_1 n0 n1)
		(increased_by_1 n1 n2)
		(increased_by_1 n2 n3)
		(increased_by_1 n3 n4)

		(decreased_by_1 n1 n0)
		(decreased_by_1 n2 n1)
		(decreased_by_1 n3 n2)
		(decreased_by_1 n4 n3)

		(big_max_quantity n3)
		(small_max_quantity n2)
		(all_min_quantity n0)
	)

	(:goal (and
		(exists (?v - valve) (delivered ?v work_station1))
		(exists (?b - bolt) (delivered ?b work_station2))	
		(exists (?b - bolt) (delivered ?b work_station3))
	))
)
