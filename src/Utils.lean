import Lean
import Std

def Char.isDigit? (c : Char) : Option Nat :=
    if c.isDigit then some (c.toNat - '0'.toNat)
    else none

def Char.isSymbol (c : Char) : Bool :=
    if c.isDigit || c == '.' then false
    else true

def Char.isSymbol? (c : Char) : Option Char :=
    if c.isSymbol then some c else none

def Array.dedup {α : Type} [BEq α] (as : Array α) : Array α := Id.run do
    let mut as' := #[]
    for a in as do
        if !as'.contains a then
            as' := as'.push a
    return as'

def Nat.toStr! (n : Nat) : String :=
    match n with 
    | 0 => "0"
    | 1 => "1"
    | 2 => "2"
    | 3 => "3"
    | 4 => "4"
    | 5 => "5"
    | 6 => "6"
    | 7 => "7"
    | 8 => "8"
    | 9 => "9"
    | _ => panic! "Nat.toChar: n > 9"

namespace Lean.Parsec
    def digit' : Parsec Nat := do
        let c ← digit
        return c.toNat - '0'.toNat

    def nat : Parsec Nat := do
        let cs ← many1 digit'
        return cs.foldl (fun x y => x * 10 + y) 0
end Lean.Parsec
