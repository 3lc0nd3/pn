package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:50 PM
 */
@Entity
@Table(catalog = "pn", name = "participante")
public class Participante {
    private int id;

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

    private Timestamp fechaIngreso;

    @Basic
    @Column(name = "fecha_ingreso")
    public Timestamp getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Timestamp fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    private int estado;

    @Basic
    @Column(name = "estado")
    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    private String observaciones;

    @Basic
    @Column(name = "observaciones")
    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Participante that = (Participante) o;

        if (estado != that.estado) return false;
        if (id != that.id) return false;
        if (fechaIngreso != null ? !fechaIngreso.equals(that.fechaIngreso) : that.fechaIngreso != null) return false;
        if (observaciones != null ? !observaciones.equals(that.observaciones) : that.observaciones != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (fechaIngreso != null ? fechaIngreso.hashCode() : 0);
        result = 31 * result + estado;
        result = 31 * result + (observaciones != null ? observaciones.hashCode() : 0);
        return result;
    }

    private Empresa empresaByIdEmpresa;

    @ManyToOne
    @JoinColumn(name = "id_empresa", referencedColumnName = "id", nullable = false)
    public Empresa getEmpresaByIdEmpresa() {
        return empresaByIdEmpresa;
    }

    public void setEmpresaByIdEmpresa(Empresa empresaByIdEmpresa) {
        this.empresaByIdEmpresa = empresaByIdEmpresa;
    }

    private PnPremio pnPremioByIdConvocatoria;

    @ManyToOne
    @JoinColumn(name = "id_convocatoria", referencedColumnName = "id", nullable = false)
    public PnPremio getPnPremioByIdConvocatoria() {
        return pnPremioByIdConvocatoria;
    }

    public void setPnPremioByIdConvocatoria(PnPremio pnPremioByIdConvocatoria) {
        this.pnPremioByIdConvocatoria = pnPremioByIdConvocatoria;
    }
}
