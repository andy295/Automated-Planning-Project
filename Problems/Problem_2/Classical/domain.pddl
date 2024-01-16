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
		location work_station container supply robotic_agent quantity - object 
		
		box carrier - container

		valve bolt tool - supply

		amr drone - robotic_agent
	)

	(:constants
		warehouse - location
	)

	(:predicates
		(adjacent ?l1 - location ?l2 - location)
		(at ?o - (either container robotic_agent supply work_station) ?l - location)

		(associated ?r - robotic_agent ?c - carrier)
		(dissociated ?r - robotic_agent)

		(occupied ?c - carrier ?b - box)

		(filled ?b - box ?s - supply)

		(empty ?c - container)
		(locked ?o - (either container supply))

		(is_small ?o - (either robotic_agent carrier))
		(is_big ?o - (either robotic_agent carrier))

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
				(is_big ?r)
			(is_big ?c)	
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
			(associated ?r ?c)
		)

		:effect (and
			(at ?r ?to)
			(not (at ?r ?from))
		)
	)

	; Associate a carrier to a robot
	(:action associate_carrier
		:parameters (?r - robotic_agent ?c - carrier ?l - location)
		:precondition (and
			(at ?r ?l)
			(at ?c ?l)
			(dissociated ?r)
			(not (locked ?c))
			(compatible ?r ?c)
		)

		:effect (and
			(associated ?r ?c)
			(not (dissociated ?r))
			(locked ?c)
			(not (at ?c ?l))
		)
	)

	; Dissociate a carrier from a robot
	(:action dissociate_carrier
		:parameters (?r - robotic_agent ?c - carrier ?l - location)
		:precondition (and
			(at ?r ?l)
			(associated ?r ?c)
		)

		:effect (and
			(dissociated ?r)
			(not (associated ?r ?c))
			(not (locked ?c))
			(at ?c ?l)
		)
	)

	; Robot picks up a specific unloaded box and places it into the carrier
	(:action occupy_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?actual_q ?next_q - quantity ?l - location)
		:precondition (and
			(at ?r ?l)
			(at ?b ?l)
			(associated ?r ?c)
			(empty ?c)
			(not (locked ?b))
			(contained ?c ?actual_q)
			(increased_by_1 ?actual_q ?next_q)
		)

		:effect (and
			(occupied ?c ?b)
			(locked ?b)
			(not (at ?b ?l))
			(contained ?c ?next_q)
			(not (contained ?c ?actual_q))

			(when
				(and 
					(is_full ?c ?next_q)
				)
				(and
					(not (empty ?c))
				)
			)
		)
	)

	; Robot puts down the loaded box
	(:action empty_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?actual_q ?next_q - quantity ?l - location)
		:precondition (and
			(at ?r ?l)
			(associated ?r ?c)
			(occupied ?c ?b)
			(contained ?c ?actual_q)
			(decreased_by_1 ?actual_q ?next_q)
		)

		:effect (and
			(not (occupied ?c ?b))
			(not (locked ?b))
			(at ?b ?l)
			(contained ?c ?next_q)
			(not (contained ?c ?actual_q))

			(when
				(and 
					(all_min_quantity ?next_q)
				)

				(and
					(empty ?c)
				)
			)
		)
	)

	; Fill a box with a specific supply
	(:action fill_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply)
		:precondition (and
			(at ?r warehouse)
			(at ?s warehouse)
			(associated ?r ?c)
			(occupied ?c ?b)
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

	; Empty a box containing a specific supply
	(:action empty_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?l - location)
		:precondition (and
			(at ?r ?l)
			(associated ?r ?c)
			(occupied ?c ?b)
			(filled ?b ?s)
		)	

		:effect (and
			(empty ?b)
			(not (filled ?b ?s))
			(at ?s ?l)
			(not (locked ?s))
		)
	)

	; Delivery a specific supply to a specific work station
	(:action deliver_supply
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?ws - work_station ?l - location)
		:precondition (and
			(not (delivered ?s ?ws))
			(at ?ws ?l)
			(at ?r ?l)
			(associated ?r ?c)
			(occupied ?c ?b)
			(filled ?b ?s)
		)

		:effect (and
			(delivered ?s ?ws)
			(empty ?b)
			(not (filled ?b ?s))
			(at ?s ?l)
			(not (locked ?s))
		)
	)
)
