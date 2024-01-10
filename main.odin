package main
import "core:c/libc"
import "core:fmt"
import "core:math/rand"
import "core:os"
import "core:strconv"
import "core:time"
import "core:unicode/utf8"

SIZE_X :: 120
SIZE_Y :: 50
BLOCK :: rune('x')
EMPTY :: rune(' ')

main :: proc() {
	if len(os.args) < 2 {
		fmt.eprintln("ERROR: Wrong ammount of args\n./life <3121>")
		return
	}
	pl_nums := strconv.atoi(os.args[1])

	arr := populate_random(pl_nums)
	print_life(&arr)
}

print_life :: proc(arr: ^[SIZE_Y][SIZE_X]bool) {
	for {
		fmt.printf("\033[2H") // NOTE clears the terminal
		for y := 0; y < SIZE_Y; y += 1 {
			for x := 0; x < SIZE_X; x += 1 {
				if arr[y][x] == false {
					fmt.print(" ")
				} else {
					fmt.print(BLOCK)
				}
			}
			fmt.print("\n")
		}
		step(arr)
	}
}

step :: proc(arr: ^[SIZE_Y][SIZE_X]bool) {
	nbs := 0
	for y := 0; y < SIZE_Y; y += 1 {
		for x := 0; x < SIZE_X; x += 1 {
			if arr[y][x] == true {
				if y < SIZE_Y - 1 && y > 1 {
					if arr[y + 1][x] == true do nbs += 1
					if arr[y - 1][x] == true do nbs += 1
				}

				if x < SIZE_X - 1 && x > 1 {
					if arr[y][x + 1] == true do nbs += 1
					if arr[y][x - 1] == true do nbs += 1
				}

				if x < SIZE_X - 1 && y < SIZE_Y - 1 && x > 1 && y > 1 {
					if arr[y + 1][x + 1] == true do nbs += 1
					if arr[y + 1][x - 1] == true do nbs += 1
					if arr[y - 1][x - 1] == true do nbs += 1
					if arr[y - 1][x + 1] == true do nbs += 1
				}
				if nbs < 2 do arr[y][x] = false
				else if nbs == 2 || nbs == 3 do continue
				else if nbs > 3 do arr[y][x] = false
			} else {
				nbs = 0
				if y < SIZE_Y - 1 && y > 1 {
					if arr[y + 1][x] == true do nbs += 1
					if arr[y - 1][x] == true do nbs += 1
				}
				if x < SIZE_X - 1 && x > 1 {
					if arr[y][x + 1] == true do nbs += 1
					if arr[y][x - 1] == true do nbs += 1
				}

				if x < SIZE_X - 1 && y < SIZE_Y - 1 && x > 1 && y > 1 {
					if arr[y + 1][x + 1] == true do nbs += 1
					if arr[y + 1][x - 1] == true do nbs += 1
					if arr[y - 1][x - 1] == true do nbs += 1
					if arr[y - 1][x + 1] == true do nbs += 1
				}
				if nbs == 3 do arr[y][x] = true
			}
			nbs = 0
		}
	}
}


populate_random :: proc(points: int) -> [SIZE_Y][SIZE_X]bool {
	new_arr := [SIZE_Y][SIZE_X]bool{}
	for i in 0 ..= points {
		rand_x := rand.int_max(SIZE_X)
		rand_y := rand.int_max(SIZE_Y)
		new_arr[rand_y][rand_x] = true
	}
	return new_arr
}
