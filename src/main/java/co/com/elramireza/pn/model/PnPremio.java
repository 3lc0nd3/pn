package co.com.elramireza.pn.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:57 PM
 */
@Entity
@Table( name = "pn_premio")
public class PnPremio {
    private int idPnPremio;

    @Id
    @Column(name = "id")
    public int getIdPnPremio() {
        return idPnPremio;
    }

    public void setIdPnPremio(int idPnPremio) {
        this.idPnPremio = idPnPremio;
    }

    private String nombrePremio;

    @Basic
    @Column(name = "nombre")
    public String getNombrePremio() {
        return nombrePremio;
    }

    public void setNombrePremio(String nombrePremio) {
        this.nombrePremio = nombrePremio;
    }

    private Timestamp fechaDesde;

    @Basic
    @Column(name = "fecha_desde")
    public Timestamp getFechaDesde() {
        return fechaDesde;
    }

    public void setFechaDesde(Timestamp fechaDesde) {
        this.fechaDesde = fechaDesde;
    }

    private Timestamp fechaHasta;

    @Basic
    @Column(name = "fecha_hasta")
    public Timestamp getFechaHasta() {
        return fechaHasta;
    }

    public void setFechaHasta(Timestamp fechaHasta) {
        this.fechaHasta = fechaHasta;
    }

    private boolean estadoInscripcion;

    @Basic
    @Column(name = "estado_inscripcion")
    @Type(type = "org.hibernate.type.NumericBooleanType")
    public boolean getEstadoInscripcion() {
        return estadoInscripcion;
    }

    public void setEstadoInscripcion(boolean estadoInscripcion) {
        this.estadoInscripcion = estadoInscripcion;
    }


    private Timestamp fechaCreacion;

    @Basic
    @Column(name = "fecha_creacion")
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    private String tmpFechaDesde;

    @Transient
    public String getTmpFechaDesde() {
        return tmpFechaDesde;
    }

    public void setTmpFechaDesde(String tmpFechaDesde) {
        this.tmpFechaDesde = tmpFechaDesde;
    }

    private String tmpFechaHasta;

    @Transient
    public String getTmpFechaHasta() {
        return tmpFechaHasta;
    }

    public void setTmpFechaHasta(String tmpFechaHasta) {
        this.tmpFechaHasta = tmpFechaHasta;
    }

}
