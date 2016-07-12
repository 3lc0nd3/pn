package co.com.elramireza.pn.model;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnTipoPremio that = (PnTipoPremio) o;

        if (id != that.id) return false;
        if (color != null ? !color.equals(that.color) : that.color != null) return false;
        if (descripcion != null ? !descripcion.equals(that.descripcion) : that.descripcion != null) return false;
        if (fechaCreacion != null ? !fechaCreacion.equals(that.fechaCreacion) : that.fechaCreacion != null)
            return false;
        if (postulese != null ? !postulese.equals(that.postulese) : that.postulese != null) return false;
        if (registroEvaluador != null ? !registroEvaluador.equals(that.registroEvaluador) : that.registroEvaluador != null)
            return false;
        if (nombreTipoPremio != null ? !nombreTipoPremio.equals(that.nombreTipoPremio) : that.nombreTipoPremio != null) return false;
        if (urlLogo != null ? !urlLogo.equals(that.urlLogo) : that.urlLogo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (nombreTipoPremio != null ? nombreTipoPremio.hashCode() : 0);
        result = 31 * result + (urlLogo != null ? urlLogo.hashCode() : 0);
        result = 31 * result + (color != null ? color.hashCode() : 0);
        result = 31 * result + (descripcion != null ? descripcion.hashCode() : 0);
        result = 31 * result + (postulese != null ? postulese.hashCode() : 0);
        result = 31 * result + (registroEvaluador != null ? registroEvaluador.hashCode() : 0);
        result = 31 * result + (fechaCreacion != null ? fechaCreacion.hashCode() : 0);
        return result;
    }
}
