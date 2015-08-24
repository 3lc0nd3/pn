package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 24/08/15
 * Time: 01:20 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "pn_modelo_capitulo")
public class PnModeloCapitulo {
    private int id;
    private int idTipoPremio;
    private int numeroCapitulo;
    private String criterio;
    private String evaluaCapitulo;
    private int maximo;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "id_tipo_premio")
    public int getIdTipoPremio() {
        return idTipoPremio;
    }

    public void setIdTipoPremio(int idTipoPremio) {
        this.idTipoPremio = idTipoPremio;
    }

    @Basic
    @Column(name = "numero_capitulo")
    public int getNumeroCapitulo() {
        return numeroCapitulo;
    }

    public void setNumeroCapitulo(int numeroCapitulo) {
        this.numeroCapitulo = numeroCapitulo;
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
    @Column(name = "evalua_capitulo")
    public String getEvaluaCapitulo() {
        return evaluaCapitulo;
    }

    public void setEvaluaCapitulo(String evaluaCapitulo) {
        this.evaluaCapitulo = evaluaCapitulo;
    }

    @Basic
    @Column(name = "maximo")
    public int getMaximo() {
        return maximo;
    }

    public void setMaximo(int maximo) {
        this.maximo = maximo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnModeloCapitulo that = (PnModeloCapitulo) o;

        if (id != that.id) return false;
        if (idTipoPremio != that.idTipoPremio) return false;
        if (maximo != that.maximo) return false;
        if (numeroCapitulo != that.numeroCapitulo) return false;
        if (criterio != null ? !criterio.equals(that.criterio) : that.criterio != null) return false;
        if (evaluaCapitulo != null ? !evaluaCapitulo.equals(that.evaluaCapitulo) : that.evaluaCapitulo != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + idTipoPremio;
        result = 31 * result + numeroCapitulo;
        result = 31 * result + (criterio != null ? criterio.hashCode() : 0);
        result = 31 * result + (evaluaCapitulo != null ? evaluaCapitulo.hashCode() : 0);
        result = 31 * result + maximo;
        return result;
    }
}
