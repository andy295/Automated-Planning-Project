# Problem 3

## Commands
1. Planner: PANDA-First
	- ``java -jar PANDA.jar -parser hddl domain.pddl problem_<version>.pddl``

## Solution

### PANDA

### Solution Sequence

```bash
0: attach_carrier__DISJUNCT-0(drone1,carrier2,warehouse)
1: load_carrier__ANTECEDENT__DISJUNCT-1__DISJUNCT-1(drone1,carrier2,box4,n0,n1,warehouse)
2: load_carrier__CONSEQUENT____DISJUNCT-1(drone1,carrier2,box2,n1,n2,warehouse)
3: fill_box(drone1,carrier2,box2,valve1,warehouse)
4: fill_box(drone1,carrier2,box4,tool1,warehouse)
5: move_robot(drone1,carrier2,warehouse,location2)
6: move_robot(drone1,carrier2,location2,location1)
7: deliver_supply(drone1,carrier2,box2,valve1,work_station1,location1)
8: deliver_supply(drone1,carrier2,box4,tool1,work_station1,location1)
9: move_robot(drone1,carrier2,location1,location2)
10: move_robot(drone1,carrier2,location2,warehouse)
11: fill_box(drone1,carrier2,box4,bolt1,warehouse)
12: fill_box(drone1,carrier2,box2,tool2,warehouse)
13: move_robot(drone1,carrier2,warehouse,location2)
14: move_robot(drone1,carrier2,location2,location4)
15: deliver_supply(drone1,carrier2,box2,tool2,work_station4,location4)
16: deliver_supply(drone1,carrier2,box4,bolt1,work_station3,location4)
```

### Methods

