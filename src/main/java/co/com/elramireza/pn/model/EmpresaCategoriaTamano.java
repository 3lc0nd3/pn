package co.com.elramireza.pn.model;

import javax.persistence.*;
import java.util.Collection;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Jan 9, 2013
 * Time: 10:40:35 AM
 */
@Entity
@Table( name = "empresa_categoria_tamano")
public class EmpresaCategoriaTamano {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String tamano;

    @Basic
    @Column(name = "tamano")
    public String getTamano() {
        return tamano;
    }

    public void setTamano(String tamano) {
        this.tamano = tamano;
    }
}
