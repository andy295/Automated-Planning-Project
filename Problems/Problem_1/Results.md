# Problem 1

## Commands
1. Planner: LAMA-First
	- ``lama-first domain.pddl problem.pddl``

2. Planner: LAMA
	- ``lama domain.pddl problem.pddl``

## Solutions

### LAMA-First

```bash
1. (load_robot robot1 box1 warehouse)
2. (fill_box robot1 box1 tool1)
3. (move_robot robot1 warehouse location2)
4. (move_robot robot1 location2 location1)
5. (deliver_supply robot1 box1 tool1 work_station1 location1)
6. (move_robot robot1 location1 location2)
7. (move_robot robot1 location2 warehouse)
8. (fill_box robot1 box1 bolt2)
9. (move_robot robot1 warehouse location2)
10. (move_robot robot1 location2 location3)
11. (deliver_supply robot1 box1 bolt2 work_station3 location3)
12. (move_robot robot1 location3 location2)
13. (move_robot robot1 location2 warehouse)
14. (fill_box robot1 box1 tool2)
15. (move_robot robot1 warehouse location2)
16. (move_robot robot1 location2 location3)
17. (deliver_supply robot1 box1 tool2 work_station3 location3)

Plan cost: 17
```

### LAMA

```bash
1. (load_robot robot1 box1 warehouse)
2. (fill_box robot1 box1 tool1)
3. (move_robot robot1 warehouse location2)
4. (move_robot robot1 location2 location1)
5. (deliver_supply robot1 box1 tool1 work_station1 location1)
6. (move_robot robot1 location1 location2)
7. (move_robot robot1 location2 warehouse)
8. (fill_box robot1 box1 bolt2)
9. (move_robot robot1 warehouse location2)
10. (move_robot robot1 location2 location3)
11. (deliver_supply robot1 box1 bolt2 work_station3 location3)
12. (move_robot robot1 location3 location2)
13. (move_robot robot1 location2 warehouse)
14. (fill_box robot1 box1 tool2)
15. (move_robot robot1 warehouse location2)
16. (move_robot robot1 location2 location3)
17. (deliver_supply robot1 box1 tool2 work_station3 location3)

Plan cost: 17
```
