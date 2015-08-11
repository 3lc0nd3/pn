package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:57 PM
 */
@Entity
@Table( name = "pn_premio")
public class PnPremio {
    private int idPnPremio;

    private String version;
    private PnTipoPremio tipoPremioById;
    private String nombrePremio;
    private Timestamp fechaDesde;
    private Timestamp fechaHasta;
    private boolean estadoInscripcion;
    private Timestamp fechaCreacion;
    private String tmpFechaDesde;
    private String tmpFechaHasta;
    private Date ceremoniaEntregaPremio;
    private Date sustentacionJuradosHasta;
    private Date visitasCampoHasta;
    private Date evaluacionOrganizacionesHasta;
    private Date entregaInformesEjecutivosHasta;
    private Date orientacionPostulantesHasta;
    private Date inscripcionPostulantesHasta;
    private Date invitacionPostulacionHasta;
    private Date formacionEvaluadoresHasta;
    private Date inscripcionEvaluadoresHasta;

    private Date sustentacionJuradosDesde;
    private Date visitasCampoDesde;
    private Date evaluacionOrganizacionesDesde;
    private Date entregaInformesEjecutivosDesde;
    private Date orientacionPostulantesDesde;
    private Date inscripcionPostulantesDesde;
    private Date invitacionPostulacionDesde;
    private Date formacionEvaluadoresDesde;
    private Date inscripcionEvaluadoresDesde;

    @Basic
    @Column(name = "version")
    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    @Id
    @GenericGenerator(name = "generator", strategy = "increment")
    @GeneratedValue(generator = "generator")
    @Column(name = "id")
    public int getIdPnPremio() {
        return idPnPremio;
    }

    public void setIdPnPremio(int idPnPremio) {
        this.idPnPremio = idPnPremio;
    }

    @ManyToOne
    @JoinColumn(name = "pn_tipo_premio", referencedColumnName = "id", nullable = false)
    public PnTipoPremio getTipoPremioById() {
        return tipoPremioById;
    }

    public void setTipoPremioById(PnTipoPremio tipoPremioById) {
        this.tipoPremioById = tipoPremioById;
    }

    @Basic
    @Column(name = "nombre")
    public String getNombrePremio() {
        return nombrePremio;
    }

    public void setNombrePremio(String nombrePremio) {
        this.nombrePremio = nombrePremio;
    }

    @Basic
    @Column(name = "fecha_desde")
    public Timestamp getFechaDesde() {
        return fechaDesde;
    }

    public void setFechaDesde(Timestamp fechaDesde) {
        this.fechaDesde = fechaDesde;
    }

    @Basic
    @Column(name = "fecha_hasta")
    public Timestamp getFechaHasta() {
        return fechaHasta;
    }

    public void setFechaHasta(Timestamp fechaHasta) {
        this.fechaHasta = fechaHasta;
    }

    @Basic
    @Column(name = "estado_inscripcion")
    @Type(type = "org.hibernate.type.NumericBooleanType")
    public boolean getEstadoInscripcion() {
        return estadoInscripcion;
    }

    public void setEstadoInscripcion(boolean estadoInscripcion) {
        this.estadoInscripcion = estadoInscripcion;
    }

    @Basic
    @Column(name = "fecha_creacion")
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    @Transient
    public String getTmpFechaDesde() {
        return tmpFechaDesde;
    }

    public void setTmpFechaDesde(String tmpFechaDesde) {
        this.tmpFechaDesde = tmpFechaDesde;
    }

    @Transient
    public String getTmpFechaHasta() {
        return tmpFechaHasta;
    }

    public void setTmpFechaHasta(String tmpFechaHasta) {
        this.tmpFechaHasta = tmpFechaHasta;
    }

    @Basic
    @Column(name = "ceremonia_entrega_premio")
    public Date getCeremoniaEntregaPremio() {
        return ceremoniaEntregaPremio;
    }

    public void setCeremoniaEntregaPremio(Date ceremoniaEntregaPremio) {
        this.ceremoniaEntregaPremio = ceremoniaEntregaPremio;
    }

    @Basic
    @Column(name = "sustentacion_jurados_hasta")
    public Date getSustentacionJuradosHasta() {
        return sustentacionJuradosHasta;
    }

    public void setSustentacionJuradosHasta(Date sustentacionJuradosHasta) {
        this.sustentacionJuradosHasta = sustentacionJuradosHasta;
    }

    @Basic
    @Column(name = "visitas_campo_hasta")
    public Date getVisitasCampoHasta() {
        return visitasCampoHasta;
    }

    public void setVisitasCampoHasta(Date visitasCampoHasta) {
        this.visitasCampoHasta = visitasCampoHasta;
    }

    @Basic
    @Column(name = "evaluacion_organizaciones_hasta")
    public Date getEvaluacionOrganizacionesHasta() {
        return evaluacionOrganizacionesHasta;
    }

    public void setEvaluacionOrganizacionesHasta(Date evaluacionOrganizacionesHasta) {
        this.evaluacionOrganizacionesHasta = evaluacionOrganizacionesHasta;
    }

    @Basic
    @Column(name = "entrega_informes_ejecutivos_hasta")
    public Date getEntregaInformesEjecutivosHasta() {
        return entregaInformesEjecutivosHasta;
    }

