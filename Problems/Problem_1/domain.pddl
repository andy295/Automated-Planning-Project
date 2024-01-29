(define (domain industrial_manufacturing)
	(:requirements
		:adl
		:negative-preconditions
		:conditional-effects
		:existential-preconditions
		:universal-preconditions
	)

	(:types
		location placeable - object
		work_station box supply robotic_agent - placeable
		valve bolt durable tool - supply
		robotic_agent
	)

	(:constants
		warehouse - location
	)

	(:predicates
		(adjacent ?l1 - location ?l2 - location)
		(at ?p - placeable ?l - location)

		(full ?b - box ?s - supply)
		(empty ?b - box)

		(loaded ?r - robotic_agent ?b - box)
		(free ?r - robotic_agent)

		(locked ?o - (either box supply))

		(delivered ?s - supply ?ws - work_station)
	)

	; Moves a robot between two locations, if it is not already there
	(:action move_robot
		:parameters (?r - robotic_agent ?from ?to - location)
		:precondition (and
			(not (= ?from ?to))
			(adjacent ?from ?to)
			(at ?r ?from)
		)

		:effect (and
			(at ?r ?to)
			(not (at ?r ?from))
		)
	)

	; Picks up a specific unloaded box
	(:action load_robot
		:parameters (?r - robotic_agent ?b - box ?l - location)
		:precondition (and
			(at ?r ?l)
			(free ?r)
			(at ?b ?l)
			(not (locked ?b))
		)

		:effect (and
			(loaded ?r ?b)
			(not (free ?r))
			(locked ?b)
			(not (at ?b ?l))
		)
	)

	; Puts down the loaded box
	(:action free_robot
		:parameters (?r - robotic_agent ?b - box ?l - location)
		:precondition (and
			(at ?r ?l) 
			(loaded ?r ?b)
		)

		:effect (and
			(free ?r)
			(not (loaded ?r ?b))
			(not (locked ?b))
			(at ?b ?l)
		)
	)

	; Fills a box with a specific supply
	(:action fill_box
		:parameters (?r - robotic_agent ?b - box ?s - supply)
		:precondition (and
			(at ?r warehouse)
			(at ?s warehouse)
			(loaded ?r ?b)
			(empty ?b)
			(not (locked ?s))
		)

		:effect (and
			(full ?b ?s)
			(not (empty ?b))
			(not (at ?s warehouse))
			(locked ?s)
		)
	)

	; Empties a box containing a specific supply
	(:action empty_box
		:parameters (?r - robotic_agent ?b - box ?s - supply ?l - location)
		:precondition (and
			(at ?r ?l)
			(loaded ?r ?b)
			(full ?b ?s)
		)	

		:effect (and
			(empty ?b)
			(not (full ?b ?s))
			(at ?s ?l)
			(not (locked ?s))
		)
	)

	; Deliveries a specific supply to a specific work station
	(:action deliver_supply
		:parameters (?r - robotic_agent ?b - box ?s - supply ?ws - work_station ?l - location)
		:precondition (and
			(not (delivered ?s ?ws))
			(at ?ws ?l)
			(at ?r ?l)
			(loaded ?r ?b)
			(full ?b ?s)
		)

		:effect (and
			(delivered ?s ?ws)
			(empty ?b)
			(not (full ?b ?s))
			(at ?s ?l)
		)
	)
)
