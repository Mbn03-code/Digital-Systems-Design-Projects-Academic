from abc import ABC, abstractmethod
from .dfg_creator import BaseNode, OperatorNode, IdentifierNode, OP_TYPES
from typing import List, Dict, Set, Optional


class ScheduledNodeInfo:
    def __init__(self, node: OperatorNode, scheduled_time: int, resource_num: int):
        self.node = node
        self.scheduled_time = scheduled_time
        self.resource_num = resource_num


class ListScheduler(ABC):
    def __init__(self, dfg_root: BaseNode, numof_reources: dict):
        self.root = dfg_root
        if numof_reources is None:
            self.numof_resources = {op: 1 for op in OP_TYPES}
        else:
            self.numof_resources = numof_reources

        self.scheduled_nodes_info: List[ScheduledNodeInfo] = []

        self._all_ops: List[OperatorNode] = self._collect_operator_nodes()
        self._scheduled_ids: Set[int] = set()
        self._time: int = 1

    def _collect_operator_nodes(self) -> List[OperatorNode]:
        seen: Set[int] = set()
        ops: List[OperatorNode] = []

        def dfs(n: Optional[BaseNode]):
            if n is None:
                return
            if n.id in seen:
                return
            seen.add(n.id)

            if isinstance(n, OperatorNode):
                ops.append(n)
                for ch in n.operands:
                    dfs(ch)
            elif isinstance(n, IdentifierNode):
                return
            else:
                return

        dfs(self.root)
        return ops

    def record_scheduled_node(self, node: OperatorNode, scheduled_time: int, resource_num: int):
        recorded_info = ScheduledNodeInfo(node=node, scheduled_time=scheduled_time, resource_num=resource_num)
        self.scheduled_nodes_info.append(recorded_info)

    def get_scheduling_info(self) -> List[ScheduledNodeInfo]:
        return sorted(self.scheduled_nodes_info, key=lambda node_info: node_info.node.id)

    @abstractmethod
    def find_candidate_nodes(self) -> List[OperatorNode]:
        pass

    @abstractmethod
    def select_from_frontier(self, frontier: dict) -> List[OperatorNode]:
        pass

    @abstractmethod
    def schedule(self) -> None:
        pass


class MinLatencyScheduler(ListScheduler):
    def __init__(self, dfg_root: BaseNode, numof_resources: dict):
        super().__init__(dfg_root=dfg_root, numof_reources=numof_resources)

    def _is_ready(self, n: OperatorNode) -> bool:
        for op in n.operands:
            if isinstance(op, IdentifierNode):
                continue
            if isinstance(op, OperatorNode):
                if op.id not in self._scheduled_ids:
                    return False
        return True

    # TODO
    def find_candidate_nodes(self) -> List[OperatorNode]:
        candidates: List[OperatorNode] = []
        for n in self._all_ops:
            if n.id in self._scheduled_ids:
                continue
            if self._is_ready(n):
                candidates.append(n)
        return candidates

    # TODO
    def select_from_frontier(self, frontier: dict) -> List[OperatorNode]:
        selected: List[OperatorNode] = []
        for op_type in OP_TYPES:
            lst: List[OperatorNode] = frontier.get(op_type, [])

            lst_sorted = sorted(lst, key=lambda n: (-n.depth, n.id))

            cap = int(self.numof_resources.get(op_type, 0))

            if cap <= 0:
                cap = len(lst_sorted)

            selected.extend(lst_sorted[:cap])

        return selected

    # TODO
    def schedule(self) -> None:
        self._time = 1
        self._scheduled_ids = set()
        self.scheduled_nodes_info = []

        total = len(self._all_ops)
        while len(self._scheduled_ids) < total:
            cand = self.find_candidate_nodes()
            frontier = {op: [] for op in OP_TYPES}
            for n in cand:
                frontier[n.op_type].append(n)

            chosen = self.select_from_frontier(frontier)

            if not chosen:
                # nothing ready this cycle
                self._time += 1
                continue

            used = {op: 0 for op in OP_TYPES}
            for n in chosen:
                used[n.op_type] += 1
                res_idx = used[n.op_type]
                self.record_scheduled_node(n, self._time, res_idx)
                self._scheduled_ids.add(n.id)

            self._time += 1


