package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 22/08/15
 * Time: 04:14 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "pn_modelo_categoria_criterio")
public class PnModeloCategoriaCriterio {
    private int id;
    private String categoriaCriterio;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "categoria_criterio")
    public String getCategoriaCriterio() {
        return categoriaCriterio;
    }

    public void setCategoriaCriterio(String categoriaCriterio) {
        this.categoriaCriterio = categoriaCriterio;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnModeloCategoriaCriterio that = (PnModeloCategoriaCriterio) o;

        if (id != that.id) return false;
        if (categoriaCriterio != null ? !categoriaCriterio.equals(that.categoriaCriterio) : that.categoriaCriterio != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (categoriaCriterio != null ? categoriaCriterio.hashCode() : 0);
        return result;
    }
}
