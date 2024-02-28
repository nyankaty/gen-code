package nemo.gencode.utils;

public class StringUtils {

    public static String getNormalNameFromClassName(String className) {
        return className.replaceAll("(?!^)([A-Z])", " $1");
    }
}
