package co.com.elramireza.pn.model;

import javax.persistence.*;
import java.util.Collection;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Jan 9, 2013
 * Time: 10:40:35 AM
 */
@Entity
@Table( name = "empresa_categoria")
public class EmpresaCategoria {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String categoria;

    @Basic
    @Column(name = "categoria")
    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    /*private Collection<Empresa> empresasById;

    @OneToMany(mappedBy = "empresaCategoriaByIdCategoriaEmpresa")
    public Collection<Empresa> getEmpresasById() {
        return empresasById;
    }

    public void setEmpresasById(Collection<Empresa> empresasById) {
        this.empresasById = empresasById;
    }*/
}
