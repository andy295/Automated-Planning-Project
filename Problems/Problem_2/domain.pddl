(define (domain industrial_manufacturing)
	(:requirements
		:adl
		:negative-preconditions
	)

	(:types
		location
		
		container robotic_agent supply work_station - object 
		box carrier - container

		small_carrier medium_carrier - carrier

		consumable durable - supply

		valve bolt - consumable
		tool - durable

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

		(assigned ?d - durable ?ws - work_station)
		(unassigned ?d - durable)

		(full ?b - box ?s - supply)
		(empty ?b - box)

		(occupied ?c - carrier ?b - box)
		(free ?c - carrier)

		(locked ?o - (either container durable))
		(unlocked ?o - (either container durable))

		; todo AC boxes on carriers

		(is_durable ?d - durable)

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

	; Associate a carrier to a robot
	(:action associate_carrier
		:parameters (?r - robotic_agent ?c - carrier ?l - location)
		:precondition (and
			(at ?r ?l)
			(at ?c ?l)
			(unlocked ?c)
			(dissociated ?r)
		)

		:effect (and
			(associated ?r ?c)
			(not (dissociated ?r))
			(locked ?c)
			(not (unlocked ?c))
			(not (at ?c ?l))
		)
	)

	; Dissociate a carrier from a robot
	(:action dissociate_carrier
		:parameters (?r - robotic_agent ?c - carrier ?l - location)
		:precondition (and
			(at ?r ?l)
			(associated ?r ?c)
			(locked ?c)
		)

		:effect (and
			(dissociated ?r)
			(not (associated ?r ?c))
			(unlocked ?c)
			(not (locked ?c))
			(at ?c ?l)
		)
	)

	; Robot picks up a specific unloaded box and places it into the carrier
	(:action occupy_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:precondition (and
			(at ?r ?l)
			(associated ?r ?c)
			(locked ?c)
			(free ?c)
			(at ?b ?l)
			(unlocked ?b)
		)

		:effect (and
			(occupied ?c ?b)
			(not (free ?c))
			(locked ?b)
			(not (unlocked ?b))
			(not (at ?b ?l))
		)
	)

	; Robot puts down the loaded box
	(:action free_carrier
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?l - location)
		:precondition (and
			(at ?r ?l)
			(associated ?r ?c)
			(locked ?c)
			(occupied ?c ?b)
			(locked ?b)
		)
	
		:effect (and
			(free ?c)
			(not (occupied ?c ?b))
			(unlocked ?b)
			(not (locked ?b))
			(at ?b ?l)
		)
	)

	; Fill a box with a specific supply
	(:action fill_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply)
		:precondition (and
			(at ?r warehouse)
			(associated ?r ?c)
			(locked ?c)
			(occupied ?c ?b)
			(locked ?b)
			(at ?s warehouse)
			(empty ?b)
		)

		:effect (and
			(full ?b ?s)
			(not (empty ?b))
			(not (at ?s warehouse))
		)
	)

	; Empty a box containing a specific supply
	(:action empty_box
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?l - location)
		:precondition (and
			(at ?r ?l)
			(associated ?r ?c)
			(locked ?c)
			(occupied ?c ?b)
			(locked ?b)
			(full ?b ?s)
		)	

		:effect (and
			(empty ?b)
			(not (full ?b ?s))
			(at ?s ?l)
		)
	)

	; Delivery a specific supply to a specific work station
	(:action deliver_supply
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?s - supply ?ws - work_station ?l - location)
		:precondition (and
			(not (delivered ?ws ?s))
			(at ?ws ?l)
			(at ?r ?l)
			(associated ?r ?c)
			(locked ?c)
			(occupied ?c ?b)
			(locked ?b)
			(full ?b ?s)
			(or
				(and (is_durable ?s) (unassigned ?s))
				(not (is_durable ?s))
			)
		)

		:effect (and
			(delivered ?s ?ws)
			(empty ?b)
			(not (full ?b ?s))
			(at ?s ?l)
			(when
				(is_durable ?s)
				
				(and 
					(assigned ?s ?ws)
					(not (unassigned ?s))
				)
			)
		)
	)

	; Some specific supplies are durable (or not consumable)
	; this means that their usage must be shared among the different work stations
	; beacuse of that we need to dissociate them from the work station that uses them
	; meaning that the robot can recover the supply from the work station and
	; bring it back to the warehouse or to another work station
	(:action release_supply
		:parameters (?r - robotic_agent ?c - carrier ?b - box ?d - durable ?ws - work_station ?l - location)
		:precondition (and
			(at ?ws ?l)
			(at ?r ?l)
			(at ?d ?l)
			(associated ?r ?c)
			(locked ?c)
			(occupied ?c ?b)
			(locked ?b)
			(empty ?b)
			(assigned ?d ?ws)
		)

		:effect (and
			(full ?b ?d)
			(not (empty ?b))
			(not (assigned ?d ?ws))
			(unassigned ?d)
		)
	)
)
