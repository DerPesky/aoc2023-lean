import src.Day1
import src.Day2
import src.Day3
/- import srcLean.Day4 -/
/- import srcLean.Day5 -/

def main (args : List String) : IO Unit := do
    let cmd :: _ := args | throw <| IO.userError "First Arg must be day (i.e day2)"
    match cmd with
    | "day1" => Day1.main
    | "day2" => Day2.main
    | "day3" => Day3.main
    /- | "day4" => Day4.main -/
    /- | "day5" => Day5.main -/
    | _ => throw <| IO.userError "unknown command"
