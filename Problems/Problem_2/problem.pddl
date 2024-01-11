(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects
		location1 location2 location3 location4 - location
		work_station1 work_station2 work_station3 work_station4 work_station5 work_station6 work_station7 - work_station

		box1 box2 box3 box4 box5 box6 box7 - box
		
		amr1 - amr
		drone1 - drone
		
		carrier1  - small_carrier 
		carrier2 - medium_carrier
	
		valve1 valve2 valve3 valve4 - valve
		bolt1 bolt2 bolt3 bolt4 - bolt
		tool1 tool2 tool3 - tool
	)

	(:init
		; locations
		(adjacent warehouse location1)
		(adjacent warehouse location3)

		(adjacent location1 location2)
		(adjacent location3 location4)

		(adjacent location1 warehouse)
		(adjacent location3 warehouse)

		(adjacent location2 location1)
		(adjacent location4 location3)

		; work stations
		(at work_station1 location1)
		(at work_station2 location1)
		(at work_station3 location2)
		(at work_station4 location3)
		(at work_station5 location3)
		(at work_station6 location4)
		(at work_station7 location4)

		; boxes
		(empty box1)
		(unlocked box1)
		(at box1 warehouse)

		(empty box2)
		(unlocked box2)
		(at box2 warehouse)

		(empty box3)
		(unlocked box3)
		(at box3 warehouse)

		(empty box4)
		(unlocked box4)
		(at box4 warehouse)

		(empty box5)
		(unlocked box5)
		(at box5 warehouse)

		(empty box6)
		(unlocked box6)
		(at box6 warehouse)

		(empty box7)
		(unlocked box7)
		(at box7 warehouse)

		; robots
		(at amr1 warehouse)
		(dissociated amr1)

		(at drone1 warehouse)
		(dissociated drone1)

		; carriers
		(free carrier1)
		(at carrier1 warehouse)
		(unlocked carrier1)

		(free carrier2)
		(at carrier2 warehouse)
		(unlocked carrier2)

		; consumable supplies
		(at valve1 warehouse)
		(at valve2 warehouse)
		(at valve3 warehouse)
		(at valve4 warehouse)
	
		(at bolt1 warehouse)
		(at bolt2 warehouse)
		(at bolt3 warehouse)
		(at bolt4 warehouse)

		; durable supplies
		(at tool1 warehouse)
		(is_durable tool1)
		(unassigned tool1)

		(at tool2 warehouse)
		(is_durable tool2)
		(unassigned tool2)

		(at tool3 warehouse)
		(is_durable tool3)
		(unassigned tool3)
	)

	(:goal (and
		(and
			(exists (?v - valve) (delivered ?v work_station1))
			(exists (?b - bolt) (delivered ?b work_station1))		
			(exists (?t - tool) (delivered ?t work_station1))
		)

		(and
			(exists (?b - bolt) (delivered ?b work_station5))		
			(exists (?t - tool) (delivered ?t work_station5))
		)
	
		(forall (?t - tool) 
			(and
				(unassigned ?t)
				(at ?t warehouse)
			)
		)

		(forall (?r - robotic_agent) 
			(and
				(at ?r warehouse)
				(dissociated ?r)
			)
		)

		(forall (?c - carrier) 
			(and 
				(free ?c)
				(at ?c warehouse)
				(unlocked ?c)
			)
		)
		
		(forall (?b - box) 
			(and
				(empty ?b)
				(unlocked ?b)
				(at ?b warehouse)
			)
		)
	))
)
