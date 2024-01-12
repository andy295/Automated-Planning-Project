(define (problem industrial_manufacturing)
	(:domain industrial_manufacturing)

	(:objects 
		location1 location2 location3 - location
		location4 location5 location6 - location

		work_station1 work_station2 work_station3 - work_station
		work_station4 work_station5 work_station6 - work_station 

		; at this stage of the project one box is enough
		; because we have just one robot and we assume 
		;the action of loading and unloading is instantaneous
		box1 - box

		valve1 valve2 valve3 - valve
		bolt1 bolt2 bolt3 - bolt
		tool1 tool2 - tool

		robot1 - robotic_agent
	)

	(:init
		; locations
		(adjacent warehouse location2)

		(adjacent location1 location2)
		(adjacent location1 location4)

		(adjacent location2 warehouse)
		(adjacent location2 location1)
		(adjacent location2 location3)
		(adjacent location2 location5)

		(adjacent location3 location2)
		(adjacent location3 location6)

		(adjacent location4 location1)
		(adjacent location4 location5)

		(adjacent location5 location2)
		(adjacent location5 location4)
		(adjacent location5 location6)

		(adjacent location6 location3)
		(adjacent location6 location5)

		; work stations
		(at work_station1 location1)
		(at work_station2 location1)
		(at work_station3 location3)
		(at work_station4 location4)
		(at work_station5 location6)
		(at work_station6 location6)

		; boxes
		(at box1 warehouse)
		(empty box1)

		; robots
		(at robot1 warehouse)
		(free robot1)

		; supplies
		(at valve1 warehouse)
		(at valve2 warehouse)
		(at valve3 warehouse)

		(at bolt1 warehouse)
		(at bolt2 warehouse)
		(at bolt3 warehouse)

		(at tool1 warehouse)
		(at tool2 warehouse)
	)

	(:goal (and
		; (and
		; 	(exists (?v - valve) (delivered ?v work_station1))
		; 	(exists (?b - bolt) (delivered ?b work_station1))
		; 	(exists (?t - tool) (delivered ?t work_station1))
		; )

		(and
			(exists (?b - bolt) (delivered ?b work_station5))		
			(exists (?t - tool) (delivered ?t work_station5))
		)

		(exists (?b - bolt) (delivered ?b work_station3))

		;(forall (?r - robotic_agent) 
		;	(and 
		;		(free ?r)
		;		(at ?r warehouse)
		;	)
		;)

		; (forall (?b - box) 
		; 	(and
		; 		(empty ?b)
		; 		(not (locked ?b))
		; 		(at ?b warehouse)
		; 	)
		; )
	))
)
