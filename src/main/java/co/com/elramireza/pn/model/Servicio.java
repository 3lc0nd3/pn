package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:58 PM
 */
@Entity
@Table( name = "servicio")
public class Servicio {
    private int idServicio;

    @Id
    @Column(name = "id_servicio")
    public int getIdServicio() {
        return idServicio;
    }

    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }

    private String servicio;

    @Basic
    @Column(name = "servicio")
    public String getServicio() {
        return servicio;
    }

    public void setServicio(String servicio) {
        this.servicio = servicio;
    }

    private String textoServicio;

    @Basic
    @Column(name = "texto_servicio")
    public String getTextoServicio() {
        return textoServicio;
    }

    public void setTextoServicio(String textoServicio) {
        this.textoServicio = textoServicio;
    }

    private int publico;

    @Basic
    @Column(name = "publico")
    public int getPublico() {
        return publico;
    }

    public void setPublico(int publico) {
        this.publico = publico;
    }

    private int visible;

    @Basic
    @Column(name = "visible")
    public int getVisible() {
        return visible;
    }

    public void setVisible(int visible) {
        this.visible = visible;
    }

    private String tipo;

    @Basic
    @Column(name = "tipo")
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    private int orden;

    @Basic
    @Column(name = "orden")
    public int getOrden() {
        return orden;
    }

    public void setOrden(int orden) {
        this.orden = orden;
    }
}
