package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.sql.Timestamp;
import static java.lang.String.format;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:51 PM
 */
@Entity
@Table( name = "persona")
public class Persona {
    private int idPersona;

    @Id
    @GenericGenerator(name = "generator", strategy = "increment")
    @GeneratedValue(generator = "generator")
    @Column(name = "id")
    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    @Transient
    public String getNombreCompleto(){
        return format("%s %s", getNombrePersona(), getApellido());
    }

    private String nombrePersona;

    @Basic
    @Column(name = "nombre")
    public String getNombrePersona() {
        return nombrePersona;
    }

    public void setNombrePersona(String nombrePersona) {
        this.nombrePersona = nombrePersona;
    }

    private String apellido;

    @Basic
    @Column(name = "apellido")
    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    private String documentoIdentidad;

    @Basic
    @Column(name = "documento_identidad")
    public String getDocumentoIdentidad() {
        return documentoIdentidad;
    }

    public void setDocumentoIdentidad(String documentoIdentidad) {
        this.documentoIdentidad = documentoIdentidad;
    }

    private String emailPersonal;

    @Basic
    @Column(name = "email_personal")
    public String getEmailPersonal() {
        return emailPersonal;
    }

    public void setEmailPersonal(String emailPersonal) {
        this.emailPersonal = emailPersonal;
    }

    private String emailCorporativo;

    @Basic
    @Column(name = "email_corporativo")
    public String getEmailCorporativo() {
        return emailCorporativo;
    }

    public void setEmailCorporativo(String emailCorporativo) {
        this.emailCorporativo = emailCorporativo;
    }

    private String twitter;

    @Basic
    @Column(name = "twitter")
    public String getTwitter() {
        return twitter;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    private String skype;

    @Basic
    @Column(name = "skype")
    public String getSkype() {
        return skype;
    }

    public void setSkype(String skype) {
        this.skype = skype;
    }

    private String telefonoFijo;

    @Basic
    @Column(name = "telefono_fijo")
    public String getTelefonoFijo() {
        return telefonoFijo;
    }

    public void setTelefonoFijo(String telefonoFijo) {
        this.telefonoFijo = telefonoFijo;
    }

    private String celular;

    @Basic
    @Column(name = "celular")
    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    private String login;

    @Basic
    @Column(name = "login")
    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    private String clave;

    @Transient
    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    private String password;

    @Basic
    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    private boolean estado;

    @Basic
    @Column(name = "estado")
    @Type(type = "org.hibernate.type.NumericBooleanType")
    public boolean getEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    private int locCiudadPersona;

    @Transient
    public int getLocCiudadPersona() {
        return locCiudadPersona;
    }

    public void setLocCiudadPersona(int locCiudadPersona) {
        this.locCiudadPersona = locCiudadPersona;
    }

    private LocCiudad locCiudadByIdCiudad;

    @ManyToOne
    @JoinColumn(name = "id_ciudad", referencedColumnName = "id_ciudad", nullable = false)
    public LocCiudad getLocCiudadByIdCiudad() {
        return locCiudadByIdCiudad;
    }

    public void setLocCiudadByIdCiudad(LocCiudad locCiudadByIdCiudad) {
        this.locCiudadByIdCiudad = locCiudadByIdCiudad;
    }

    private Timestamp fechaCreacion;

    @Basic
    @Column(name = "fecha_creacion")
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    private int idCargoEmpleado;

    @Transient
    public int getIdCargoEmpleado() {
        return idCargoEmpleado;
    }

    public void setIdCargoEmpleado(int idCargoEmpleado) {
        this.idCargoEmpleado = idCargoEmpleado;
    }
}
