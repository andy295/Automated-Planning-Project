(define (domain industrial_manufacturing)
	(:requirements
		:strips
		:typing
		:durative-actions
		:equality
		:fluents
	)

	(:types
		location placeable - object
		work_station supply container robotic_agent - placeable
		valve bolt tool - supply
		box carrier - container
		amr drone - robotic_agent
	)

	(:constants
		warehouse - location
	)

	(:predicates
		(adjacent ?l1 - location ?l2 - location)
		(at_l ?p - placeable ?l - location)

		(attached ?r - robotic_agent ?c - carrier)
		(detached ?r - robotic_agent)

		(loaded ?c - carrier ?b - box)
	
		(filled ?b - box ?s - supply)
		(empty ?b - box)

		(locked ?o - (either container supply))
		(not_locked ?o - (either container supply))

		(delivered ?s - supply ?ws - work_station)
		(availiable ?r - robotic_agent)
	)

	(:functions
		(loaded_volume ?c - carrier)
		(max_capacity ?c - carrier)
		(carrying_capability ?r - robotic_agent)
		(carrying_requirements ?c - carrier)
		(delivered_supply ?r - robotic_agent)
	)

	; Moves a robot between two locations, if it is not already there
	(:durative-action move_robot
		:parameters (?r - robotic_agent ?c - carrier ?from ?to - location)
		:duration (= ?duration 2)
		:condition (and
			(over all (adjacent ?from ?to))
			(over all (attached ?r ?c))

			(at start (at_l ?r ?from))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (at_l ?r ?from)))
			(at start (not (availiable ?r)))

			(at end (at_l ?r ?to))
			(at end (availiable ?r))
		)
	)

	; Attaches a carrier to a robot
	(:durative-action attach_carrier
		:parameters (?c - carrier ?r - robotic_agent ?l - location)
		:duration (= ?duration 4)
		:condition (and
			(over all (at_l ?r ?l))
			(over all (at_l ?c ?l))
			(over all (< (carrying_requirements ?c) (carrying_capability ?r)))

			(at start (detached ?r))
			(at start (not_locked ?c))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (not_locked ?c)))
			(at start (not (at_l ?c ?l)))
			(at start (not (detached ?r)))
			(at start (locked ?c))	
			(at start (not (availiable ?r)))

			(at end (attached ?r ?c))
			(at end (availiable ?r))
		)
	)

	; Detaches a carrier from a robot
	(:durative-action detach_carrier
		:parameters (?r - robotic_agent ?c - carrier ?l - location)
		:duration (= ?duration 4)
		:condition (and
			(over all (at_l ?r ?l))
			(at start (attached ?r ?c))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (availiable ?r)))

			(at end (detached ?r))
			(at end (not (attached ?r ?c)))
			(at end (not (locked ?c)))
			(at end (at_l ?c ?l))
			(at end (availiable ?r))
		)
	)

	; Picks up a specific unloaded box and places it into the carrier
	(:durative-action load_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:duration (= ?duration 2)
		:condition (and
			(over all (at_l ?r ?l))
			(over all (attached ?r ?c))
			(over all (< (loaded_volume ?c) (max_capacity ?c)))

			(at start (at_l ?b ?l))
			(at start (not_locked ?b))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (locked ?b))
			(at start (not (not_locked ?b)))
			(at start (not (at_l ?b ?l)))
			(at start (increase (loaded_volume ?c) 1))
			(at start (not (availiable ?r)))

			(at end (loaded ?c ?b))
			(at end (availiable ?r))
		)
	)

	; Puts down the loaded box
	(:durative-action empty_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:duration (= ?duration 5)
		:condition (and
			(over all (at_l ?r ?l))
			(over all (attached ?r ?c))

			(at start (loaded ?c ?b))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (availiable ?r)))

			(at end (not (loaded ?c ?b)))
			(at end (not (locked ?b)))
			(at end (at_l ?b ?l))			
			(at end (decrease (loaded_volume ?c) 1))
			(at end (availiable ?r))
		)
	)

	; Fills a box with a specific supply
	(:durative-action fill_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply)
		:duration (= ?duration 1)
		:condition (and
			(over all (attached ?r ?c))
			(over all (loaded ?c ?b))

			(at start (at_l ?r warehouse))
			(at start (at_l ?s warehouse))
			(at start (empty ?b))
			(at start (not_locked ?s))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (empty ?b)))
			(at start (not (at_l ?s warehouse)))
			(at start (locked ?s))
			(at start (not (not_locked ?s)))
			(at start (not (availiable ?r)))

			(at end (filled ?b ?s))
			(at end (availiable ?r))
		)
	)

	; Empties a box containing a specific supply
	(:durative-action empty_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?l - location)
		:duration (= ?duration 4)
		:condition (and
			(over all (at_l ?r ?l))
			(over all (attached ?r ?c))
			(over all (loaded ?c ?b))

			(at start (availiable ?r))
			(at start (filled ?b ?s))
		)

		:effect (and
			(at start (not (availiable ?r)))

			(at end (empty ?b))
			(at end (not (filled ?b ?s)))
			(at end (at_l ?s ?l))
			(at end (not (locked ?s)))
			(at end (availiable ?r))
		)
	)

	; Deliveries a specific supply to a specific work station
	(:durative-action deliver_supply
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?ws - work_station ?l - location)
		:duration (= ?duration 2)
		:condition (and
			(over all (at_l ?ws ?l))
			(over all (at_l ?r ?l))
			(over all (attached ?r ?c))
			(over all (loaded ?c ?b))

			(at start (filled ?b ?s))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (filled ?b ?s)))
			(at start (increase (delivered_supply ?r) 1))
			(at start (not (availiable ?r)))

			(at end (delivered ?s ?ws))
			(at end (empty ?b))
			(at end (availiable ?r))
			(at end (at_l ?s ?l))
			(at end (not (locked ?s)))
		)
	)
)
