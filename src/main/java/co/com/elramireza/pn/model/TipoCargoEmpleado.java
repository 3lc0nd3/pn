package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:59 PM
 */
@Entity
@Table( name = "tipo_cargo_empleado")
public class TipoCargoEmpleado {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String tipoCargo;

    @Basic
    @Column(name = "tipo_cargo")
    public String getTipoCargo() {
        return tipoCargo;
    }

    public void setTipoCargo(String tipoCargo) {
        this.tipoCargo = tipoCargo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TipoCargoEmpleado that = (TipoCargoEmpleado) o;

        if (id != that.id) return false;
        if (tipoCargo != null ? !tipoCargo.equals(that.tipoCargo) : that.tipoCargo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (tipoCargo != null ? tipoCargo.hashCode() : 0);
        return result;
    }
}
