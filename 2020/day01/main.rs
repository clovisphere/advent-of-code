const SUM: i32 = 2020;

fn main() {
    let mut xs: Vec<i32> = std::fs::read_to_string("input.txt")
        .unwrap()
        .lines()
        .filter_map(|line| line.parse().ok())
        .collect();

    xs.sort();

    println!("part 01: {:?}", part01(&xs).unwrap_or_default());
    println!("part 02: {:?}", part02(&xs).unwrap_or_default());
}

fn part01(xs: &[i32]) -> Option<i32> {
    let n = xs.len();
    for i in 0..n {
        if let Ok(j) = xs.binary_search(&(SUM - xs[i])) {
            if i != j {
                return Some(xs[i] * xs[j]);
            }
        }
    }
    None
}

fn part02(xs: &[i32]) -> Option<i32> {
    let n = xs.len();
    for i in 0..n {
        for j in i + 1..n {
            if let Ok(k) = xs.binary_search(&(SUM - xs[i] - xs[j])) {
                if j != k {
                    return Some(xs[i] * xs[j] * xs[k]);
                }
            }
        }
    }
    None
}
