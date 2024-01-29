(define (domain industrial_manufacturing)
	(:requirements
		:adl
		:negative-preconditions
		:conditional-effects
		:existential-preconditions
		:universal-preconditions
		:fluents
	)

	(:types
		location placeable - object
		work_station supply container robotic_agent - placeable
		valve bolt tool - supply
		box carrier - container
		amr drone - robotic_agent
		counter
	)

	(:constants
		warehouse - location
		cnt - counter
	)

	(:predicates
		(adjacent ?l1 - location ?l2 - location)
		(at ?p - placeable ?l - location)

		(attached ?r - robotic_agent ?c - carrier)
		(detached ?r - robotic_agent)

		(loaded ?c - carrier ?b - box)

		(filled ?b - box ?s - supply)
		(empty ?b - box)

		(locked ?o - (either container supply))
		(not_locked ?o - (either container supply))

		(delivered ?s - supply ?ws - work_station)
	)

	(:functions
		(loaded_volume ?c - carrier)
		(max_capacity ?c - carrier)
		(carrying_capability ?r - robotic_agent)
		(carrying_requirements ?c - carrier)
		(value ?cn - counter )
		(delivered_supply ?r - robotic_agent)
	)

	; Moves a robot between two locations, if it is not already there
	(:action move_robot
		:parameters (?r - robotic_agent ?c - carrier ?from ?to - location)
		:precondition (and
			(adjacent ?from ?to)
			(at ?r ?from)
			(attached ?r ?c)

			; move back to warehouse only if the carrier is empty
			(or
				(and 
					(not (= ?to warehouse))
				)
				(and
					(= ?to warehouse)
					(= (loaded_volume ?c) 0)
				)
			)
		)

		:effect (and
			(at ?r ?to)
			(not (at ?r ?from))

			(increase (value cnt) 1)
		)
	)

	; Attaches a carrier to a robot
	(:action attach_carrier
		:parameters(?c - carrier ?r - robotic_agent ?l - location)
		:precondition(and
			(at ?r ?l)
			(at ?c ?l)
			(detached ?r)
			(not_locked ?c)
			(< (carrying_requirements ?c) (carrying_capability ?r))
		)

		:effect (and
			(attached ?r ?c)
			(not (detached ?r))
			(locked ?c)
			(not (not_locked ?c))
			(not (at ?c ?l))

			(increase (value cnt) 1)
		)
	)

	; Detaches a carrier from a robot
	(:action detach_carrier
		:parameters (?r - robotic_agent ?c - carrier ?l - location)
		:precondition (and
			(at ?r ?l)
			(attached ?r ?c)
		)

		:effect (and
			(detached ?r)
			(not (attached ?r ?c))
			(not (locked ?c))
			(at ?c ?l)

			(increase (value cnt) 3)
		)
	)

	; Picks up a specific unloaded box and places it into the carrier
	(:action load_carrier
		:parameters(?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:precondition (and
			(at ?r ?l)
			(at ?b ?l)
			(attached ?r ?c)
			(not_locked ?b)

			(< (loaded_volume ?c) (max_capacity ?c))
		)

		:effect (and
			(loaded ?c ?b)
			(locked ?b)
			(not (not_locked ?b))
			(not (at ?b ?l))

			(increase (value cnt) 1)
			(increase (loaded_volume ?c) 1)
		)
	)

	; Puts down the loaded box
	(:action empty_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:precondition (and
			(at ?r ?l)
			(attached ?r ?c)
			(loaded ?c ?b)
		)

		:effect (and
			(not (loaded ?c ?b))
			(not (locked ?b))
			(at ?b ?l)

			(increase (value cnt) 3)
			(decrease (loaded_volume ?c) 1)
		)
	)

	; Fills a box with a specific supply
	(:action fill_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply)
		:precondition (and
			(at ?r warehouse)
			(at ?s warehouse)
			(attached ?r ?c)
			(loaded ?c ?b)
			(empty ?b)
			(not_locked ?s)
		)

		:effect (and
			(filled ?b ?s)
			(not (empty ?b))
			(not (at ?s warehouse))
			(locked ?s)
			(not (not_locked ?s))

			(increase (value cnt) 0.5)
		)
	)

	; Empties a box containing a specific supply
	(:action empty_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?l - location)
		:precondition (and
			(at ?r ?l)
			(attached ?r ?c)
			(loaded ?c ?b)
			(filled ?b ?s)
		)

		:effect (and
			(empty ?b)
			(not (filled ?b ?s))
			(at ?s ?l)
			(not (locked ?s))

			(increase (value cnt) 3)
		)
	)

	; Deliveries a specific supply to a specific work station
	(:action deliver_supply
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?ws - work_station ?l - location)
		:precondition (and
			(at ?ws ?l)
			(at ?r ?l)
			(attached ?r ?c)
			(loaded ?c ?b)
			(filled ?b ?s)
		)

		:effect (and
			(delivered ?s ?ws)
			(empty ?b)
			(not (filled ?b ?s))
			(at ?s ?l)

			(increase (delivered_supply ?r) 1)
		)
	)
)
