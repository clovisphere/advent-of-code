import std.algorithm;
import std.array;
import std.file : readText;
import std.stdio;
import std.string;

string[] REQUIRED_KEYS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"];

struct Field { string key; string value;}

bool is_valid(Field[] fields) {
    auto keys = fields.map!(field => field.key).array;
    foreach(key; REQUIRED_KEYS)
        if(!keys.canFind(key)) return false;
    return true;
}

void parse_fields(ref Field[] fields, string line) {
    fields ~= line.split(" ").map!((field) {
        auto kv = field.split(":");
        return Field(kv[0], kv[1]);
    }).array;
}

void main() {
    Field[] fields;
    int result;

    foreach(line; readText("input.txt").splitLines) {
        if(line.empty) {
            if(is_valid(fields)) result += 1;
            fields.length = 0;
        } else {
            parse_fields(fields, line);
        }
    }

    if(is_valid(fields)) result += 1;

    // part 01
    writeln("part 01: ", result);
}