    public void setEntregaInformesEjecutivosHasta(Date entregaInformesEjecutivosHasta) {
        this.entregaInformesEjecutivosHasta = entregaInformesEjecutivosHasta;
    }

    @Basic
    @Column(name = "orientacion_postulantes_hasta")
    public Date getOrientacionPostulantesHasta() {
        return orientacionPostulantesHasta;
    }

    public void setOrientacionPostulantesHasta(Date orientacionPostulantesHasta) {
        this.orientacionPostulantesHasta = orientacionPostulantesHasta;
    }

    @Basic
    @Column(name = "inscripcion_postulantes_hasta")
    public Date getInscripcionPostulantesHasta() {
        return inscripcionPostulantesHasta;
    }

    public void setInscripcionPostulantesHasta(Date inscripcionPostulantesHasta) {
        this.inscripcionPostulantesHasta = inscripcionPostulantesHasta;
    }

    @Basic
    @Column(name = "Invitacion_postulacion_hasta")
    public Date getInvitacionPostulacionHasta() {
        return invitacionPostulacionHasta;
    }

    public void setInvitacionPostulacionHasta(Date invitacionPostulacionHasta) {
        this.invitacionPostulacionHasta = invitacionPostulacionHasta;
    }

    @Basic
    @Column(name = "formacion_evaluadores_hasta")
    public Date getFormacionEvaluadoresHasta() {
        return formacionEvaluadoresHasta;
    }

    public void setFormacionEvaluadoresHasta(Date formacionEvaluadoresHasta) {
        this.formacionEvaluadoresHasta = formacionEvaluadoresHasta;
    }

    @Basic
    @Column(name = "inscripcion_evaluadores_hasta")
    public Date getInscripcionEvaluadoresHasta() {
        return inscripcionEvaluadoresHasta;
    }

    public void setInscripcionEvaluadoresHasta(Date inscripcionEvaluadoresHasta) {
        this.inscripcionEvaluadoresHasta = inscripcionEvaluadoresHasta;
    }

    @Basic
    @Column(name = "sustentacion_jurados_desde")
    public Date getSustentacionJuradosDesde() {
        return sustentacionJuradosDesde;
    }

    public void setSustentacionJuradosDesde(Date sustentacionJuradosDesde) {
        this.sustentacionJuradosDesde = sustentacionJuradosDesde;
    }

    @Basic
    @Column(name = "visitas_campo_desde")
    public Date getVisitasCampoDesde() {
        return visitasCampoDesde;
    }

    public void setVisitasCampoDesde(Date visitasCampoDesde) {
        this.visitasCampoDesde = visitasCampoDesde;
    }

    @Basic
    @Column(name = "evaluacion_organizaciones_desde")
    public Date getEvaluacionOrganizacionesDesde() {
        return evaluacionOrganizacionesDesde;
    }

    public void setEvaluacionOrganizacionesDesde(Date evaluacionOrganizacionesDesde) {
        this.evaluacionOrganizacionesDesde = evaluacionOrganizacionesDesde;
    }

    @Basic
    @Column(name = "entrega_informes_ejecutivos_desde")
    public Date getEntregaInformesEjecutivosDesde() {
        return entregaInformesEjecutivosDesde;
    }

    public void setEntregaInformesEjecutivosDesde(Date entregaInformesEjecutivosDesde) {
        this.entregaInformesEjecutivosDesde = entregaInformesEjecutivosDesde;
    }

    @Basic
    @Column(name = "orientacion_postulantes_desde")
    public Date getOrientacionPostulantesDesde() {
        return orientacionPostulantesDesde;
    }

    public void setOrientacionPostulantesDesde(Date orientacionPostulantesDesde) {
        this.orientacionPostulantesDesde = orientacionPostulantesDesde;
    }

    @Basic
    @Column(name = "inscripcion_postulantes_desde")
    public Date getInscripcionPostulantesDesde() {
        return inscripcionPostulantesDesde;
    }

    public void setInscripcionPostulantesDesde(Date inscripcionPostulantesDesde) {
        this.inscripcionPostulantesDesde = inscripcionPostulantesDesde;
    }

    @Basic
    @Column(name = "Invitacion_postulacion_desde")
    public Date getInvitacionPostulacionDesde() {
        return invitacionPostulacionDesde;
    }

    public void setInvitacionPostulacionDesde(Date invitacionPostulacionDesde) {
        this.invitacionPostulacionDesde = invitacionPostulacionDesde;
    }

    @Basic
    @Column(name = "formacion_evaluadores_desde")
    public Date getFormacionEvaluadoresDesde() {
        return formacionEvaluadoresDesde;
    }

    public void setFormacionEvaluadoresDesde(Date formacionEvaluadoresDesde) {
        this.formacionEvaluadoresDesde = formacionEvaluadoresDesde;
    }

    @Basic
    @Column(name = "inscripcion_evaluadores_desde")
    public Date getInscripcionEvaluadoresDesde() {
        return inscripcionEvaluadoresDesde;
    }

    public void setInscripcionEvaluadoresDesde(Date inscripcionEvaluadoresDesde) {
        this.inscripcionEvaluadoresDesde = inscripcionEvaluadoresDesde;
    }

}
