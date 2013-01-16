package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:57 PM
 */
@Entity
@Table(catalog = "pn", name = "pn_sub_capitulo")
public class PnSubCapitulo {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private int ponderacion;

    @Basic
    @Column(name = "ponderacion")
    public int getPonderacion() {
        return ponderacion;
    }

    public void setPonderacion(int ponderacion) {
        this.ponderacion = ponderacion;
    }

    private String subCapitulo;

    @Basic
    @Column(name = "sub_capitulo")
    public String getSubCapitulo() {
        return subCapitulo;
    }

    public void setSubCapitulo(String subCapitulo) {
        this.subCapitulo = subCapitulo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnSubCapitulo that = (PnSubCapitulo) o;

        if (id != that.id) return false;
        if (ponderacion != that.ponderacion) return false;
        if (subCapitulo != null ? !subCapitulo.equals(that.subCapitulo) : that.subCapitulo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + ponderacion;
        result = 31 * result + (subCapitulo != null ? subCapitulo.hashCode() : 0);
        return result;
    }

    private PnCapitulo pnCapituloByIdCapitulo;

    @ManyToOne
    @JoinColumn(name = "id_capitulo", referencedColumnName = "id", nullable = false)
    public PnCapitulo getPnCapituloByIdCapitulo() {
        return pnCapituloByIdCapitulo;
    }

    public void setPnCapituloByIdCapitulo(PnCapitulo pnCapituloByIdCapitulo) {
        this.pnCapituloByIdCapitulo = pnCapituloByIdCapitulo;
    }
}
