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
@Table(name = "pn_modelo_criterio")
public class PnModeloCriterio {
    private int id;
    private String criterio;
    private String evalua;
    private String c20;
    private String c40;
    private String c60;
    private String c80;
    private String c100;
    private String c50;
    private PnModeloCategoriaCriterio modeloCategoriaCriterioById;

    @ManyToOne
    @JoinColumn(name = "id_categoria_criterio", referencedColumnName = "id", nullable = false)
    public PnModeloCategoriaCriterio getModeloCategoriaCriterioById() {
        return modeloCategoriaCriterioById;
    }

    public void setModeloCategoriaCriterioById(PnModeloCategoriaCriterio modeloCategoriaCriterioById) {
        this.modeloCategoriaCriterioById = modeloCategoriaCriterioById;
    }

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "criterio")
    public String getCriterio() {
        return criterio;
    }

    public void setCriterio(String criterio) {
        this.criterio = criterio;
    }

    @Basic
    @Column(name = "evalua")
    public String getEvalua() {
        return evalua;
    }

    public void setEvalua(String evalua) {
        this.evalua = evalua;
    }

    @Basic
    @Column(name = "c_20")
    public String getC20() {
        return c20;
    }

    public void setC20(String c20) {
        this.c20 = c20;
    }

    @Basic
    @Column(name = "c_40")
    public String getC40() {
        return c40;
    }

    public void setC40(String c40) {
        this.c40 = c40;
    }

    @Basic
    @Column(name = "c_60")
    public String getC60() {
        return c60;
    }

    public void setC60(String c60) {
        this.c60 = c60;
    }

    @Basic
    @Column(name = "c_80")
    public String getC80() {
        return c80;
    }

    public void setC80(String c80) {
        this.c80 = c80;
    }

    @Basic
    @Column(name = "c_100")
    public String getC100() {
        return c100;
    }

    public void setC100(String c100) {
        this.c100 = c100;
    }

    @Basic
    @Column(name = "c_50")
    public String getC50() {
        return c50;
    }

    public void setC50(String c50) {
        this.c50 = c50;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnModeloCriterio that = (PnModeloCriterio) o;

        if (id != that.id) return false;
        if (c100 != null ? !c100.equals(that.c100) : that.c100 != null) return false;
        if (c20 != null ? !c20.equals(that.c20) : that.c20 != null) return false;
        if (c40 != null ? !c40.equals(that.c40) : that.c40 != null) return false;
        if (c50 != null ? !c50.equals(that.c50) : that.c50 != null) return false;
        if (c60 != null ? !c60.equals(that.c60) : that.c60 != null) return false;
        if (c80 != null ? !c80.equals(that.c80) : that.c80 != null) return false;
        if (criterio != null ? !criterio.equals(that.criterio) : that.criterio != null) return false;
        if (evalua != null ? !evalua.equals(that.evalua) : that.evalua != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (criterio != null ? criterio.hashCode() : 0);
        result = 31 * result + (evalua != null ? evalua.hashCode() : 0);
        result = 31 * result + (c20 != null ? c20.hashCode() : 0);
        result = 31 * result + (c40 != null ? c40.hashCode() : 0);
        result = 31 * result + (c60 != null ? c60.hashCode() : 0);
        result = 31 * result + (c80 != null ? c80.hashCode() : 0);
        result = 31 * result + (c100 != null ? c100.hashCode() : 0);
        result = 31 * result + (c50 != null ? c50.hashCode() : 0);
        return result;
    }
}
