import ast
import sys
import json
from pathlib import Path
from src.dfg_creator import GraphBuilder
from src.graph_visualizer import expression_to_graph, visualize_graph, visualize_scheduled_graph
from src.scheduler import MinLatencyScheduler, MinResourceScheduler, ScheduledNodeInfo
from src.generator_verilog import generator_verilog
from pathlib import Path
MinResourceAlgorithm = "MinResourceLatencyConstrained"
MinlatencyAlgorithm = "MinLatencyResourceContrained"

def load_input(filename: str) -> dict:
    with open(filename, "r") as file:
        return json.load(file)

def build_dfg(expression: str, folder_path : str):
    ast_root = expression_to_graph(expression)

    dot = visualize_graph(ast_root)
    dot.attr(label="", labelloc='t', fontsize='17')  
    dot.render(folder_path + "/pics/DFG", format='png', view=False, cleanup=True)

    builder = GraphBuilder()
    return builder.build(ast_root)


def schedule_dfg(dfg_root, algorithm : str, config : dict, folder_path : str) -> list:
    if (algorithm == MinResourceAlgorithm):
        scheduler = MinResourceScheduler(dfg_root=dfg_root, numof_resources=config["Resources"], max_time=config["MaxTime"])
    else:
        scheduler = MinLatencyScheduler(dfg_root=dfg_root, numof_resources=config["Resources"])    
    scheduler.schedule()
    schedule_info = scheduler.get_scheduling_info()

    dot = visualize_scheduled_graph(root_id=dfg_root.id, schedule_info=schedule_info)
    dot.attr(label="", labelloc='t', fontsize='17')  
    dot.render(folder_path + "/pics/ScheduledDFG", format='png', view=False, cleanup=True)

    return schedule_info

'''
    Call your VerilogGenerator class here.
    Save the reuslting code files to:
        - "{folder_path}/codes/datapath.v"
        - "{folder_path}/codes/controller.v"
'''
def generate_verilog(folder_path: str, schedule_info: list[ScheduledNodeInfo]):
    gen = generator_verilog(schedule_info)

    codes_dir = Path(folder_path) / "codes"
    codes_dir.mkdir(parents=True, exist_ok=True)

    datapath_code = gen.emit_datapath()
    controller_code = gen.emit_controller_and_top()  
    top_code = gen.emit_top()                        

    (codes_dir / "datapath.v").write_text(datapath_code)
    (codes_dir / "controller.v").write_text(controller_code)
    (codes_dir / "top.v").write_text(top_code)      
    
def save_result(folder_path : str, schedule_info : list[ScheduledNodeInfo]):
    json_output = {}
    with open(folder_path + "/output.json", "w") as file:
        for node_info in schedule_info:
            json_output[node_info.node.id] = {
                "clk": node_info.scheduled_time,
                "resource_type": node_info.node.op_type,
                "resource_num": node_info.resource_num
            }
        json.dump(json_output, file, indent=4)

def run_test(folder_path : str):
    input_file_path = folder_path + "/input.json"
    data = load_input(input_file_path)

    dfg_root = build_dfg(expression=data["Expression"], folder_path=folder_path)

    schedule_info = schedule_dfg(dfg_root, algorithm=data["Algorithm"], config=data["Config"], folder_path=folder_path)

    save_result(folder_path=folder_path, schedule_info=schedule_info)

    generate_verilog(folder_path=folder_path, schedule_info=schedule_info)

def main():
    if len(sys.argv) > 1:
        run_test(folder_path=sys.argv[1])
    else:
        print("Please provide the input folder path.")

if __name__ == "__main__":
    main()
