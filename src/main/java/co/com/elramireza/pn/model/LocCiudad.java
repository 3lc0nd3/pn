package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:46 PM
 */
@Entity
@Table( name = "loc_ciudad")
public class LocCiudad {
    private int idCiudad;

    @Id
    @Column(name = "id_ciudad")
    public int getIdCiudad() {
        return idCiudad;
    }

    public void setIdCiudad(int idCiudad) {
        this.idCiudad = idCiudad;
    }

    private String codigoCiudad;

    @Basic
    @Column(name = "codigo_ciudad")
    public String getCodigoCiudad() {
        return codigoCiudad;
    }

    public void setCodigoCiudad(String codigoCiudad) {
        this.codigoCiudad = codigoCiudad;
    }

    private String nombreCiudad;

    @Basic
    @Column(name = "nombre_ciudad")
    public String getNombreCiudad() {
        return nombreCiudad;
    }

    public void setNombreCiudad(String nombreCiudad) {
        this.nombreCiudad = nombreCiudad;
    }

    private String nombreEstado;

    @Basic
    @Column(name = "nombre_estado")
    public String getNombreEstado() {
        return nombreEstado;
    }

    public void setNombreEstado(String nombreEstado) {
        this.nombreEstado = nombreEstado;
    }

    private int latitudCiudad;

    @Basic
    @Column(name = "latitud_ciudad")
    public int getLatitudCiudad() {
        return latitudCiudad;
    }

    public void setLatitudCiudad(int latitudCiudad) {
        this.latitudCiudad = latitudCiudad;
    }

    private int longitudCiudad;

    @Basic
    @Column(name = "longitud_ciudad")
    public int getLongitudCiudad() {
        return longitudCiudad;
    }

    public void setLongitudCiudad(int longitudCiudad) {
        this.longitudCiudad = longitudCiudad;
    }

    private int activoCiudad;

    @Basic
    @Column(name = "activo_ciudad")
    public int getActivoCiudad() {
        return activoCiudad;
    }

    public void setActivoCiudad(int activoCiudad) {
        this.activoCiudad = activoCiudad;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LocCiudad locCiudad = (LocCiudad) o;

        if (activoCiudad != locCiudad.activoCiudad) return false;
        if (idCiudad != locCiudad.idCiudad) return false;
        if (latitudCiudad != locCiudad.latitudCiudad) return false;
        if (longitudCiudad != locCiudad.longitudCiudad) return false;
        if (codigoCiudad != null ? !codigoCiudad.equals(locCiudad.codigoCiudad) : locCiudad.codigoCiudad != null)
            return false;
        if (nombreCiudad != null ? !nombreCiudad.equals(locCiudad.nombreCiudad) : locCiudad.nombreCiudad != null)
            return false;
        if (nombreEstado != null ? !nombreEstado.equals(locCiudad.nombreEstado) : locCiudad.nombreEstado != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idCiudad;
        result = 31 * result + (codigoCiudad != null ? codigoCiudad.hashCode() : 0);
        result = 31 * result + (nombreCiudad != null ? nombreCiudad.hashCode() : 0);
        result = 31 * result + (nombreEstado != null ? nombreEstado.hashCode() : 0);
        result = 31 * result + latitudCiudad;
        result = 31 * result + longitudCiudad;
        result = 31 * result + activoCiudad;
        return result;
    }

    private LocEstado locEstadoByIdEstado;

    @ManyToOne
    @JoinColumn(name = "id_estado", referencedColumnName = "id_estado")
    public LocEstado getLocEstadoByIdEstado() {
        return locEstadoByIdEstado;
    }

    public void setLocEstadoByIdEstado(LocEstado locEstadoByIdEstado) {
        this.locEstadoByIdEstado = locEstadoByIdEstado;
    }
}