```bash
m_attach_load[?s=tool1,?b=box4,?ws=work_station1,?r=drone1] @ t_deliver_supply[tool1,work_station1]
m_attach_load_m_attach_load_2[?r=drone1,?c=carrier2] @ t_attach_m_attach_load_2[drone1]
attach_carrier__DISJUNCT-0[drone1,carrier2,warehouse]
m_load_fill[?s=valve1,?ws=work_station1,?b=box2,?r=drone1] @ t_deliver_supply[valve1,work_station1]
m_load[?b=box4,?c=carrier2,?r=drone1,?l=warehouse,?next_q=n1,?actual_q=n0] @ t_load[drone1,box4]
m_load[?b=box2,?c=carrier2,?r=drone1,?l=warehouse,?next_q=n2,?actual_q=n1] @ t_load[drone1,box2]
M-load_carrier__ANTECEDENT__DISJUNCT-1[?actual_q=n0,?c=carrier2,?next_q=n1,?l=warehouse,?r=drone1,?b=box4] @ load_carrier__ANTECEDENT[drone1,carrier2,box4,n0,n1,warehouse]
load_carrier__ANTECEDENT__DISJUNCT-1__DISJUNCT-1[drone1,carrier2,box4,n0,n1,warehouse]
m_refill_box[?s=bolt1,?r=drone1,?ws=work_station3,?c=carrier1] @ t_deliver_supply[bolt1,work_station3]
m_refill_box_m_refill_box_2[?r=drone1,?l=location2] @ t_move_m_refill_box_2[drone1]
load_carrier__CONSEQUENT____DISJUNCT-1[drone1,carrier2,box2,n1,n2,warehouse]
m_fill_m_fill_2[?s=valve1,?b=box2,?c=carrier2,?l=warehouse,?r=drone1] @ fill_box_m_fill_2[drone1,box2,valve1]
fill_box[drone1,carrier2,box2,valve1,warehouse]
m_deliver_supply[?l1=location3,?b=box3,?c=carrier2,?s=valve1,?ws=work_station1] @ t_deliver_supply[valve1,work_station1]
m_fill_m_fill_2[?s=tool1,?b=box4,?c=carrier2,?l=warehouse,?r=drone1] @ fill_box_m_fill_2[drone1,box4,tool1]
fill_box[drone1,carrier2,box4,tool1,warehouse]
m_deliver_supply[?l1=warehouse,?b=box2,?c=carrier2,?s=tool1,?ws=work_station1] @ t_deliver_supply[tool1,work_station1]
m_deliver_supply_m_deliver_supply_2[?l2=location1,?r=drone1] @ t_move_m_deliver_supply_2[]
m_move[?l=location2,?c=carrier2,?r=drone1,?l1=location1] @ t_move[drone1,location2]
m_move[?l=location1,?c=carrier2,?r=drone1,?l1=location2] @ t_move[drone1,location1]
m_deliver_supply_m_deliver_supply_2[?l2=location2,?r=drone1] @ t_move_m_deliver_supply_2[]
m_move[?l=location2,?c=carrier2,?r=drone1,?l1=warehouse] @ t_move[drone1,location2]
move_robot[drone1,carrier2,warehouse,location2]
m_deliver_m_deliver_2[?c=carrier2,?ws=work_station1,?l2=location1,?r=drone1,?s=valve1,?b=box2] @ deliver_supply_m_deliver_2[valve1,work_station1]
move_robot[drone1,carrier2,location2,location1]
m_deliver_m_deliver_2[?c=carrier2,?ws=work_station1,?l2=location1,?r=drone1,?s=tool1,?b=box4] @ deliver_supply_m_deliver_2[tool1,work_station1]
deliver_supply[drone1,carrier2,box2,valve1,work_station1,location1]
deliver_supply[drone1,carrier2,box4,tool1,work_station1,location1]
move_robot[drone1,carrier2,location1,location2]
m_refill_box_m_refill_box_3[?s=bolt1,?b=box4,?r=drone1] @ t_fill_m_refill_box_3[drone1,bolt1]
m_refill_box[?s=tool2,?ws=work_station4,?r=drone1,?c=carrier1] @ t_deliver_supply[tool2,work_station4]
m_refill_box_m_refill_box_2[?r=drone1,?l=warehouse] @ t_move_m_refill_box_2[drone1]
m_fill_m_fill_2[?s=bolt1,?b=box4,?c=carrier2,?l=warehouse,?r=drone1] @ fill_box_m_fill_2[drone1,box4,bolt1]
m_move[?l=warehouse,?c=carrier2,?r=drone1,?l1=location2] @ t_move[drone1,warehouse]
move_robot[drone1,carrier2,location2,warehouse]
m_refill_box_m_refill_box_3[?s=tool2,?b=box2,?r=drone1] @ t_fill_m_refill_box_3[drone1,tool2]
fill_box[drone1,carrier2,box4,bolt1,warehouse]
m_fill_m_fill_2[?s=tool2,?b=box2,?c=carrier2,?l=warehouse,?r=drone1] @ fill_box_m_fill_2[drone1,box2,tool2]
fill_box[drone1,carrier2,box2,tool2,warehouse]
m_deliver_supply[?l1=location2,?b=box2,?c=carrier2,?s=bolt1,?ws=work_station3] @ t_deliver_supply[bolt1,work_station3]
m_deliver_supply[?l1=location2,?b=box3,?c=carrier1,?s=tool2,?ws=work_station4] @ t_deliver_supply[tool2,work_station4]
m_deliver_supply_m_deliver_supply_2[?l2=location2,?r=drone1] @ t_move_m_deliver_supply_2[]
m_deliver_supply_m_deliver_supply_2[?l2=location4,?r=drone1] @ t_move_m_deliver_supply_2[]
m_move[?l=location2,?c=carrier2,?r=drone1,?l1=warehouse] @ t_move[drone1,location2]
m_move[?l=location4,?c=carrier2,?r=drone1,?l1=location2] @ t_move[drone1,location4]
move_robot[drone1,carrier2,warehouse,location2]
move_robot[drone1,carrier2,location2,location4]
m_deliver_m_deliver_2[?c=carrier2,?ws=work_station4,?l2=location4,?r=drone1,?s=tool2,?b=box2] @ deliver_supply_m_deliver_2[tool2,work_station4]
deliver_supply[drone1,carrier2,box2,tool2,work_station4,location4]
m_deliver_m_deliver_2[?c=carrier2,?ws=work_station3,?l2=location4,?r=drone1,?s=bolt1,?b=box4] @ deliver_supply_m_deliver_2[bolt1,work_station3]
deliver_supply[drone1,carrier2,box4,bolt1,work_station3,location4]
```

### Comments
The planner can be found in the problem folder or downloaded from [PANDA](https://www.uni-ulm.de/fileadmin/website_uni_ulm/iui.inst.090/panda/PANDA.jar) (*direct download*).
