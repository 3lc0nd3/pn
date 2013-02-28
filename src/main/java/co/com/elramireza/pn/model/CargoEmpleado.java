package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:38 PM
 */
@Entity
@Table( name = "cargo_empleado")
public class CargoEmpleado {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String cargo;

    @Basic
    @Column(name = "cargo")
    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CargoEmpleado that = (CargoEmpleado) o;

        if (id != that.id) return false;
        if (cargo != null ? !cargo.equals(that.cargo) : that.cargo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (cargo != null ? cargo.hashCode() : 0);
        return result;
    }

    private TipoCargoEmpleado tipoCargoEmpleadoByIdTipoCargo;

    @ManyToOne
    @JoinColumn(name = "id_tipo_cargo", referencedColumnName = "id", nullable = false)
    public TipoCargoEmpleado getTipoCargoEmpleadoByIdTipoCargo() {
        return tipoCargoEmpleadoByIdTipoCargo;
    }

    public void setTipoCargoEmpleadoByIdTipoCargo(TipoCargoEmpleado tipoCargoEmpleadoByIdTipoCargo) {
        this.tipoCargoEmpleadoByIdTipoCargo = tipoCargoEmpleadoByIdTipoCargo;
    }
}
