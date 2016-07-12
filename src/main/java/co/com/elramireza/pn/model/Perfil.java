package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:51 PM
 */
@Entity
@Table( name = "perfil")
public class Perfil {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String perfil;

    @Basic
    @Column(name = "perfil")
    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Perfil perfil1 = (Perfil) o;

        if (id != perfil1.id) return false;
        if (perfil != null ? !perfil.equals(perfil1.perfil) : perfil1.perfil != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (perfil != null ? perfil.hashCode() : 0);
        return result;
    }
}
