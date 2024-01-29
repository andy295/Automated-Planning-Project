# Problem 2

## Commands
1. Planner: LAMA
	- ``lama domain.pddl problem.pddl``

2. Planner: Metric-FF
    - ``metric-ff domain.pddl problem_<version>.pddl -<option> <value>``\

	#### Options description
	- ``-p <str>``&nbsp;&nbsp;&nbsp;&nbsp;Path for operator and fact file.
    - ``-o <str>``&nbsp;&nbsp;&nbsp;&nbsp;Operator file name
    - ``-f <str>``&nbsp;&nbsp;&nbsp;&nbsp;Fact file name
    - ``-r <int>``&nbsp;&nbsp;&nbsp;&nbsp;Random seed [used for random restarts; preset: 0]
    - ``-s <int>``&nbsp;&nbsp;&nbsp;&nbsp;Search configuration (default 5) *+H* (helpful actions pruning)
        - 0&nbsp;&nbsp;&nbsp;&nbsp;*Standard-FF*: *EHC+H* then *BFS* (cost minimization: NO)
        - 1&nbsp;&nbsp;&nbsp;&nbsp;*BFS* (cost minimization: NO)
        - 2&nbsp;&nbsp;&nbsp;&nbsp;*BFS+H* (cost minimization: NO)
        - 3&nbsp;&nbsp;&nbsp;&nbsp;*Weighted A\** (cost minimization: YES)
        - 4&nbsp;&nbsp;&nbsp;&nbsp;*A*epsilon* (cost minimization: YES)
        - 5&nbsp;&nbsp;&nbsp;&nbsp;*EHC+H* then *A\*epsilon* (cost minimization: YES)
    - ``-w <num>``&nbsp;&nbsp;&nbsp;&nbsp;Set weight w for search configs 3, 4, 5 (default 5)
    - ``-C``&nbsp;&nbsp;&nbsp;&nbsp;Do NOT use cost-minimizing relaxed plans for options 3, 4, 5
    - ``-b <float>``&nbsp;&nbsp;&nbsp;&nbsp;Fixed upper bound on solution cost (prune based on *g+hmax*); active only with cost minimization

## Solutions

### Classical

#### LAMA - Drone

```bash
1. (attach_carrier drone1 carrier2 warehouse)
2. (load_carrier drone1 carrier2 box1 n0 n1 warehouse)
3. (fill_box drone1 carrier2 box1 valve2)
4. (move_robot drone1 carrier2 warehouse location2)
5. (move_robot drone1 carrier2 location2 location1)
6. (deliver_supply drone1 carrier2 box1 valve2 work_station1 location1)
7. (move_robot drone1 carrier2 location1 location2)
8. (move_robot drone1 carrier2 location2 warehouse)
9. (fill_box drone1 carrier2 box1 bolt2)
10. (load_carrier drone1 carrier2 box2 n1 n2 warehouse)
11. (fill_box drone1 carrier2 box2 bolt1)
12. (move_robot drone1 carrier2 warehouse location2)
13. (move_robot drone1 carrier2 location2 location3)
14. (deliver_supply drone1 carrier2 box2 bolt1 work_station2 location3)
15. (deliver_supply drone1 carrier2 box1 bolt2 work_station3 location3)

Plan cost: 15
```

#### LAMA - AMR

```bash
1. (attach_carrier amr1 carrier1 warehouse)
2. (load_carrier amr1 carrier1 box1 n0 n1 warehouse)
3. (load_carrier amr1 carrier1 box2 n1 n2 warehouse)
4. (load_carrier amr1 carrier1 box3 n2 n3 warehouse)
5. (fill_box amr1 carrier1 box1 bolt2)
6. (fill_box amr1 carrier1 box2 bolt1)
7. (fill_box amr1 carrier1 box3 valve2)
8. (move_robot amr1 carrier1 warehouse location2)
9. (move_robot amr1 carrier1 location2 location1)
10. (deliver_supply amr1 carrier1 box3 valve2 work_station1 location1)
11. (move_robot amr1 carrier1 location1 location2)
12. (move_robot amr1 carrier1 location2 location3)
13. (deliver_supply amr1 carrier1 box2 bolt1 work_station2 location3)
14. (deliver_supply amr1 carrier1 box1 bolt2 work_station3 location3)

Plan cost: 14
```

