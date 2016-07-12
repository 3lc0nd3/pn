package co.com.elramireza.pn.util;

import org.apache.log4j.Logger;

import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.IOException;

import static java.lang.String.format;


/**
 *
 * Created by elramireza
 * User: usuariox
 * Date: Feb 12, 2010
 * Time: 1:07:23 PM
 */
public class CommandSystem {

    private static final Logger logger  = org.apache.log4j.Logger.getLogger(CommandSystem.class);

    /**
     * Ejecuta comandos del sistema. Pj "ls -l"
     * @param command El Comando a ejecutar
     * @return int  0 si error , 1 si ok 
     */
    public static String exec(String command){
        //        Logger logger  = org.apache.log4j.Logger.getLogger(CommandSystem.class);
        String sStandar = "";
        String sError = "";
        String s;

        try {
            //logger.info("command = " + command);
//            System.out.println("command = " + command);
            Runtime runtime = Runtime.getRuntime();

            Process p = runtime.exec(command);

            Worker worker = new Worker(p);
            worker.start();
            worker.join(6000);

            if (worker.exit != null) {
                BufferedReader stdInput = new BufferedReader(new InputStreamReader(
                        p.getInputStream()));

                BufferedReader stdError = new BufferedReader(new InputStreamReader(
                        p.getErrorStream()));

                // Leemos la salida del comando
                //logger.debug("Command Output Standar:\n");
                while ((s = stdInput.readLine()) != null) {
                    sStandar += "\n"+s;
                    //logger.info(s);
                }

                // Leemos los errores si los hubiera
                //logger.debug("Command Output ERROR:\n");
                while ((s = stdError.readLine()) != null) {
                    sError += "\n"+s;
                    //logger.info(s);
                }
                return  format("%s %s", sStandar, sError);
            }
            else {
                p.destroy();
//                throw new TimeoutException();
            }

        } catch (IOException e) {
            //logger.debug(e.getMessage());
        } catch (InterruptedException e) {
            e.printStackTrace();
            //logger.debug(e.getMessage());
        }
        return format("%s %s", sStandar, sError);
    }

}
