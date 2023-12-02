-- Implement ocaml in lean4
/- let dump i res = Printf.printf "Part %d: %s\n\n%!" i res -/
/- let dump_int i res = dump i (string_of_int res) -/

def printAoc (part : Nat) (res : String) : IO Unit :=
    IO.println s!"Part {part}: {res}\n"
