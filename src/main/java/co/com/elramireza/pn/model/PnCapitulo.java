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
@Table(catalog = "pn", name = "pn_capitulo")
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnCapitulo that = (PnCapitulo) o;

        if (id != that.id) return false;
        if (nombreCapitulo != null ? !nombreCapitulo.equals(that.nombreCapitulo) : that.nombreCapitulo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (nombreCapitulo != null ? nombreCapitulo.hashCode() : 0);
        return result;
    }
}
