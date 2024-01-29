# Problem 3

## Commands
1. Planner: PANDA-First
	- ``java -jar PANDA.jar -parser hddl domain.pddl problem_<version>.pddl``

## Solution

### PANDA

### Solution Sequence

```bash
0: attach_carrier__DISJUNCT-0(amr1,carrier1,warehouse)
1: load_carrier__ANTECEDENT__DISJUNCT-1__DISJUNCT-1(amr1,carrier1,box4,n0,n1,warehouse)
2: load_carrier__ANTECEDENT__DISJUNCT-1__DISJUNCT-0(amr1,carrier1,box2,n1,n2,warehouse)
3: fill_box(amr1,carrier1,box2,bolt1,warehouse)
4: fill_box(amr1,carrier1,box4,valve1,warehouse)
5: load_carrier__CONSEQUENT____DISJUNCT-0(amr1,carrier1,box3,n2,n3,warehouse)
6: fill_box(amr1,carrier1,box3,tool1,warehouse)
7: no_op(amr1,carrier1,warehouse)
8: move_robot__DISJUNCT-0(amr1,carrier1,warehouse,location2)
9: move_robot__DISJUNCT-0(amr1,carrier1,location2,location1)
10: deliver_supply(amr1,carrier1,box4,valve1,work_station1,location1)
11: move_robot__DISJUNCT-0(amr1,carrier1,location1,location2)
12: move_robot__DISJUNCT-0(amr1,carrier1,location2,location3)
13: deliver_supply(amr1,carrier1,box2,bolt1,work_station3,location3)
14: deliver_supply(amr1,carrier1,box3,tool1,work_station3,location3)
```

### Methods

