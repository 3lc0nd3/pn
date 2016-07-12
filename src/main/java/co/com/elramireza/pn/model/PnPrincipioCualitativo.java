package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;

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
@Table(name = "pn_principio_cualitativo")
public class PnPrincipioCualitativo {
    private int id;
    private String campo;
    private String nombreCualitativa;
    private String textoCualitativa;
    private PnTipoPremio pnTipoPremioById;

    @Id
    @GenericGenerator(name = "generator", strategy = "increment")
    @GeneratedValue(generator = "generator")
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @ManyToOne
    @JoinColumn(name = "id_tipo_premio", referencedColumnName = "id", nullable = false)
    public PnTipoPremio getPnTipoPremioById() {
        return pnTipoPremioById;
    }

    public void setPnTipoPremioById(PnTipoPremio pnTipoPremioById) {
        this.pnTipoPremioById = pnTipoPremioById;
    }

    @Basic
    @Column(name = "campo")
    public String getCampo() {
        return campo;
    }

    public void setCampo(String campo) {
        this.campo = campo;
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

        PnPrincipioCualitativo that = (PnPrincipioCualitativo) o;

        if (id != that.id) return false;
        if (campo != null ? !campo.equals(that.campo) : that.campo != null) return false;
        if (nombreCualitativa != null ? !nombreCualitativa.equals(that.nombreCualitativa) : that.nombreCualitativa != null)
            return false;
        if (textoCualitativa != null ? !textoCualitativa.equals(that.textoCualitativa) : that.textoCualitativa != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (campo != null ? campo.hashCode() : 0);
        result = 31 * result + (nombreCualitativa != null ? nombreCualitativa.hashCode() : 0);
        result = 31 * result + (textoCualitativa != null ? textoCualitativa.hashCode() : 0);
        return result;
    }
}
