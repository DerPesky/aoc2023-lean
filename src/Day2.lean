namespace Day2
structure Game where
    id : Nat
    maxR : Nat := 0
    maxG : Nat := 0
    maxB : Nat := 0

inductive Color where
| Red : Nat -> Color
| Green : Nat -> Color
| Blue : Nat -> Color
| None

def strToColor (s : String) : Color :=
    let sp := s.trim.splitOn " "

    match (sp.head!.toNat!, sp.getLast!.toLower) with
    | (n, "red") => .Red n
    | (n, "green") => .Green n
    | (n, "blue") => .Blue n
    | (_, _) => .None
    
def parseGame (gameData : String) : Game :=
    let id := gameData.splitOn ": " |>.head! |>.splitOn " " |>.getLast! |>.toNat!
    let rounds := gameData.splitOn ": " |>.getLast! |>.splitOn ";"

    let rec parseRound (acc : Game) (rest : List String) : Game :=
        match rest with
        | [] => acc
        | x :: xs =>
            match strToColor x with
            | .Red r => parseRound ({ acc with maxR := r + acc.maxR }) xs
            | .Green g => parseRound ({ acc with maxG := g + acc.maxG }) xs
            | .Blue b => parseRound ({ acc with maxB := b + acc.maxB }) xs
            | .None => acc

    let rec parseGameAux (currMax : Game) (rest : List String) : Game :=
        match rest with
        | [] => currMax 
        | x :: xs => 
            let rdData := parseRound { id } (x.splitOn ",")
            parseGameAux ({ currMax with 
                maxR := currMax.maxR.max rdData.maxR, 
                maxG := currMax.maxG.max rdData.maxG, 
                maxB := currMax.maxB.max rdData.maxB 
            }) xs

    parseGameAux { id } rounds

def part1 (input : List String) (rLim gLim bLim : Nat) : Nat :=
    let results := input.map λline => parseGame line
    let goodGames := results.filter λg => 
        g.maxR <= rLim && g.maxG <= gLim && g.maxB <= bLim
    goodGames.foldl (λsum gg => sum + gg.id) 0

def part2 (input : List String) : Nat :=
    let results := input.map λline => parseGame line
    results.foldl (λsum r => sum + r.maxR * r.maxG * r.maxB) 0

def main : IO Unit := do
    let input1 ← IO.FS.lines "inputs/day2_1.txt"
    let input2 ← IO.FS.lines "inputs/day2_2.txt"

    timeit s!"Day 2\nPart 1: {part1 input1.toList 12 13 14}" do 
        let a := part1 input1.toList 12 13 14
        IO.println a
        pure ()

    timeit s!"Part 2: {part2 input2.toList}" do 
        let a := part2 input2.toList
        IO.println a
        pure ()
