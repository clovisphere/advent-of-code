def part1(grid):
    count = 0
    for r in range(len(grid)):
        for c in range(len(grid[0])):
            if grid[r][c] != 'X': continue
            for dr in [-1, 0, 1]:
                for dc in [-1, 0, 1]:
                    if dr == dc == 0: continue
                    if not(0 <= r + 3 * dr < len(grid) \
                        and 0 <= c + 3 * dc < len(grid[0])): continue
                    if grid[r + dr][c + dc] == 'M' \
                        and grid[r + 2 * dr][c + 2 * dc] == 'A' \
                        and grid[r + 3 * dr][c + 3 * dc] == 'S':
                        count += 1
    return count

def part2(grid):
    count = 0
    for r in range(1, len(grid) - 1):
        for c in range(1, len(grid[0]) - 1):
            if grid[r][c] != 'A': continue
            corners = [grid[r-1][c-1], grid[r-1][c+1], grid[r+1][c+1], grid[r+1][c-1]]
            if ''.join(corners) in ('MMSS', 'MSSM', 'SSMM', 'SMMS'):
                count += 1
    return count


if __name__ == '__main__':
    grid = [ line.strip() for line in open('input.txt') ]

    print(f'Part 1: {part1(grid)}')
    print(f'Part 2: {part2(grid)}')