### Fluent

#### Metric-FF

#### Domain - Problem 1

Command: ``metric-ff domain.pddl problem_1.pddl -s 3``
```bash
0: ATTACH_CARRIER CARRIER1 AMR1 WAREHOUSE
1: LOAD_CARRIER AMR1 CARRIER1 BOX1 WAREHOUSE
2: LOAD_CARRIER AMR1 CARRIER1 BOX2 WAREHOUSE
3: FILL_BOX AMR1 CARRIER1 BOX2 VALVE2
4: FILL_BOX AMR1 CARRIER1 BOX1 BOLT2
5: LOAD_CARRIER AMR1 CARRIER1 BOX3 WAREHOUSE
6: FILL_BOX AMR1 CARRIER1 BOX3 BOLT1
7: MOVE_ROBOT AMR1 CARRIER1 WAREHOUSE LOCATION2
8: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION1
9: DELIVER_SUPPLY AMR1 CARRIER1 BOX2 VALVE2 WORK_STATION1 LOCATION1
10: MOVE_ROBOT AMR1 CARRIER1 LOCATION1 LOCATION2
11: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION3
12: DELIVER_SUPPLY AMR1 CARRIER1 BOX1 BOLT2 WORK_STATION2 LOCATION3
13: DELIVER_SUPPLY AMR1 CARRIER1 BOX3 BOLT1 WORK_STATION3 LOCATION3
14: REACH-GOAL

Plan cost: 9.5
```
\
Command: ``metric-ff domain.pddl problem_1.pddl -s 4 -w 3``
```bash
0: ATTACH_CARRIER CARRIER1 AMR1 WAREHOUSE
1: LOAD_CARRIER AMR1 CARRIER1 BOX1 WAREHOUSE
2: FILL_BOX AMR1 CARRIER1 BOX1 VALVE2
3: LOAD_CARRIER AMR1 CARRIER1 BOX2 WAREHOUSE
4: FILL_BOX AMR1 CARRIER1 BOX2 BOLT2
5: MOVE_ROBOT AMR1 CARRIER1 WAREHOUSE LOCATION2
6: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION1
7: DELIVER_SUPPLY AMR1 CARRIER1 BOX1 VALVE2 WORK_STATION1 LOCATION1
8: EMPTY_CARRIER AMR1 CARRIER1 BOX1 LOCATION1
9: MOVE_ROBOT AMR1 CARRIER1 LOCATION1 LOCATION2
10: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION3
11: DELIVER_SUPPLY AMR1 CARRIER1 BOX2 BOLT2 WORK_STATION2 LOCATION3
12: MOVE_ROBOT AMR1 CARRIER1 LOCATION3 LOCATION2
13: EMPTY_CARRIER AMR1 CARRIER1 BOX2 LOCATION2
14: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 WAREHOUSE
15: LOAD_CARRIER AMR1 CARRIER1 BOX3 WAREHOUSE
16: FILL_BOX AMR1 CARRIER1 BOX3 BOLT1
17: MOVE_ROBOT AMR1 CARRIER1 WAREHOUSE LOCATION2
18: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION3
19: DELIVER_SUPPLY AMR1 CARRIER1 BOX3 BOLT1 WORK_STATION3 LOCATION3
20: REACH-GOAL

Plan cost: 19.5
```
\
Command: ``metric-ff domain.pddl problem_1.pddl -s 5``
```bash
0: ATTACH_CARRIER CARRIER1 AMR1 WAREHOUSE
1: LOAD_CARRIER AMR1 CARRIER1 BOX1 WAREHOUSE
2: FILL_BOX AMR1 CARRIER1 BOX1 VALVE2
3: MOVE_ROBOT AMR1 CARRIER1 WAREHOUSE LOCATION2
4: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION1
5: DELIVER_SUPPLY AMR1 CARRIER1 BOX1 VALVE2 WORK_STATION1 LOCATION1
6: MOVE_ROBOT AMR1 CARRIER1 LOCATION1 LOCATION2
7: EMPTY_CARRIER AMR1 CARRIER1 BOX1 LOCATION2
8: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 WAREHOUSE
9: LOAD_CARRIER AMR1 CARRIER1 BOX2 WAREHOUSE
10: FILL_BOX AMR1 CARRIER1 BOX2 BOLT2
11: MOVE_ROBOT AMR1 CARRIER1 WAREHOUSE LOCATION2
12: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION3
13: DELIVER_SUPPLY AMR1 CARRIER1 BOX2 BOLT2 WORK_STATION3 LOCATION3
14: MOVE_ROBOT AMR1 CARRIER1 LOCATION3 LOCATION2
15: EMPTY_CARRIER AMR1 CARRIER1 BOX2 LOCATION2
16: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 WAREHOUSE
17: LOAD_CARRIER AMR1 CARRIER1 BOX3 WAREHOUSE
18: FILL_BOX AMR1 CARRIER1 BOX3 BOLT1
19: MOVE_ROBOT AMR1 CARRIER1 WAREHOUSE LOCATION2
20: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION3
21: DELIVER_SUPPLY AMR1 CARRIER1 BOX3 BOLT1 WORK_STATION2 LOCATION3
22: REACH-GOAL

Plan cost: 21.5
```

