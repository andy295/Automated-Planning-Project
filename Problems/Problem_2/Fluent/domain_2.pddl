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
		counter
	)

	(:constants
		warehouse - location
		cnt - counter
	)

	(:predicates
		(adjacent ?l1 - location ?l2 - location)
		(at ?p - placeable ?l - location)

		(filled ?b - box ?s - supply)
		(empty ?b - box)

		(loaded ?r - robotic_agent ?b - box)
		(free ?r - robotic_agent)

		(locked ?o - (either box supply))

		(contained ?b - box ?c - carrier)

		(delivered ?s - supply ?ws - work_station)

		(attached ?c - carrier ?r - robotic_agent)
		(with_cart ?r - robotic_agent)
		(with_robot ?c - carrier)
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
	(:action move_robot_with_cart
		:parameters (?r - robotic_agent ?c - carrier ?from ?to - location)
		:precondition (and
			(free ?r) ;robot is not holding anything
			(not (= ?from ?to))
			(adjacent ?from ?to)
			(at ?r ?from)
			(at ?c ?from)
			(attached ?c ?r)
		)

		:effect (and
			(not (at ?r ?from))
			(not (at ?c ?from))
			(increase (value cnt) 1)
			(at ?c ?to)
			(at ?r ?to)
		)
	)

	; Attaches a carrier to a robot
	(:action attach_carrier
		:parameters(?c - carrier ?r - robotic_agent ?l - location)
		:precondition(and
			(not (with_cart ?r))
			(not (with_robot ?c))
			(at ?r ?l)
			(at ?c ?l)
			(free ?r) ;robot is not holding anything
			(< (carrying_requirements ?c) (carrying_capability ?r))
		)

		:effect (and
			(attached ?c ?r)
			(with_cart ?r)
			(with_robot ?c)
		)
	)

	; Detaches a carrier from a robot
	(:action detach_carrier
		:parameters(?c - carrier ?r - robotic_agent)
		:precondition(and
			(attached ?c ?r)
		)

		:effect(and
			(not (with_cart ?r))
			(not (with_robot ?c))
			(not (attached ?c ?r))
		)
	)

	; Picks up a specific unloaded box and places it into the carrier
	(:action load_carrier
		:parameters(?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:precondition (and
			(at ?r ?l) ;everithing is in the same spot
			(at ?c ?l)
			(loaded ?r ?b) ;has the robot the box
			(< (loaded_volume ?c) (max_capacity ?c))
		)

		:effect (and
			(not (loaded ?r ?b))
			(free ?r)
			(contained ?b ?c)
			(not (locked ?b))

			(increase (loaded_volume ?c) 1)
		)
	)

	; Picks up a specific loaded box and from a carrier
	(:action pick_box_from_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:precondition(and
			(at ?r ?l) ;everithing is in the same spot
			(at ?c ?l)
			(free ?r) ;robot is not holding anything
			(contained ?b ?c)
		)

		:effect(and
			(locked ?b)
			(not (free ?r))
			(loaded ?r ?b)
			(not (contained ?b ?c))

			(decrease (loaded_volume ?c) 1)
		)
	)

	; Picks up a specific unloaded box and places it into the robot
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
			(filled ?b ?s)
			(not (empty ?b))
			(not (at ?s warehouse))
			(locked ?s)
		)
	)

	; Fills a box contained in as specific carrier with a specific supply
	(:action fill_box_in_cart
		:parameters (?r - robotic_agent ?b - box ?s - supply ?c - carrier)
		:precondition (and
			(at ?r warehouse)
			(at ?s warehouse)
			(at ?c warehouse)
			(contained ?b ?c)
			(empty ?b)
			(not (locked ?s))
		)

		:effect (and
			(filled ?b ?s)
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
			(filled ?b ?s)
		)

		:effect (and
			(empty ?b)
			(not (filled ?b ?s))
			(at ?s ?l)
			(not (locked ?s))
		)
	)

	; Deliveries a specific supply to a specific work station
	(:action deliver_supply
		:parameters (?r - robotic_agent ?b - box ?s - supply ?ws - work_station ?l - location ?c - carrier)
		:precondition (and
			(at ?ws ?l)
			(at ?r ?l)
			(at ?c ?l)
			(contained ?b ?c)
			(filled ?b ?s)
			(free ?r)
		)

		:effect (and
			(delivered ?s ?ws)
			(empty ?b)
			(not (filled ?b ?s))
			(at ?s ?l)
			(not (locked ?s))

			(increase (delivered_supply ?r) 1)
		)
	)
)
