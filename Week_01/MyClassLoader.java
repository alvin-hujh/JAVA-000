package Week_01;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class MyClassLoader extends ClassLoader {
    @Override
    protected Class<?> findClass(String name) {
        String myPath = "file:///Users/hujh/develop/Java-Training-Camp/JAVA-000/Week_01/Hello/" + name + ".xlass";
        System.out.println(myPath);
        byte[] cLassBytes = null;
        Path path = null;
        try {
            path = Paths.get(new URI(myPath));
            cLassBytes = Files.readAllBytes(path);
        } catch (IOException | URISyntaxException e) {
            e.printStackTrace();
        }
        //hello.xlass 中字节文件 y=255-x,此处需要做反加密,即用 255 再减一次
        byte salt = (byte) 255;
        assert cLassBytes != null;
        for (int i = 0; i < cLassBytes.length; i++) {
            cLassBytes[i] = (byte) (salt - cLassBytes[i]);
        }
        return defineClass(name, cLassBytes, 0, cLassBytes.length);
    }

}
