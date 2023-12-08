import Lake
open Lake DSL

package «aoc2023» where
  -- add package configuration options here

lean_lib «src» where
  -- add library configuration options here

@[default_target]
lean_exe «aoc» where
  root := `Main

require std from git "https://github.com/leanprover/std4" @ "main"
