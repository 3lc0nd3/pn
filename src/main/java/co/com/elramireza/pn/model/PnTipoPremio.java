package co.com.elramireza.pn.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 14/07/15
 * Time: 01:49 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "pn_tipo_premio")
public class PnTipoPremio {
    private int id;
    private Persona personaById;
    private String nombreTipoPremio;
    private String frase;
    private String sigla;
    private String banner;
    private String urlLogo;
    private String urlLogoSmall;
    private String color;
    private String descripcion;
    private String postulese;
    private String registroEvaluador;
    private Timestamp fechaCreacion;
    private boolean activo;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "banner_tipo_premio")
    public String getBanner() {
        return banner;
    }

    public void setBanner(String banner) {
        this.banner = banner;
    }

    @ManyToOne
    @JoinColumn(name = "id_usuario", referencedColumnName = "id", nullable = false)
    public Persona getPersonaById() {
        return personaById;
    }

    public void setPersonaById(Persona personaById) {
        this.personaById = personaById;
    }

    @Basic
    @Column(name = "frase")
    public String getFrase() {
        return frase;
    }

    public void setFrase(String frase) {
        this.frase = frase;
    }

    @Basic
    @Column(name = "sigla")
    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    @Basic
    @Column(name = "url_logo_small")
    public String getUrlLogoSmall() {
        return urlLogoSmall;
    }

    public void setUrlLogoSmall(String urlLogoSmall) {
        this.urlLogoSmall = urlLogoSmall;
    }

    @Basic
    @Column(name = "nombre_tipo_premio")
    public String getNombreTipoPremio() {
        return nombreTipoPremio;
    }

    public void setNombreTipoPremio(String tipoPremio) {
        this.nombreTipoPremio = tipoPremio;
    }

    @Basic
    @Column(name = "url_logo")
    public String getUrlLogo() {
        return urlLogo;
    }

    public void setUrlLogo(String urlLogo) {
        this.urlLogo = urlLogo;
    }

    @Basic
    @Column(name = "color")
    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    @Basic
    @Column(name = "descripcion")
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Basic
    @Column(name = "postulese")
    public String getPostulese() {
        return postulese;
    }

    public void setPostulese(String postulese) {
        this.postulese = postulese;
    }

    @Basic
    @Column(name = "registro_evaluador")
    public String getRegistroEvaluador() {
        return registroEvaluador;
    }

    public void setRegistroEvaluador(String registroEvaluador) {
        this.registroEvaluador = registroEvaluador;
    }

    @Basic
    @Column(name = "fecha_creacion")
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    @Basic
    @Column(name = "activo")
    @Type(type = "org.hibernate.type.NumericBooleanType")
    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
