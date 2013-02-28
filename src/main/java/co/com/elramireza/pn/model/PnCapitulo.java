package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:54 PM
 */
@Entity
@Table( name = "pn_capitulo")
public class PnCapitulo {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String nombreCapitulo;

    @Basic
    @Column(name = "criterio")
    public String getNombreCapitulo() {
        return nombreCapitulo;
    }

    public void setNombreCapitulo(String nombreCapitulo) {
        this.nombreCapitulo = nombreCapitulo;
    }

    private String evaluaCapitulo;

    @Basic
    @Column(name = "evalua_capitulo")
    public String getEvaluaCapitulo() {
        return evaluaCapitulo;
    }

    public void setEvaluaCapitulo(String evaluaCapitulo) {
        this.evaluaCapitulo = evaluaCapitulo;
    }

    private int maximo;

    @Basic
    @Column(name = "maximo")
    public int getMaximo() {
        return maximo;
    }

    public void setMaximo(int maximo) {
        this.maximo = maximo;
    }
}
