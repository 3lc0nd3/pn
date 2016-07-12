package co.com.elramireza.pn.util;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Aug 4, 2011
 * Time: 11:37:53 PM
 */
public class Worker extends Thread{
    private final Process process;
    public Integer exit;
    public Worker(Process process) {
        this.process = process;
    }
    public void run() {
        try {
            exit = process.waitFor();
        } catch (InterruptedException ignore) {
            return;
        }
    }
}
