package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:49 PM
 */
@Entity
@Table( name = "loc_estado")
public class LocEstado {
    private int idEstado;

    @Id
    @Column(name = "id_estado")
    public int getIdEstado() {
        return idEstado;
    }

    public void setIdEstado(int idEstado) {
        this.idEstado = idEstado;
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

    private double latitudEstado;

    @Basic
    @Column(name = "latitud_estado")
    public double getLatitudEstado() {
        return latitudEstado;
    }

    public void setLatitudEstado(double latitudEstado) {
        this.latitudEstado = latitudEstado;
    }

    private double longitudEstado;

    @Basic
    @Column(name = "longitud_estado")
    public double getLongitudEstado() {
        return longitudEstado;
    }

    public void setLongitudEstado(double longitudEstado) {
        this.longitudEstado = longitudEstado;
    }

    private int activoEstado;

    @Basic
    @Column(name = "activo_estado")
    public int getActivoEstado() {
        return activoEstado;
    }

    public void setActivoEstado(int activoEstado) {
        this.activoEstado = activoEstado;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LocEstado locEstado = (LocEstado) o;

        if (activoEstado != locEstado.activoEstado) return false;
        if (idEstado != locEstado.idEstado) return false;
        if (Double.compare(locEstado.latitudEstado, latitudEstado) != 0) return false;
        if (Double.compare(locEstado.longitudEstado, longitudEstado) != 0) return false;
        if (nombreEstado != null ? !nombreEstado.equals(locEstado.nombreEstado) : locEstado.nombreEstado != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = idEstado;
        result = 31 * result + (nombreEstado != null ? nombreEstado.hashCode() : 0);
        temp = latitudEstado != +0.0d ? Double.doubleToLongBits(latitudEstado) : 0L;
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        temp = longitudEstado != +0.0d ? Double.doubleToLongBits(longitudEstado) : 0L;
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + activoEstado;
        return result;
    }

    private LocPais locPaisByIdPais;

    @ManyToOne
    @JoinColumn(name = "id_pais", referencedColumnName = "id_pais", nullable = false)
    public LocPais getLocPaisByIdPais() {
        return locPaisByIdPais;
    }

    public void setLocPaisByIdPais(LocPais locPaisByIdPais) {
        this.locPaisByIdPais = locPaisByIdPais;
    }
}
