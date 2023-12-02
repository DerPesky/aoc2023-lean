def convertNum (s : String) : String :=
    s.replace "one" "one1one"
    |>.replace "two" "two2two"
    |>.replace "three" "three3three"
    |>.replace "four" "four4four"
    |>.replace "five" "five5five"
    |>.replace "six" "six6six"
    |>.replace "seven" "seven7seven"
    |>.replace "eight" "eight8eight"
    |>.replace "nine" "nine9nine"

def getInts (s : String) : Int :=
    let list := s.toList
    let num₁ := list.find? Char.isDigit |>.getD '0'
    let num₂ := list.reverse.find? Char.isDigit |>.getD '0'
    String.toInt! s!"{num₁}{num₂}"

def part1 (input : Array String) : Int :=
    input |>.map getInts |>.foldl .add 0

def part2 (input : Array String) : Int :=
    input |>.map convertNum |>.map getInts |>.foldl .add 0

def main : IO Unit := do
    let input1 ← IO.FS.lines "inputs/day1_1.txt"
    let input2 ← IO.FS.lines "inputs/day1_2.txt"

    timeit s!"Day 1\nPart 1: {part1 input1}" do 
        let _ := part1 input1
        pure ()

    timeit s!"Part 2: {part2 input2}" do 
        let _ := part2 input2
        pure ()
