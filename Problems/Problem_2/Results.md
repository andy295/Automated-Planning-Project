# Problem 2

## Commands
1. Planner: LAMA
	- ``lama domain.pddl problem_<version>.pddl``

2. Planner: Metric-FF
    - ``metric-ff ./domain.pddl ./problem.pddl -<option> <value>``\

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
3. (load_carrier drone1 carrier2 box2 n1 n2 warehouse)
4. (fill_box drone1 carrier2 box1 valve1)
5. (move_robot drone1 carrier2 warehouse location2)
6. (move_robot drone1 carrier2 location2 location1)
7. (deliver_supply drone1 carrier2 box1 valve1 work_station1 location1)
8. (move_robot drone1 carrier2 location1 location2)
9. (move_robot drone1 carrier2 location2 warehouse)
10. (fill_box drone1 carrier2 box1 bolt2)
11. (fill_box drone1 carrier2 box2 bolt1)
12. (move_robot drone1 carrier2 warehouse location2)
13. (move_robot drone1 carrier2 location2 location4)
14. (deliver_supply drone1 carrier2 box2 bolt1 work_station3 location4)
15. (deliver_supply drone1 carrier2 box1 bolt2 work_station4 location4)
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
12. (move_robot amr1 carrier1 location2 location4)
13. (deliver_supply amr1 carrier1 box2 bolt1 work_station3 location4)
14. (deliver_supply amr1 carrier1 box1 bolt2 work_station4 location4)
```

### Fluent

#### Metric-FF

Command: ``metric-ff ./domain.pddl ./problem.pddl -s 3``
```bash
0. ATTACH_CARRIER CARRIER1 ROBOT1 WAREHOUSE
1. LOAD_CARRIER ROBOT1 CARRIER1 BOX1 WAREHOUSE
2. LOAD_CARRIER ROBOT1 CARRIER1 BOX2 WAREHOUSE
3. FILL_BOX ROBOT1 CARRIER1 BOX2 VALVE2
4. LOAD_CARRIER ROBOT1 CARRIER1 BOX3 WAREHOUSE
5. FILL_BOX ROBOT1 CARRIER1 BOX3 BOLT2
6. FILL_BOX ROBOT1 CARRIER1 BOX1 TOOL2
7. MOVE_ROBOT ROBOT1 CARRIER1 WAREHOUSE LOCATION2
8. MOVE_ROBOT ROBOT1 CARRIER1 LOCATION2 LOCATION1
9. DELIVER_SUPPLY ROBOT1 CARRIER1 BOX2 VALVE2 WORK_STATION1 LOCATION1
10. MOVE_ROBOT ROBOT1 CARRIER1 LOCATION1 LOCATION2
11. MOVE_ROBOT ROBOT1 CARRIER1 LOCATION2 WAREHOUSE
12. FILL_BOX ROBOT1 CARRIER1 BOX2 TOOL1
13. MOVE_ROBOT ROBOT1 CARRIER1 WAREHOUSE LOCATION2
14. MOVE_ROBOT ROBOT1 CARRIER1 LOCATION2 LOCATION4
15. DELIVER_SUPPLY ROBOT1 CARRIER1 BOX1 TOOL2 WORK_STATION4 LOCATION4
16. DELIVER_SUPPLY ROBOT1 CARRIER1 BOX3 BOLT2 WORK_STATION3 LOCATION4
17. MOVE_ROBOT ROBOT1 CARRIER1 LOCATION4 LOCATION2
18. MOVE_ROBOT ROBOT1 CARRIER1 LOCATION2 LOCATION1
19. DELIVER_SUPPLY ROBOT1 CARRIER1 BOX2 TOOL1 WORK_STATION1 LOCATION1
20. REACH-GOAL

Plan cost: 14
```

### Comments
- Classical solution can also be achieved using the LAMA-First planner by executing the following command:
``lama-first domain.pddl problem.pddl``

    The solution obtained differs from that achieved with LAMA. LAMA-First operates greedily, generally prioritizing speed over optimization in its solutions.

- Solutions with a different configuration and a previous version of the code can be found under **Fluent/Previous_version/Results.md**.
