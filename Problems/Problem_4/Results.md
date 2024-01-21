# Problem 4

## Commands
1. Planner: OPTIC
	- ``optic domain.pddl problem_<version>.pddl -b``

## Solution

### OPTIC

#### Domain - Problem 1

```bash
1 .0.000: (attach_carrier carrier1 amr1 warehouse)  [4.000]
2 .4.001: (load_carrier amr1 carrier1 box1 warehouse)  [2.000]
3 .6.002: (fill_box amr1 carrier1 box1 valve1)  [1.000]
4 .7.003: (load_carrier amr1 carrier1 box2 warehouse)  [2.000]
5 .9.004: (fill_box amr1 carrier1 box2 tool2)  [1.000]
6 .10.005: (load_carrier amr1 carrier1 box3 warehouse)  [2.000]
7 .12.006: (fill_box amr1 carrier1 box3 tool1)  [1.000]
8 .13.007: (move_robot amr1 carrier1 warehouse location2)  [2.000]
9 .15.008: (move_robot amr1 carrier1 location2 location1)  [2.000]
10 .17.009: (deliver_supply amr1 carrier1 box1 valve1 work_station1 location1)  [2.000]
11 .19.010: (deliver_supply amr1 carrier1 box3 tool1 work_station1 location1)  [2.000]
12 .21.011: (move_robot amr1 carrier1 location1 location2)  [2.000]
13 .23.012: (move_robot amr1 carrier1 location2 warehouse)  [2.000]
14 .25.013: (fill_box amr1 carrier1 box1 bolt1)  [1.000]
15 .26.014: (move_robot amr1 carrier1 warehouse location2)  [2.000]
16 .28.015: (move_robot amr1 carrier1 location2 location3)  [2.000]
17 .30.016: (deliver_supply amr1 carrier1 box2 tool2 work_station3 location3)  [2.000]
18 .32.017: (deliver_supply amr1 carrier1 box1 bolt1 work_station3 location3)  [2.000]
```

#### Domain - Problem 2

```bash
1. 0.000: (attach_carrier carrier1 amr1 warehouse)  [4.000]
2. 0.000: (attach_carrier carrier2 drone1 warehouse)  [4.000]
3. 4.001: (load_carrier amr1 carrier1 box1 warehouse)  [2.000]
4. 4.001: (load_carrier drone1 carrier2 box2 warehouse)  [2.000]
5. 6.002: (fill_box amr1 carrier1 box1 valve1)  [1.000]
6. 6.002: (fill_box drone1 carrier2 box2 tool2)  [1.000]
7. 7.003: (move_robot amr1 carrier1 warehouse location2)  [2.000]
8. 7.003: (load_carrier drone1 carrier2 box3 warehouse)  [2.000]
9. 9.004: (move_robot amr1 carrier1 location2 location1)  [2.000]
10. 9.004: (fill_box drone1 carrier2 box3 tool1)  [1.000]
11. 10.005: (load_carrier drone1 carrier2 box4 warehouse)  [2.000]
12. 11.005: (deliver_supply amr1 carrier1 box1 valve1 work_station1 location1)  [2.000]
13. 12.006: (fill_box drone1 carrier2 box4 bolt1)  [1.000]
14. 13.007: (move_robot drone1 carrier2 warehouse location2)  [2.000]
15. 15.008: (move_robot drone1 carrier2 location2 location3)  [2.000]
16. 17.009: (deliver_supply drone1 carrier2 box2 tool2 work_station3 location3)  [2.000]
17. 19.010: (deliver_supply drone1 carrier2 box4 bolt1 work_station3 location3)  [2.000]
18. 21.011: (move_robot drone1 carrier2 location3 location2)  [2.000]
19. 23.012: (move_robot drone1 carrier2 location2 location1)  [2.000]
20. 25.013: (deliver_supply drone1 carrier2 box3 tool1 work_station1 location1)  [2.000]
```
