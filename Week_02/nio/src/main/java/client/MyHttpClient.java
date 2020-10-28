package client;

import okhttp3.Call;
import okhttp3.OkHttpClient;
import okhttp3.Request;

import java.io.IOException;

/**
 * 通过 okhttp 请求 localhost:8801
 */
public class MyHttpClient {
    public static void main(String[] args) {
        OkHttpClient httpClient = new OkHttpClient();
        final Request request = new Request.Builder()
//                .url("http://www.baidu.com")
                .url("http://localhost:8801")
                .build();
        Call call = httpClient.newCall(request);
        call.enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                System.out.println(e);
            }

            @Override
            public void onResponse(Call call, okhttp3.Response response) throws IOException {
                String res=response.body().string();
                System.out.println(res);
            }
        });
    }
}
