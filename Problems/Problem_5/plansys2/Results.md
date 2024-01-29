# Problem 5

## Commands
Please, refer to [Setup](../Setup.md) file.

## Solution found 

### POPF

#### Domain - Problem 1

```bash
plan: 
1. 0:      (attach_carrier carrier1 amr1 warehouse)        [1]
2. 1.001:  (load_carrier amr1 carrier1 box1 warehouse)     [2]
3. 3.002:  (fill_box amr1 carrier1 box1 bolt1 warehouse)   [1]
4. 4.003:  (load_carrier amr1 carrier1 box2 warehouse)     [2]
5. 6.004:  (fill_box amr1 carrier1 box2 tool1 warehouse)   [1]
6. 7.005:  (move_robot amr1 carrier1 warehouse location2)  [2]
7. 9.006:  (move_robot amr1 carrier1 location2 location3)  [2]
8. 11.007: (deliver_supply amr1 carrier1 box1 bolt1 work_station3 location3)       [2]
9. 13.008: (deliver_tool amr1 carrier1 box2 tool1 work_station3 location3) [2]
10. 15.009: (move_robot amr1 carrier1 location3 location2)  [2]
11. 17.01:  (move_robot amr1 carrier1 location2 warehouse)  [2]
12. 19.011: (fill_box amr1 carrier1 box1 tool2 warehouse)   [1]
13. 20.012: (move_robot amr1 carrier1 warehouse location2)  [2]
14. 22.013: (move_robot amr1 carrier1 location2 location1)  [2]
15. 24.014: (deliver_tool amr1 carrier1 box1 tool2 work_station1 location1) [2]
```

#### Execution

```bash
Attaching carrier ... [100%]  
Loading carrier ... [100%]  
Filling box ... [100%]  
Loading carrier ... [100%]  
Filling box ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Supply delivering ... [100%]  
Tool delivering ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Filling box ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Tool delivering ... [100%]  
```

#### Domain - Problem 2

```bash
1. 0:      (attach_carrier carrier1 amr1 warehouse)        [1]
2. 0:      (attach_carrier carrier2 drone1 warehouse)      [1]
3. 1.001:  (move_robot amr1 carrier1 warehouse location2)  [2]
4. 1.001:  (load_carrier drone1 carrier2 box1 warehouse)   [2]
5. 3.002:  (fill_box drone1 carrier2 box1 bolt1 warehouse) [1]
6. 3.002:  (move_robot amr1 carrier1 location2 location1)  [2]
7. 4.003:  (load_carrier drone1 carrier2 box2 warehouse)   [2]
8. 6.004:  (fill_box drone1 carrier2 box2 tool1 warehouse) [1]
9. 7.005:  (load_carrier drone1 carrier2 box3 warehouse)   [2]
10. 9.006:  (fill_box drone1 carrier2 box3 valve1 warehouse)        [1]
11. 10.007: (move_robot drone1 carrier2 warehouse location2)        [2]
12. 12.008: (move_robot drone1 carrier2 location2 location1)        [2]
13. 14.009: (deliver_supply drone1 carrier2 box1 bolt1 work_station1 1. location1)     [2]
14. 16.01:  (move_robot drone1 carrier2 location1 location2)        [2]
15. 18.011: (move_robot drone1 carrier2 location2 location3)        [2]
16. 20.012: (deliver_supply drone1 carrier2 box3 valve1 work_station3 1. location3)    [2]
17. 22.013: (deliver_tool drone1 carrier2 box2 tool1 work_station3 1. location3)       [2]
18. 24.014: (move_robot drone1 carrier2 location3 location2)        [2]
19. 26.015: (move_robot drone1 carrier2 location2 warehouse)        [2]
20. 28.016: (fill_box drone1 carrier2 box1 tool2 warehouse) [1]
21. 29.017: (move_robot drone1 carrier2 warehouse location2)        [2]
22 31.018: (move_robot drone1 carrier2 location2 location1)        [2]
23. 33.019: (deliver_tool drone1 carrier2 box1 tool2 work_station1 location1)       [2]
```

#### Execution
```bash
Attaching carrier ... [100%]  
Attaching carrier ... [100%]  
Loading carrier ... [100%]  
Filling box ... [100%]  
Loading carrier ... [100%]  
Robot moving ... [100%]  
Filling box ... [100%]  
Loading carrier ... [100%]  
Filling box ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Supply delivering ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Supply delivering ... [100%]  
Tool delivering ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Filling box ... [100%]  
Robot moving ... [100%]  
Robot moving ... [100%]  
Tool delivering ... [100%]   
```
