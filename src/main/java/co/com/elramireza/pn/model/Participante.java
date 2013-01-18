package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

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
    private int idParticipante;

    @Id
    @GenericGenerator(name = "generator", strategy = "increment")
    @GeneratedValue(generator = "generator")
    @Column(name = "id")
    public int getIdParticipante() {
        return idParticipante;
    }

    public void setIdParticipante(int idParticipante) {
        this.idParticipante = idParticipante;
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

    private boolean estado;

    @Basic
    @Column(name = "estado")
    @Type(type = "org.hibernate.type.NumericBooleanType")
    public boolean getEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
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
