import src.Utils
import Lean.Data.HashSet
open Lean

namespace Day3

structure Num where
    val : Nat
    pos₀ : Nat × Nat
    len : Nat
deriving BEq, Hashable

structure GridState where
    grid : Array (Array Char) := #[]
    symCoords : Array (Nat × Nat) := #[] -- stored as (row, col)

namespace GridState
    def getNumAtPos (gs : GridState) (pos : Nat × Nat) : Num := 
        let line := gs.grid[pos.1]!
        let leftLen := (line.extract 0 pos.2 |>.reverse |>.findIdx? λc => !c.isDigit).getD pos.2
        let rightLen := (line.extract pos.2 line.size |>.findIdx? λc => !c.isDigit).getD line.size

        let p := (pos.2 - leftLen, pos.2 + rightLen)
        let val := line.extract p.1 p.2 |>.foldl (λacc ch => acc.push ch) "" |>.toNat!
        { val, pos₀ := (pos.1, p.1), len := p.2 - p.1 }

    def getAdjNums (gs : GridState) (pos : Nat × Nat) : Array Num := Id.run do
        let mut nums : Array Num := {}
        for i in [pos.1 - 1:pos.1 + 2] do
            for j in [pos.2 - 1:pos.2 + 2] do
                if i >= gs.grid.size || j >= gs.grid[0]!.size then continue
                if gs.grid[i]![j]!.isDigit then nums := nums.push (gs.getNumAtPos (i, j))
        return nums.dedup

    private def getPositionsAux (gs : GridState) (f : Char -> Bool) : GridState := Id.run do 
        let mut positions := #[]
        for i in [0:gs.grid.size] do
            for j in [0:gs.grid[0]!.size] do
                if f gs.grid[i]![j]! then positions := positions.push (i, j)
        { gs with symCoords := positions }

    def getSymPositions (gs : GridState) : GridState := gs.getPositionsAux Char.isSymbol
    def getStarPositions (gs : GridState) : GridState := gs.getPositionsAux λch => ch == '*'
    def fromLines (l : Array String) : GridState := { grid := l.map λs => s.trim.toList.toArray }
end GridState

def part1 (input : Array String) : Nat :=
    let s := GridState.fromLines input |>.getSymPositions
    let adjNums := s.symCoords.map λ(row, col) => s.getAdjNums (row, col)
    adjNums.foldl (λacc nearbyNums => acc + nearbyNums.foldl (λacc num => acc + num.val) 0) 0

def part2 (input : Array String) : Nat :=
    let s := GridState.fromLines input |>.getStarPositions
    let allAdjNums := (s.symCoords.map λ(row, col) => s.getAdjNums (row, col))
        |>.filter λarr => arr.size >= 2 
    allAdjNums.foldl (λacc nearbyNums => acc + nearbyNums.foldl (λacc num => acc * num.val) 1) 0

def main : IO Unit := do
    let input1 ← IO.FS.lines "inputs/day3.txt"

    timeit "Execution Time:" do 
        IO.println s!"Part 1:{part1 input1}"
    IO.println ""
    timeit s!"Execution Time:" do 
        IO.println s!"Part 2:{part2 input1}"