#### Domain - Problem 2

Command: ``metric-ff domain.pddl problem_2.pddl -s 3``
```bash
0: ATTACH_CARRIER CARRIER1 AMR1 WAREHOUSE
1: LOAD_CARRIER AMR1 CARRIER1 BOX1 WAREHOUSE
2: LOAD_CARRIER AMR1 CARRIER1 BOX2 WAREHOUSE
3: FILL_BOX AMR1 CARRIER1 BOX2 TOOL2
4: LOAD_CARRIER AMR1 CARRIER1 BOX3 WAREHOUSE
5: FILL_BOX AMR1 CARRIER1 BOX3 VALVE2
6: FILL_BOX AMR1 CARRIER1 BOX1 BOLT2
7: MOVE_ROBOT AMR1 CARRIER1 WAREHOUSE LOCATION2
8: ATTACH_CARRIER CARRIER2 DRONE1 WAREHOUSE
9: LOAD_CARRIER DRONE1 CARRIER2 BOX4 WAREHOUSE
10: MOVE_ROBOT AMR1 CARRIER1 LOCATION2 LOCATION3
11: DELIVER_SUPPLY AMR1 CARRIER1 BOX1 BOLT2 WORK_STATION2 LOCATION3
12: FILL_BOX DRONE1 CARRIER2 BOX4 VALVE1
13: LOAD_CARRIER DRONE1 CARRIER2 BOX5 WAREHOUSE
14: FILL_BOX DRONE1 CARRIER2 BOX5 TOOL1
15: MOVE_ROBOT DRONE1 CARRIER2 WAREHOUSE LOCATION2
16: MOVE_ROBOT DRONE1 CARRIER2 LOCATION2 LOCATION1
17: DELIVER_SUPPLY DRONE1 CARRIER2 BOX4 VALVE1 WORK_STATION1 LOCATION1
18: DELIVER_SUPPLY DRONE1 CARRIER2 BOX5 TOOL1 WORK_STATION1 LOCATION1
19: DELIVER_SUPPLY AMR1 CARRIER1 BOX2 TOOL2 WORK_STATION3 LOCATION3
20: REACH-GOAL

Plan cost: 13.5
```

### Comments
- Classical solution can also be achieved using the LAMA-First planner by executing the following command:
``lama-first domain.pddl problem.pddl``

    The solution obtained differs from that achieved with LAMA. LAMA-First operates greedily, generally prioritizing speed over optimization in its solutions.
