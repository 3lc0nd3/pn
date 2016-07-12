package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:41:00 PM
 */
@Entity
@Table( name = "tipo_formato")
public class TipoFormato {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String tipoFormato;

    @Basic
    @Column(name = "tipo_formato")
    public String getTipoFormato() {
        return tipoFormato;
    }

    public void setTipoFormato(String tipoFormato) {
        this.tipoFormato = tipoFormato;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TipoFormato that = (TipoFormato) o;

        if (id != that.id) return false;
        if (tipoFormato != null ? !tipoFormato.equals(that.tipoFormato) : that.tipoFormato != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (tipoFormato != null ? tipoFormato.hashCode() : 0);
        return result;
    }
}
