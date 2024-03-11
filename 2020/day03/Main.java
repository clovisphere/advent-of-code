import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;


public class Main {
    public static void main(String... args) throws IOException {
        // read content of file, and split on '\n' 😽
        String[] input = Files.readString(Path.of("input.txt")).split("\n");
        int height = input.length, width = input[0].length();

        System.out.printf("part 01: %d\n", part01(input, height, width));
    }

    private static int part01(String[] input, int height, int width) {
        int x = 0, y = 0, result = 0;
        while(++y < height) {
            if (input[y].charAt((x += 3) % width) == '#') {
                result++;
            }
        }
        return result;
    }
}
