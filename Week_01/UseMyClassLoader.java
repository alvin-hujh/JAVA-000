package Week_01;

import java.lang.reflect.Method;

public class UseMyClassLoader {
    public static void main(String[] args) {
        MyClassLoader classLoader = new MyClassLoader();
        try {
            Class<?> aClass = classLoader.findClass("Hello");
            Object instance = aClass.newInstance();
            Method method = aClass.getMethod("hello");
            //调用 hello 方法
            Object invoke = method.invoke(instance);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