```bash
__top_6 @ __artificialTopCompilation__top_6
__top_0___top_0_4[varForwork_station3=work_station3,?b=bolt1] @ t_deliver_supply___top_0_4[work_station3]
__top_0___top_0_2[?v=valve1,varForwork_station1=work_station1] @ t_deliver_supply___top_0_2[work_station1]
m_attach_load[?r=amr1,?ws=work_station1,?s=valve1,?b=box4] @ t_deliver_supply[valve1,work_station1]
__top_0___top_0_3[varForwork_station3=work_station3,?t=tool1] @ t_deliver_supply___top_0_3[work_station3]
m_attach_load_m_attach_load_2[?r=amr1,?c=carrier1] @ t_attach_m_attach_load_2[amr1]
attach_carrier__DISJUNCT-0[amr1,carrier1,warehouse]
m_load[?next_q=n1,?c=carrier1,?l=warehouse,?r=amr1,?b=box4,?actual_q=n0] @ t_load[amr1,box4]
m_load_fill[?ws=work_station3,?s=bolt1,?r=amr1,?b=box2] @ t_deliver_supply[bolt1,work_station3]
m_load[?next_q=n2,?c=carrier1,?l=warehouse,?r=amr1,?b=box2,?actual_q=n1] @ t_load[amr1,box2]
M-load_carrier__ANTECEDENT__DISJUNCT-1__DISJUNCT-1[?l=warehouse,?next_q=n1,?b=box4,?r=amr1,?actual_q=n0,?c=carrier1] @ load_carrier__ANTECEDENT__DISJUNCT-1[amr1,carrier1,box4,n0,n1,warehouse]
load_carrier__ANTECEDENT__DISJUNCT-1__DISJUNCT-1[amr1,carrier1,box4,n0,n1,warehouse]
load_carrier__ANTECEDENT__DISJUNCT-1__DISJUNCT-0[amr1,carrier1,box2,n1,n2,warehouse]
m_fill_m_fill_2[?l=warehouse,?s=bolt1,?b=box2,?c=carrier1,?r=amr1] @ fill_box_m_fill_2[amr1,box2,bolt1]
fill_box[amr1,carrier1,box2,bolt1,warehouse]
m_deliver_supply[?c=carrier1,?l1=location3,?b=box4,?ws=work_station3,?s=bolt1] @ t_deliver_supply[bolt1,work_station3]
m_fill_m_fill_2[?l=warehouse,?s=valve1,?b=box4,?c=carrier1,?r=amr1] @ fill_box_m_fill_2[amr1,box4,valve1]
m_load_fill[?ws=work_station3,?s=tool1,?r=amr1,?b=box3] @ t_deliver_supply[tool1,work_station3]
m_load[?next_q=n3,?c=carrier1,?l=warehouse,?r=amr1,?b=box3,?actual_q=n2] @ t_load[amr1,box3]
fill_box[amr1,carrier1,box4,valve1,warehouse]
load_carrier__CONSEQUENT____DISJUNCT-0[amr1,carrier1,box3,n2,n3,warehouse]
m_deliver_supply[?c=carrier2,?l1=location1,?b=box2,?ws=work_station1,?s=valve1] @ t_deliver_supply[valve1,work_station1]
m_deliver_supply_m_deliver_supply_2[?r=amr1,?l2=warehouse] @ t_move_m_deliver_supply_2[]
m_fill_m_fill_2[?l=warehouse,?s=tool1,?b=box3,?c=carrier1,?r=amr1] @ fill_box_m_fill_2[amr1,box3,tool1]
m_already_there[?r=amr1,?l=warehouse,?c=carrier1] @ t_move[amr1,warehouse]
fill_box[amr1,carrier1,box3,tool1,warehouse]
no_op[amr1,carrier1,warehouse]
m_deliver_m_deliver_2[?l2=location1,?ws=work_station1,?r=amr1,?c=carrier1,?s=valve1,?b=box4] @ deliver_supply_m_deliver_2[valve1,work_station1]
m_deliver_supply_m_deliver_supply_2[?r=amr1,?l2=location1] @ t_move_m_deliver_supply_2[]
m_move_through[?l2=location2,?r=amr1,?c=carrier1,?l=location1] @ t_move[amr1,location1]
m_move[?r=amr1,?c=carrier1,?l1=warehouse,?l=location2] @ t_move[amr1,location2]
move_robot__DISJUNCT-0[amr1,carrier1,warehouse,location2]
m_deliver_supply[?c=carrier1,?l1=location3,?b=box2,?ws=work_station3,?s=tool1] @ t_deliver_supply[tool1,work_station3]
m_deliver_supply_m_deliver_supply_2[?r=amr1,?l2=location3] @ t_move_m_deliver_supply_2[]
move_robot__DISJUNCT-0[amr1,carrier1,location2,location1]
deliver_supply[amr1,carrier1,box4,valve1,work_station1,location1]
m_move_through[?l2=location2,?r=amr1,?c=carrier1,?l=location3] @ t_move[amr1,location3]
m_move[?r=amr1,?c=carrier1,?l1=location1,?l=location2] @ t_move[amr1,location2]
m_deliver_m_deliver_2[?l2=location3,?ws=work_station3,?r=amr1,?c=carrier1,?s=bolt1,?b=box2] @ deliver_supply_m_deliver_2[bolt1,work_station3]
move_robot__DISJUNCT-0[amr1,carrier1,location1,location2]
move_robot__DISJUNCT-0[amr1,carrier1,location2,location3]
m_deliver_m_deliver_2[?l2=location3,?ws=work_station3,?r=amr1,?c=carrier1,?s=tool1,?b=box3] @ deliver_supply_m_deliver_2[tool1,work_station3]
deliver_supply[amr1,carrier1,box2,bolt1,work_station3,location3]
deliver_supply[amr1,carrier1,box3,tool1,work_station3,location3]
```

### Comments
The planner can be found in the problem folder or downloaded from [PANDA](https://www.uni-ulm.de/fileadmin/website_uni_ulm/iui.inst.090/panda/PANDA.jar) (*direct download*).
