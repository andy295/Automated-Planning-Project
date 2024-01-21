# Problem 4

## Commands
1. Planner: OPTIC
	- ``optic domain.pddl problem_<version>.pddl -b``

## Solution

### OPTIC

#### Domain - Problem 1

```bash
Plan found with metric: 32.016
Theoretical reachable cost: 32.017
States evaluated so far: 327264
States pruned based on pre-heuristic cost lower bound: 0

1. 0.000: (attach_carrier carrier1 amr1 warehouse)  [4.000]
2. 4.001: (load_carrier amr1 carrier1 box1 warehouse)  [2.000]
3. 6.002: (fill_box amr1 carrier1 box1 valve1)  [1.000]
4. 7.003: (load_carrier amr1 carrier1 box2 warehouse)  [2.000]
5. 9.004: (fill_box amr1 carrier1 box2 tool1)  [1.000]
6. 10.005: (move_robot amr1 carrier1 warehouse location2)  [2.000]
7. 12.006: (move_robot amr1 carrier1 location2 location1)  [2.000]
8. 14.007: (deliver_supply amr1 carrier1 box2 tool1 work_station1 location1)  [2.000]
9. 16.008: (deliver_supply amr1 carrier1 box1 valve1 work_station1 location1)  [2.000]
10. 18.009: (move_robot amr1 carrier1 location1 location2)  [2.000]
11. 20.010: (move_robot amr1 carrier1 location2 warehouse)  [2.000]
12. 22.011: (fill_box amr1 carrier1 box1 tool2)  [1.000]
13. 23.012: (fill_box amr1 carrier1 box2 bolt1)  [1.000]
14. 24.013: (move_robot amr1 carrier1 warehouse location2)  [2.000]
15. 26.014: (move_robot amr1 carrier1 location2 location3)  [2.000]
16. 28.015: (deliver_supply amr1 carrier1 box1 tool2 work_station3 location3)  [2.000]
17. 30.016: (deliver_supply amr1 carrier1 box2 bolt1 work_station3 location3)  [2.000]

Time: 366.94 seconds
```

#### Domain - Problem 2

```bash
Plan found with metric: 26.012
Theoretical reachable cost: 26.013
States evaluated so far: 35678
States pruned based on pre-heuristic cost lower bound: 0

1. 0.000: (attach_carrier carrier1 amr1 warehouse)  [4.000]
2. 0.000: (attach_carrier carrier2 drone1 warehouse)  [4.000]
3. 4.001: (move_robot amr1 carrier1 warehouse location2)  [2.000]
4. 4.001: (load_carrier drone1 carrier2 box1 warehouse)  [2.000]
5. 6.002: (fill_box drone1 carrier2 box1 valve1)  [1.000]
6. 6.002: (move_robot amr1 carrier1 location2 location1)  [2.000]
7. 7.003: (load_carrier drone1 carrier2 box2 warehouse)  [2.000]
8. 8.003: (move_robot amr1 carrier1 location1 location2)  [2.000]
9. 9.004: (move_robot drone1 carrier2 warehouse location2)  [2.000]
10. 10.004: (move_robot amr1 carrier1 location2 warehouse)  [2.000]
11. 11.005: (move_robot drone1 carrier2 location2 location1)  [2.000]
12. 12.005: (load_carrier amr1 carrier1 box3 warehouse)  [2.000]
13. 13.006: (deliver_supply drone1 carrier2 box1 valve1 work_station1 location1)  [2.000]
14. 14.006: (fill_box amr1 carrier1 box3 tool2)  [1.000]
15. 15.007: (move_robot drone1 carrier2 location1 location2)  [2.000]
16. 15.007: (load_carrier amr1 carrier1 box4 warehouse)  [2.000]
17. 17.008: (move_robot drone1 carrier2 location2 warehouse)  [2.000]
18. 17.008: (fill_box amr1 carrier1 box4 bolt1)  [1.000]
19. 18.009: (move_robot amr1 carrier1 warehouse location2)  [2.000]
20. 19.009: (fill_box drone1 carrier2 box1 tool1)  [1.000]
21. 20.010: (move_robot drone1 carrier2 warehouse location2)  [2.000]
22. 20.010: (move_robot amr1 carrier1 location2 location3)  [2.000]
23. 22.011: (deliver_supply amr1 carrier1 box3 tool2 work_station3 location3)  [2.000]
24. 22.011: (move_robot drone1 carrier2 location2 location1)  [2.000]
25. 24.012: (deliver_supply amr1 carrier1 box4 bolt1 work_station3 location3)  [2.000]
26. 24.012: (deliver_supply drone1 carrier2 box1 tool1 work_station1 location1)  [2.000]

Time: 103.84 seconds
```
