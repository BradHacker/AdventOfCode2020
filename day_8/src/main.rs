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

    let fixed_code_value = recursive_fix_instructions(0, &lines, 0);
    println!(
        "{}, the program, modified at line {}, can terminate with an accumulator of {}",
        fixed_code_value.1,
        fixed_code_value.2 + 1,
        fixed_code_value.0,
    );
}

fn parse_instruction(instruction: String) -> Vec<i32> {
    let parts: Vec<String> = instruction.split(" ").map(|s| s.to_string()).collect();
    if parts[0] == "acc" {
        let parsed_int = parts[1].parse::<i32>();
        let ret: Vec<i32> = vec![ACC, parsed_int.unwrap()];
        return ret;
    } else if parts[0] == "jmp" {
        let parsed_int = parts[1].parse::<i32>();
        let ret: Vec<i32> = vec![JMP, parsed_int.unwrap()];
        return ret;
    } else {
        let ret: Vec<i32> = vec![NOP, 1];
        return ret;
    }
}

fn recursive_fix_instructions(
    depth: i32,
    instructions: &Vec<String>,
    to_modify_cursor: usize,
) -> (i32, bool, usize) {
    if to_modify_cursor == instructions.len() {
        return (0, false, 0);
    }
    let mut new_instructions: Vec<String> = instructions.clone();
    let orig_parts: Vec<String> = instructions[to_modify_cursor]
        .clone()
        .split(" ")
        .map(|s| s.to_string())
        .collect();

    // Test with original instruction
    let mut accumulator: i32 = 0;
    if can_terminate(&new_instructions, &mut accumulator) {
        return (accumulator, true, to_modify_cursor);
    }

    // Test with modified instruction
    if orig_parts[0] == "nop" {
        new_instructions[to_modify_cursor] = format!("{} {}", "jmp", orig_parts[1]);
    }
    if orig_parts[0] == "jmp" {
        new_instructions[to_modify_cursor] = format!("{} {}", "nop", orig_parts[1]);
    }
    let mut mod_accumulator: i32 = 0;
    if can_terminate(&new_instructions, &mut mod_accumulator) {
        return (mod_accumulator, true, to_modify_cursor);
    }

    // Try modifying next instruction
    return recursive_fix_instructions(depth, instructions, to_modify_cursor + 1);
}

fn can_terminate(instructions: &Vec<String>, accumulator: &mut i32) -> bool {
    let mut instruction_stack: Vec<i32> = Vec::<i32>::new();
    let mut cursor: usize = 0;

    instruction_stack.push(i32::try_from(cursor).unwrap());
    let inst = parse_instruction(instructions[cursor].clone());
    if inst[0] == ACC {
        *accumulator += inst[1];
        cursor += 1;
    } else if inst[0] == JMP {
        cursor = usize::try_from(i32::try_from(cursor).unwrap() + inst[1]).unwrap();
    } else if inst[0] == NOP {
        cursor += 1;
    }

    while !instruction_stack
        .iter()
        .any(|i| i == &i32::try_from(cursor).unwrap())
        && cursor < instructions.len()
    {
        instruction_stack.push(i32::try_from(cursor).unwrap());
        let inst = parse_instruction(instructions[cursor].clone());
        if inst[0] == ACC {
            *accumulator += inst[1];
            cursor += 1;
        } else if inst[0] == JMP {
            cursor = usize::try_from(i32::try_from(cursor).unwrap() + inst[1]).unwrap();
        } else if inst[0] == NOP {
            cursor += 1;
        }
    }

    if cursor == instructions.len() {
        return true;
    } else {
        return false;
    }
}
