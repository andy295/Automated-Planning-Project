# Problem 4

## Commands
1. Planner: OPTIC
	- ``optic domain.pddl problem.pddl -b``

## Solution

### OPTIC

```bash
1. 0.000: (attach_carrier carrier1 amr1 warehouse)  [4.000]
2. 0.000: (attach_carrier carrier2 drone1 warehouse)  [4.000]
3. 4.001: (load_carrier amr1 carrier1 box1 warehouse)  [2.000]
4. 4.001: (load_carrier drone1 carrier2 box2 warehouse)  [2.000]
5. 6.002: (fill_box amr1 carrier1 box1 valve1)  [1.000]
6. 6.002: (fill_box drone1 carrier2 box2 bolt1)  [1.000]
7. 7.003: (move_robot amr1 carrier1 warehouse location2)  [2.000]
8. 7.003: (move_robot drone1 carrier2 warehouse location2)  [2.000]
9. 9.004: (move_robot amr1 carrier1 location2 location3)  [2.000]
10. 9.004: (move_robot drone1 carrier2 location2 location1)  [2.000]
11. 11.005: (deliver_supply amr1 carrier1 box1 valve1 work_station3 location3)  [2.000]
12. 11.005: (deliver_supply drone1 carrier2 box2 bolt1 work_station1 location1)  [2.000]
13. 13.006: (move_robot amr1 carrier1 location3 location2)  [2.000]
14. 13.006: (move_robot drone1 carrier2 location1 location2)  [2.000]
15. 15.007: (move_robot amr1 carrier1 location2 warehouse)  [2.000]
16. 15.007: (move_robot drone1 carrier2 location2 warehouse)  [2.000]
17. 17.008: (fill_box amr1 carrier1 box1 tool1)  [1.000]
18. 17.008: (fill_box drone1 carrier2 box2 tool2)  [1.000]
19. 18.009: (move_robot amr1 carrier1 warehouse location2)  [2.000]
20. 18.009: (move_robot drone1 carrier2 warehouse location2)  [2.000]
21. 20.010: (move_robot amr1 carrier1 location2 location3)  [2.000]
22. 20.010: (move_robot drone1 carrier2 location2 location1)  [2.000]
23. 22.011: (deliver_tool amr1 carrier1 box1 tool1 work_station3 location3)  [2.000]
24. 22.011: (deliver_tool drone1 carrier2 box2 tool2 work_station1 location1)  [2.000]
```
