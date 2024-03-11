import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;


public class Main {
    public static void main(String... args) throws IOException {
        // read content of file, and split on '\n' 😽
        var input = Files.readString(Path.of("input.txt")).split("\n");

        // part 01
        System.out.printf("part 01: %d\n", countTrees(input, 3, 1));

        // part 02
        int[][] slopes = {
            {1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}
        };

        long result = 1L;
        for(var slope : slopes) {
            result *= countTrees(input, slope[0], slope[1]);
        }
        System.out.printf("part 02: %d\n", result);
    }

    private static int countTrees(String[] input, int dx, int dy) {
        int x = 0, y = 0, result = 0, height = input.length, width = input[0].length();
        while((y += dy) < height) {
            if (input[y].charAt((x += dx) % width) == '#') {
                result++;
            }
        }
        return result;
    }
}
