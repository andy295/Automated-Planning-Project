# Problem 1

## Commands
1. Planner: LAMA-First
	- ``lama-first domain.pddl problem.pddl``

## Solution

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
10. (move_robot robot1 location2 location4)
11. (deliver_supply robot1 box1 bolt2 work_station3 location4)
12. (move_robot robot1 location4 location2)
13. (move_robot robot1 location2 warehouse)
14. (fill_box robot1 box1 bolt1)
15. (move_robot robot1 warehouse location2)
16. (move_robot robot1 location2 location4)
17. (deliver_supply robot1 box1 bolt1 work_station4 location4)
18. (move_robot robot1 location4 location2)
19. (move_robot robot1 location2 warehouse)
20. (fill_box robot1 box1 tool2)
21. (move_robot robot1 warehouse location2)
22. (move_robot robot1 location2 location4)
23. (deliver_supply robot1 box1 tool2 work_station4 location4)
```

### Comments
It is possible to use the LAMA planner as well by using the following command:
``lama domain.pddl problem.pddl``

The obtained solution is the same as with LAMA-First.
