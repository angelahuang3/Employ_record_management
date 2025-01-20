package com.example.demo;

import java.util.*;

public class Testlog {
    private static LogProvider logger;//宣告物件LogProvider的參照
    private static int logType=1;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
       if(logType==1) {
    	   logger=new LogPrintToScreen();//一開始不先new他，到後來才new
       }else if(logType==2) {
    	   logger =new LogWriteToFile();//依賴注入
       }
       List <String> list=new ArrayList<String>();
       list.add("AAA");
       logger.log("寫入AAA");
       list.add("BBB");
       logger.log("寫入BBB");
	}
}
//接上interface的實作
class LogPrintToScreen  implements LogProvider{
//控制權交給容器來做
	@Override
	public void log(String message) {
			System.out.println(message);
		}
	
}
class LogWriteToFile implements LogProvider{
	@Override
	public void log(String message) {
		//將log訊息寫入文字檔
	}
}