class MinResourceScheduler(ListScheduler):
    def __init__(self, dfg_root: BaseNode, numof_resources: dict, max_time: int):
        super().__init__(dfg_root=dfg_root, numof_reources=numof_resources)
        self.max_time = max_time
        self.latest_time = self.find_latest_times()

    def _build_successors(self) -> Dict[int, List[OperatorNode]]:
        succ: Dict[int, List[OperatorNode]] = {n.id: [] for n in self._all_ops}

        def dfs(parent: Optional[BaseNode]):
            if parent is None:
                return
            if isinstance(parent, OperatorNode):
                for ch in parent.operands:
                    if isinstance(ch, OperatorNode):
                        if ch.id in succ:
                            succ[ch.id].append(parent)
                        dfs(ch)
                    elif isinstance(ch, IdentifierNode):
                        continue

        dfs(self.root)
        return succ

    # TODO
    def find_latest_times(self) -> dict:
        # ALAP (as-late-as-possible) times with unit latency edges, bounded by max_time
        latest: Dict[int, int] = {n.id: self.max_time for n in self._all_ops}

        if isinstance(self.root, OperatorNode):
            latest[self.root.id] = self.max_time

        succ = self._build_successors()

        changed = True
        while changed:
            changed = False
            for n in self._all_ops:
                s_list = succ.get(n.id, [])
                if not s_list:
                    continue
                new_val = min(latest[s.id] - 1 for s in s_list)
                if new_val < latest[n.id]:
                    latest[n.id] = new_val
                    changed = True

        return latest

    def _is_ready(self, n: OperatorNode) -> bool:
        for op in n.operands:
            if isinstance(op, IdentifierNode):
                continue
            if isinstance(op, OperatorNode):
                if op.id not in self._scheduled_ids:
                    return False
        return True

    # TODO
    def find_candidate_nodes(self) -> List[OperatorNode]:
        # Ready + within latest_time constraint
        candidates: List[OperatorNode] = []
        for n in self._all_ops:
            if n.id in self._scheduled_ids:
                continue
            if not self._is_ready(n):
                continue
            if self._time <= self.latest_time.get(n.id, self.max_time):
                candidates.append(n)
        return candidates

    # TODO
    def select_from_frontier(self, frontier: dict) -> List[OperatorNode]:
        selected: List[OperatorNode] = []
        for op_type in OP_TYPES:
            lst: List[OperatorNode] = frontier.get(op_type, [])

            def key(n: OperatorNode):
                mobility = self.latest_time.get(n.id, self.max_time) - self._time
                return (mobility, n.depth, n.id)

            lst_sorted = sorted(lst, key=key)

            cap = int(self.numof_resources.get(op_type, 0))

            # If cap<=0 => unlimited hardware.
            # To minimize used resources under latency constraint,
            # schedule only FORCED ops (mobility <= 0) each cycle.
            forced: List[OperatorNode] = []
            for n in lst_sorted:
                mobility = self.latest_time.get(n.id, self.max_time) - self._time
                if mobility <= 0:
                    forced.append(n)

            if cap <= 0:
                selected.extend(forced)
            else:
                selected.extend(forced[:cap])

        return selected

    # TODO
    def schedule(self) -> None:
        self._time = 1
        self._scheduled_ids = set()
        self.scheduled_nodes_info = []

        total = len(self._all_ops)
        infeasible = False

        while len(self._scheduled_ids) < total:
            # If we exceeded max_time and still have ops -> infeasible for constraint
            if self._time > self.max_time:
                infeasible = True
                break

            # Candidates that respect latest-time
            cand = self.find_candidate_nodes()

            # Detect infeasible EARLY:
            # If there exists at least one READY node, but none pass latest_time at this time,
            # then we already missed the deadline -> infeasible.
            ready_now: List[OperatorNode] = []
            for n in self._all_ops:
                if n.id in self._scheduled_ids:
                    continue
                if self._is_ready(n):
                    ready_now.append(n)

            if (not cand) and ready_now:
                infeasible = True
                break

            frontier = {op: [] for op in OP_TYPES}
            for n in cand:
                frontier[n.op_type].append(n)

            chosen = self.select_from_frontier(frontier)

            if not chosen:
                # nothing to schedule in this cycle (no ready nodes)
                self._time += 1
                continue

            used = {op: 0 for op in OP_TYPES}
            for n in chosen:
                used[n.op_type] += 1
                res_idx = used[n.op_type]
                self.record_scheduled_node(n, self._time, res_idx)
                self._scheduled_ids.add(n.id)

            self._time += 1

        # Fallback: if latency-constrained scheduling is infeasible, do MinLatency scheduling
        # so the program doesn't crash and Verilog can still be generated/simulated.
        if infeasible:
            fallback = MinLatencyScheduler(dfg_root=self.root, numof_resources=self.numof_resources)
            fallback.schedule()
            self.scheduled_nodes_info = fallback.scheduled_nodes_info
            self._scheduled_ids = set(x.node.id for x in self.scheduled_nodes_info)
            self._time = max((x.scheduled_time for x in self.scheduled_nodes_info), default=0) + 1
