import Lean
import src.Utils

namespace Day4

open Lean.Parsec 
open Lean (Parsec)

structure Card where
    id : Nat
    winningNums : Array Nat
    myNums : Array Nat
deriving Repr, Inhabited

def parseCard : Parsec Card := do
    ws *> skipString "Card" *> ws
    let id ← nat
    ws *> skipString ":" *> ws
    let winningNums ← many (nat <* ws)
    ws *> skipString "|" *> ws
    let myNums ← many (nat <* ws)
    return { id, winningNums, myNums }

def toCard (s : String) : Card := (parseCard.run s).toOption.get!

def Card.score (c : Card) : Nat :=
    c.winningNums.foldl (λpts n => if c.myNums.contains n then max 1 (2 * pts) else pts) 0

def Card.numWins (c : Card) : Nat := 
    c.winningNums.foldl (λtotal n => if c.myNums.contains n then total + 1 else total) 0

def part1 (input : Array String) : Nat := 
    input.foldl (λacc line => acc + (line |> toCard |>.score)) 0

def part2 (input : Array String) : Nat := Id.run do
    let remaining := input.map λline => line |> toCard |>.numWins
    let mut points := Array.mkArray remaining.size 0 -- cant set arbitrary indices with capacity

    for i in [0:remaining.size] do
        let lastᵢ := (remaining.size - 1) - i
        let lastVal := remaining[lastᵢ]!
        let mut p := 1

        for j in [0:lastVal] do
            p := p + points[(lastᵢ + 1) + j]!
        points := points.set! lastᵢ p
    points.foldl Nat.add 0

def main : IO Unit := do
    let input1 ← IO.FS.lines "inputs/day4.txt"

    timeit "Execution Time:" do 
        IO.println s!"Part 1:{part1 input1}"
    IO.println ""
    timeit s!"Execution Time:" do 
        IO.println s!"Part 2:{part2 input1}"
