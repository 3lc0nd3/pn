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
@Table( name = "servicio_rol")
public class ServicioRol {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private Perfil perfilByIdRol;

    @ManyToOne
    @JoinColumn(name = "id_rol", referencedColumnName = "id", nullable = false)
    public Perfil getPerfilByIdRol() {
        return perfilByIdRol;
    }

    public void setPerfilByIdRol(Perfil perfilByIdRol) {
        this.perfilByIdRol = perfilByIdRol;
    }

    private Servicio servicioByIdServicio;

    @ManyToOne
    @JoinColumn(name = "id_servicio", referencedColumnName = "id_servicio", nullable = false)
    public Servicio getServicioByIdServicio() {
        return servicioByIdServicio;
    }

    public void setServicioByIdServicio(Servicio servicioByIdServicio) {
        this.servicioByIdServicio = servicioByIdServicio;
    }
}
