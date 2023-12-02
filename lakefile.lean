import Lake
open Lake DSL

package «aoc2023» where
  -- add package configuration options here

lean_lib «src» where
  -- add library configuration options here

@[default_target]
lean_exe «aoc2023» where
  root := `Main
  -- Enables the use of the Lean interpreter by the executable (e.g.,
  -- `runFrontend`) at the expense of increased binary size on Linux.
  -- Remove this line if you do not need such functionality.
  supportInterpreter := true

-- thanks github.com/anurudhp/aoc2022
lean_exe day1 { root := `src.Day1 }
lean_exe day2 { root := `src.Day2 }
lean_exe day3 { root := `src.Day3 }
lean_exe day4 { root := `src.Day4 }
lean_exe day5 { root := `src.Day5 }
lean_exe day6 { root := `src.Day6 }
lean_exe day7 { root := `src.Day7 }
lean_exe day8 { root := `src.Day8 }
lean_exe day9 { root := `src.Day9 }
lean_exe day10 { root := `src.Day10 }
lean_exe day11 { root := `src.Day11 }
lean_exe day12 { root := `src.Day12 }
lean_exe day13 { root := `src.Day13 }
lean_exe day14 { root := `src.Day14 }
lean_exe day15 { root := `src.Day15 }
lean_exe day16 { root := `src.Day16 }
lean_exe day17 { root := `src.Day17 }
lean_exe day18 { root := `src.Day18 }
lean_exe day19 { root := `src.Day19 }
lean_exe day20 { root := `src.Day20 }
lean_exe day21 { root := `src.Day21 }
lean_exe day22 { root := `src.Day22 }
lean_exe day23 { root := `src.Day23 }
lean_exe day24 { root := `src.Day24 }
lean_exe day25 { root := `src.Day25 }
