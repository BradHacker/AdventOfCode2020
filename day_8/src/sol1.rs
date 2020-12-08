use std::convert::TryFrom;
use std::env;
use std::fs;

static ACC: i32 = 1;
static JMP: i32 = 2;
static NOP: i32 = 3;

fn main() {
    let args: Vec<String> = env::args().collect();

    let filename = &args[1];

    let contents =
        fs::read_to_string(filename).expect("something went wrong with reading the file");

    let lines: Vec<String> = contents.split("\n").map(|s| s.to_string()).collect();

    println!("Read in {} lines from {}", lines.len(), filename);

    let mut instruction_stack: Vec<i32> = Vec::<i32>::new();
    let mut cursor: usize = 0;
    let mut accumulator: i32 = 0;

    instruction_stack.push(i32::try_from(cursor).unwrap());
    let inst = parse_instruction(lines[cursor].clone());
    if inst[0] == ACC {
        accumulator += inst[1];
        cursor += 1;
    } else if inst[0] == JMP {
        cursor = usize::try_from(i32::try_from(cursor).unwrap() + inst[1]).unwrap();
    } else if inst[0] == NOP {
        cursor += 1;
    }

    while !instruction_stack
        .iter()
        .any(|i| i == &i32::try_from(cursor).unwrap())
    {
        instruction_stack.push(i32::try_from(cursor).unwrap());
        let inst = parse_instruction(lines[cursor].clone());
        if inst[0] == ACC {
            accumulator += inst[1];
            cursor += 1;
        } else if inst[0] == JMP {
            cursor = usize::try_from(i32::try_from(cursor).unwrap() + inst[1]).unwrap();
        } else if inst[0] == NOP {
            cursor += 1;
        }
    }
    println!(
        "Last instruction executed prior to crash: {}",
        instruction_stack[instruction_stack.len() - 1]
    );
    println!("Value in accumulator: {}", accumulator);
}

fn parse_instruction(instruction: String) -> Vec<i32> {
    let parts: Vec<String> = instruction.split(" ").map(|s| s.to_string()).collect();
    if parts[0] == "acc" {
        let ret: Vec<i32> = vec![ACC, parts[1].parse::<i32>().unwrap()];
        return ret;
    } else if parts[0] == "jmp" {
        let ret: Vec<i32> = vec![JMP, parts[1].parse::<i32>().unwrap()];
        return ret;
    } else {
        let ret: Vec<i32> = vec![NOP, 1];
        return ret;
    }
}
