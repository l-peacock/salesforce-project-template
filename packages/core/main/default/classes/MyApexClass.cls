/**
 * MyApexClass
 * @description Class Description
 * @group Sample
 */
public with sharing class MyApexClass {
  /**
   * @description MyApexClass's Constructor
   */
  public MyApexClass() {
    String var = 'hello world!';
  }

  /**
   * @description my description
   * @param param1 The String to return
   * @return param1
   * @example
   * String result = MyApexClass.MyMethod('Hello, World!');
   */
  public static String MyMethod(String param1) {
    return param1;
  }
}
