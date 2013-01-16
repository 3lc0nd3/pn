package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:55 PM
 */
@Entity
@Table(catalog = "pn", name = "pn_criterio")
public class PnCriterio {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String criterio;

    @Basic
    @Column(name = "criterio")
    public String getCriterio() {
        return criterio;
    }

    public void setCriterio(String criterio) {
        this.criterio = criterio;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnCriterio that = (PnCriterio) o;

        if (id != that.id) return false;
        if (criterio != null ? !criterio.equals(that.criterio) : that.criterio != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (criterio != null ? criterio.hashCode() : 0);
        return result;
    }

    private PnCategoriaCriterio pnCategoriaCriterioByIdCategoriaCriterio;

    @ManyToOne
    @JoinColumn(name = "id_categoria_criterio", referencedColumnName = "id", nullable = false)
    public PnCategoriaCriterio getPnCategoriaCriterioByIdCategoriaCriterio() {
        return pnCategoriaCriterioByIdCategoriaCriterio;
    }

    public void setPnCategoriaCriterioByIdCategoriaCriterio(PnCategoriaCriterio pnCategoriaCriterioByIdCategoriaCriterio) {
        this.pnCategoriaCriterioByIdCategoriaCriterio = pnCategoriaCriterioByIdCategoriaCriterio;
    }
}
