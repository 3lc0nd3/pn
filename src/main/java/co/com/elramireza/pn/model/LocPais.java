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
@Table( name = "loc_pais")
public class LocPais {
    private int idPais;

    @Id
    @Column(name = "id_pais")
    public int getIdPais() {
        return idPais;
    }

    public void setIdPais(int idPais) {
        this.idPais = idPais;
    }

    private String nombrePais;

    @Basic
    @Column(name = "nombre_pais")
    public String getNombrePais() {
        return nombrePais;
    }

    public void setNombrePais(String nombrePais) {
        this.nombrePais = nombrePais;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LocPais locPais = (LocPais) o;

        if (idPais != locPais.idPais) return false;
        if (nombrePais != null ? !nombrePais.equals(locPais.nombrePais) : locPais.nombrePais != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPais;
        result = 31 * result + (nombrePais != null ? nombrePais.hashCode() : 0);
        return result;
    }
}
