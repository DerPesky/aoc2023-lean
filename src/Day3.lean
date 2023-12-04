-- TODO: Part 2
structure NumBlock where
    beginIdx : Nat
    endIdx : Nat

structure NumBlock2 extends NumBlock where
    touchingStarIds : Array Nat

instance : ToString NumBlock where
    toString nb := s!"{nb.beginIdx} - {nb.endIdx}"

def strArrayToCharArray (arr : Array String) : Array Char :=
    arr.foldl (λacc line => acc ++ line) "" |>.trim |>.toList |>.toArray

def charArrayToStrArray (arr : Array Char) : String :=
    arr.foldl (λacc c => acc.push c) ""
    
def Char.isSymbol (c : Char) : Bool :=
    if c.isDigit || c == '.' || c == '\n' then false
    else true

def absPosToXY (p : Nat) (lineLen : Nat) : Nat × Nat := (p / lineLen, p % lineLen)

def absPositionsTouch (pos₁ pos₂ lineLen : Nat) :=
    let coord₁ := absPosToXY pos₁ lineLen
    let coord₂ := absPosToXY pos₂ lineLen
    let compatibleX := coord₂.fst - 1 <= coord₁.fst && coord₁.fst <= coord₂.fst + 1
    let compatibleY := coord₂.snd - 1 <= coord₁.snd && coord₁.snd <= coord₂.snd + 1
    compatibleX && compatibleY

def blockTouchesSymbol (lineLen : Nat) (nb : NumBlock) (absSymbolPositions : Array Nat) : Bool := Id.run <| do
    for i in [nb.beginIdx : nb.endIdx + 1] do
        for symPos in absSymbolPositions do
            if absPositionsTouch i symPos lineLen then
                return true
    return false

def getTouchingStarIds (lineLen : Nat) (nb : NumBlock) (absStarPositions : Array Nat) : NumBlock2 := Id.run <| do 
    let mut touchingStarIds := #[]

    for i in [nb.beginIdx : nb.endIdx + 1] do
        for starPos in absStarPositions do
            if absPositionsTouch i starPos lineLen then
                touchingStarIds := touchingStarIds.push starPos
    { beginIdx := nb.beginIdx, endIdx := nb.endIdx, touchingStarIds := touchingStarIds }
    
def positionToNumBlocks (absPositions : Array Nat) : Array NumBlock := Id.run <| do
    if absPositions.isEmpty then
        return #[]

    let mut beginPos := absPositions[0]!
    let mut lastPos := 0
    let mut numBlocks := #[]

    for i in [0:absPositions.size] do
        if absPositions[i]! == absPositions[i - 1]! + 1 || i == 0 then
            lastPos := absPositions[i]!
        else
            numBlocks := numBlocks.push ({ beginIdx := beginPos, endIdx := lastPos })
            beginPos := absPositions[i]!
            lastPos := absPositions[i]!
    numBlocks.push ({ beginIdx := beginPos, endIdx := lastPos })

def numAbsPositions (lineLen : Nat) (grid : Array String) : Array (Array Nat) :=
    let rec numPositionsAux (i : Nat) (positions₀ : Array Nat) (rest : List Char) : Array Nat :=
        match rest with
        | [] => positions₀
        | x :: xs => match x.isDigit with
            | true => numPositionsAux (i + 1) (positions₀.push i) xs
            | false => numPositionsAux (i + 1) positions₀ xs

    grid.mapIdx (λi line => numPositionsAux (i * lineLen) #[] line.toList)

def getSymbolPositions (lineLen : Nat) (grid : Array String) : Array (Array Nat) :=
    let rec starPositionsAux (i : Nat) (positions₀ : Array Nat) (rest : List Char) : Array Nat :=
        match rest with
        | [] => positions₀
        | x :: xs => match x.isSymbol with
            | true => starPositionsAux (i + 1) (positions₀.push i) xs
            | false => starPositionsAux (i + 1) positions₀ xs

    grid.mapIdx (λi line => starPositionsAux (i * lineLen) #[] line.toList)

def flatten (grid : Array (Array α)) : Array α :=
    grid.foldl (λacc line => acc ++ line) #[]

-- keep blocks that touch a symbol
def getPartNumsIdxs (lineLen : Nat) (grid : Array String) := Id.run <| do
    let symPositions := getSymbolPositions lineLen grid |> flatten
    let numBlocks := grid 
    |> numAbsPositions lineLen 
    |>.map (λline => positionToNumBlocks line)
    |> flatten
    numBlocks.filter (λnb => blockTouchesSymbol lineLen nb symPositions)

def part1 (input : Array String) : Nat := Id.run <| do
    let lineLen := input[0]!.length
    let idxs := input |> getPartNumsIdxs lineLen
    let mut sum := 0

    let input := strArrayToCharArray input
    for idx in idxs do
        let str := input.extract idx.beginIdx (idx.endIdx + 1) |> charArrayToStrArray
        sum := sum + (str.toNat!)
    sum

def main : IO Unit := do
    let input1 ← IO.FS.lines "inputs/day3_1.txt"
    let input1 := input1.map (λline => line.trim)

    timeit s!"Day 3\nPart 1: {part1 input1}" do 
        let _ := part1 input1
        pure ()
