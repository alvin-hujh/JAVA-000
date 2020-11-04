package com.hujh.camp.gateway.simply;


import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * 最简单的实现
 * 一个后端接口监听，收到请求后，通过 HttpClient 转发到 localhost:8081 上去
 */
public class SimpleGateway {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8808);
        while (true) {
            try {
                Socket socket = serverSocket.accept();
                service(socket, forwardRequest());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 转发消息
     *
     * @return
     */
    private static String forwardRequest() {
        String msg = "";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet("http://localhost:8801/");
        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(httpGet);
            //获取实体
            HttpEntity httpEntity = response.getEntity();
            //解析实体
            msg = EntityUtils.toString(httpEntity, "utf-8");
            response.close();
            httpClient.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return msg;
    }

    private static void service(Socket socket, String forwardMsg) {
        try {
            PrintWriter printWriter = new PrintWriter(socket.getOutputStream(), true);
            printWriter.println("HTTP/1.1 200 OK");
            printWriter.println("Content-Type:text/html;charset=utf-8");
            printWriter.println("Content-Length:" + forwardMsg.getBytes().length);
            printWriter.println();
            printWriter.write(forwardMsg);
            printWriter.close();
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
