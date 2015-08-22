package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 21/08/15
 * Time: 05:38 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "pn_modelo_cualitativa")
public class PnModeloCualitativa {
    private int id;
    private String campoCualitativa;
    private String nombreCualitativa;
    private String textoCualitativa;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "campo_cualitativa")
    public String getCampoCualitativa() {
        return campoCualitativa;
    }

    public void setCampoCualitativa(String campoCualitativa) {
        this.campoCualitativa = campoCualitativa;
    }

    @Basic
    @Column(name = "nombre_cualitativa")
    public String getNombreCualitativa() {
        return nombreCualitativa;
    }

    public void setNombreCualitativa(String nombreCualitativa) {
        this.nombreCualitativa = nombreCualitativa;
    }

    @Basic
    @Column(name = "texto_cualitativa")
    public String getTextoCualitativa() {
        return textoCualitativa;
    }

    public void setTextoCualitativa(String textoCualitativa) {
        this.textoCualitativa = textoCualitativa;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnModeloCualitativa that = (PnModeloCualitativa) o;

        if (id != that.id) return false;
        if (campoCualitativa != null ? !campoCualitativa.equals(that.campoCualitativa) : that.campoCualitativa != null)
            return false;
        if (nombreCualitativa != null ? !nombreCualitativa.equals(that.nombreCualitativa) : that.nombreCualitativa != null)
            return false;
        if (textoCualitativa != null ? !textoCualitativa.equals(that.textoCualitativa) : that.textoCualitativa != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (campoCualitativa != null ? campoCualitativa.hashCode() : 0);
        result = 31 * result + (nombreCualitativa != null ? nombreCualitativa.hashCode() : 0);
        result = 31 * result + (textoCualitativa != null ? textoCualitativa.hashCode() : 0);
        return result;
    }
}
