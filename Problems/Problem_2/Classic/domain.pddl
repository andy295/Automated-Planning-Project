(define (domain industrial_manufacturing)
	(:requirements
		:adl
		:negative-preconditions
		:conditional-effects
		:existential-preconditions
		:universal-preconditions
		:derived-predicates
	)
	(:types
		location quantity placeable - object
		work_station resizable supply - placeable
		valve bolt tool - supply
		robotic_agent container - resizable
		box carrier - container
		amr drone - robotic_agent
	)

	(:constants
		warehouse - location
	)

	(:predicates
		(adjacent ?l1 - location ?l2 - location)
		(at ?p - placeable ?l - location)

		(attached ?r - robotic_agent ?c - carrier)
		(detached ?r - robotic_agent)

		(loaded ?c - carrier ?b - box)
		(has_space ?c - carrier)

		(filled ?b - box ?s - supply)

		(empty ?c - container)
		(locked ?o - (either container supply))

		(is_small ?r - resizable)
		(is_big ?r - resizable)

		(compatible ?r - robotic_agent ?c - carrier)

		(is_full ?c - carrier ?q - quantity)
		(big_max_quantity ?q - quantity)
		(small_max_quantity ?q - quantity)
		(all_min_quantity ?q - quantity)

		(contained ?c - carrier ?q - quantity)
		(increased_by_1 ?q1 - quantity ?q2 - quantity)
		(decreased_by_1 ?q1 - quantity ?q2 - quantity)

		(delivered ?s - supply ?ws - work_station)
	)

	(:derived (compatible ?r - robotic_agent ?c - carrier)
		(or
			(and
				; we assume big robot can hold big and small carriers
				; more conditions can be added here to change the assumption
				(is_big ?r)
			)
			(and
				(is_small ?r)
				(is_small ?c)
			)
		)
	)

	(:derived (is_full ?c - carrier ?q - quantity)
		(or
			(and
				(is_big ?c)
				(big_max_quantity ?q)
			)
			(and
				(is_small ?c)
				(small_max_quantity ?q)
			)
		)
	)

	; Moves a robot between two locations, if it is not already there
	(:action move_robot
		:parameters (?r - robotic_agent ?c - carrier ?from ?to - location)
		:precondition (and
			(not (= ?from ?to))
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
					(empty ?c)
				)
			)
		)

		:effect (and
			(at ?r ?to)
			(not (at ?r ?from))
		)
	)

	; Attaches a carrier to a robot
	(:action attach_carrier
		:parameters (?r - robotic_agent ?c - carrier ?l - location)
		:precondition (and
			(at ?r ?l)
			(at ?c ?l)
			(detached ?r)
			(not (locked ?c))
			(compatible ?r ?c)
		)

		:effect (and
			(attached ?r ?c)
			(not (detached ?r))
			(locked ?c)
			(not (at ?c ?l))
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
		)
	)

	; Picks up a specific unloaded box and places it into the carrier
	(:action load_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?actual_q ?next_q - quantity ?l - location)
		:precondition (and
			(at ?r ?l)
			(at ?b ?l)
			(attached ?r ?c)
			(has_space ?c)
			(not (locked ?b))
			(contained ?c ?actual_q)
			(increased_by_1 ?actual_q ?next_q)
		)

		:effect (and
			(loaded ?c ?b)
			(locked ?b)
			(not (at ?b ?l))
			(contained ?c ?next_q)
			(not (contained ?c ?actual_q))

			; if the carrier is full, it is not possible to load another box
			(when
				(and 
					(is_full ?c ?next_q)
				)
				(and
					(not (empty ?c))
					(not (has_space ?c))
				)
			)
		)
	)

	; Puts down the loaded box
	(:action empty_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?actual_q ?next_q - quantity ?l - location)
		:precondition (and
			(at ?r ?l)
			(attached ?r ?c)
			(loaded ?c ?b)
			(contained ?c ?actual_q)
			(decreased_by_1 ?actual_q ?next_q)
		)

		:effect (and
			(not (loaded ?c ?b))
			(not (locked ?b))
			(at ?b ?l)
			(contained ?c ?next_q)
			(not (contained ?c ?actual_q))

			; if the carrier does not contain any box, it is empty
			(when
				(and
					(all_min_quantity ?next_q)
				)

				(and
					(empty ?c)
				)
			)

			; if the carrier is not full, it is possible to load another box
			(when
				(and
					(not (all_min_quantity ?next_q))
					(not (is_full ?c ?next_q))
				)

				(and
					(has_space ?c)
				)
			)
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
		)
	)

	; Deliveries a specific supply to a specific work station
	(:action deliver_supply
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?ws - work_station ?l - location)
		:precondition (and
			(not (delivered ?s ?ws))
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
		)
	)
)
