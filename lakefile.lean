import Lake
open Lake DSL

package «aoc2023» where
  -- add package configuration options here

lean_lib «Aoc2023» where
  -- add library configuration options here

@[default_target]
lean_exe «aoc2023» where
  root := `Main
  -- Enables the use of the Lean interpreter by the executable (e.g.,
  -- `runFrontend`) at the expense of increased binary size on Linux.
  -- Remove this line if you do not need such functionality.
  supportInterpreter := true

-- thanks github.com/anurudhp/aoc2022
lean_exe day1 { root := `Aoc2023.Day1 }
lean_exe day2 { root := `Aoc2023.Day2 }
lean_exe day3 { root := `Aoc2023.Day3 }
lean_exe day4 { root := `Aoc2023.Day4 }
lean_exe day5 { root := `Aoc2023.Day5 }
lean_exe day6 { root := `Aoc2023.Day6 }
lean_exe day7 { root := `Aoc2023.Day7 }
lean_exe day8 { root := `Aoc2023.Day8 }
lean_exe day9 { root := `Aoc2023.Day9 }
lean_exe day10 { root := `Aoc2023.Day10 }
lean_exe day11 { root := `Aoc2023.Day11 }
lean_exe day12 { root := `Aoc2023.Day12 }
lean_exe day13 { root := `Aoc2023.Day13 }
lean_exe day14 { root := `Aoc2023.Day14 }
lean_exe day15 { root := `Aoc2023.Day15 }
lean_exe day16 { root := `Aoc2023.Day16 }
lean_exe day17 { root := `Aoc2023.Day17 }
lean_exe day18 { root := `Aoc2023.Day18 }
lean_exe day19 { root := `Aoc2023.Day19 }
lean_exe day20 { root := `Aoc2023.Day20 }
lean_exe day21 { root := `Aoc2023.Day21 }
lean_exe day22 { root := `Aoc2023.Day22 }
lean_exe day23 { root := `Aoc2023.Day23 }
lean_exe day24 { root := `Aoc2023.Day24 }
lean_exe day25 { root := `Aoc2023.Day25 }
