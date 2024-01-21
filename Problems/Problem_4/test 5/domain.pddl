(define (domain industrial_manufacturing)
	(:requirements
		:strips
		:typing
		:durative-actions
		:equality
		:fluents
	)

	(:types
		location - object
		work_station - object
		supply - object
		robotic_agent - object
		container - object
		
		valve bolt tool - supply
		box carrier - container
	)

	(:predicates
		(adjacent ?l1 - location ?l2 - location)

		(at_work_station ?ws - work_station ?l - location)
        (at_container ?c - container ?l - location)
        (at_supply ?s - supply ?l - location)
        (at_robotic_agent ?r - robotic_agent ?l - location)

		(attached ?r - robotic_agent ?c - carrier)
		(detached ?r - robotic_agent)

		(loaded ?c - carrier ?b - box)
	
		(filled ?b - box ?s - supply)
		(empty ?b - box)

		(locked_supply ?s - supply)
		(not_locked_supply ?s - supply)

		(locked_container ?c - container)
		(not_locked_container ?c - container)

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

			(at start (at_robotic_agent ?r ?from))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (at_robotic_agent ?r ?from)))
			(at start (not (availiable ?r)))

			(at end (at_robotic_agent ?r ?to))
			(at end (availiable ?r))
		)
	)

	; Attaches a carrier to a robot
	(:durative-action attach_carrier
		:parameters (?c - carrier ?r - robotic_agent ?l - location)
		:duration (= ?duration 4)
		:condition (and
			(over all (at_robotic_agent ?r ?l))
			(over all (at_container ?c ?l))
			(over all (< (carrying_requirements ?c) (carrying_capability ?r)))

			(at start (detached ?r))
			(at start (not_locked_container ?c))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (not_locked_container ?c)))
			(at start (not (at_container ?c ?l)))
			(at start (not (detached ?r)))
			(at start (locked_container ?c))	
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
			(over all (at_robotic_agent ?r ?l))
			(at start (attached ?r ?c))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (availiable ?r)))

			(at end (detached ?r))
			(at end (not (attached ?r ?c)))
			(at end (not (locked_container ?c)))
			(at end (at_container ?c ?l))
			(at end (availiable ?r))
		)
	)

	; Picks up a specific unloaded box and places it into the carrier
	(:durative-action load_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:duration (= ?duration 2)
		:condition (and
			(over all (at_robotic_agent ?r ?l))
			(over all (attached ?r ?c))
			(over all (< (loaded_volume ?c) (max_capacity ?c)))

			(at start (at_container ?b ?l))
			(at start (not_locked_container ?b))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (locked_container ?b))
			(at start (not (not_locked_container ?b)))
			(at start (not (at_container ?b ?l)))
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
			(over all (at_robotic_agent ?r ?l))
			(over all (attached ?r ?c))

			(at start (loaded ?c ?b))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (availiable ?r)))

			(at end (not (loaded ?c ?b)))
			(at end (not (locked_container ?b)))
			(at end (at_container ?b ?l))			
			(at end (decrease (loaded_volume ?c) 1))
			(at end (availiable ?r))
		)
	)

	; Fills a box with a specific supply
	(:durative-action fill_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?l - location)
		:duration (= ?duration 1)
		:condition (and
			(over all (attached ?r ?c))
			(over all (loaded ?c ?b))

			(at start (at_robotic_agent ?r ?l))
			(at start (at_supply ?s ?l))
			(at start (empty ?b))
			(at start (not_locked_supply ?s))
			(at start (availiable ?r))
		)

		:effect (and
			(at start (not (empty ?b)))
			(at start (not (at_supply ?s ?l)))
			(at start (locked_supply ?s))
			(at start (not (not_locked_supply ?s)))
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
			(over all (at_robotic_agent ?r ?l))
			(over all (attached ?r ?c))
			(over all (loaded ?c ?b))

			(at start (availiable ?r))
			(at start (filled ?b ?s))
		)

		:effect (and
			(at start (not (availiable ?r)))

			(at end (empty ?b))
			(at end (not (filled ?b ?s)))
			(at end (at_supply ?s ?l))
			(at end (not (locked_supply ?s)))
			(at end (availiable ?r))
		)
	)

	; Deliveries a specific supply to a specific work station
	(:durative-action deliver_supply
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?ws - work_station ?l - location)
		:duration (= ?duration 2)
		:condition (and
			(over all (at_work_station ?ws ?l))
			(over all (at_robotic_agent ?r ?l))
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
			(at end (at_supply ?s ?l))
			(at end (not (locked_supply ?s)))
		)
	)
)
