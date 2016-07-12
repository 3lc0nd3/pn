package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:55 PM
 */
@Entity
@Table( name = "pn_cualitativa")
public class PnCualitativa {
    private int id;
    private Timestamp fechaCreacion;
    private String vision;
    private String fortalezas;
    private String oportunidades;
    private String pendientesVisita;
    private PnCapitulo pnCapituloByIdCapitulo;
    private Empleado empleadoByIdEmpleado;
    private TipoFormato tipoFormatoByIdTipoFormato;

    @Id
    @GenericGenerator(name = "generator", strategy = "increment")
    @GeneratedValue(generator = "generator")
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
	@Column(name = "vision")
	public String getVision() {
		return vision;
	}

	public void setVision(String vision) {
		this.vision = vision;
	}

    @Basic
    @Column(name = "fortalezas")
    public String getFortalezas() {
        return fortalezas;
    }

    public void setFortalezas(String fortalezas) {
        this.fortalezas = fortalezas;
    }

    @Basic
    @Column(name = "oportunidades")
    public String getOportunidades() {
        return oportunidades;
    }

    public void setOportunidades(String oportunidades) {
        this.oportunidades = oportunidades;
    }

    @Basic
    @Column(name = "pendientes_visita")
    public String getPendientesVisita() {
        return pendientesVisita;
    }

    public void setPendientesVisita(String pendientesVisita) {
        this.pendientesVisita = pendientesVisita;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnCualitativa that = (PnCualitativa) o;

        if (id != that.id) return false;
        if (fechaCreacion != null ? !fechaCreacion.equals(that.fechaCreacion) : that.fechaCreacion != null)
            return false;
        if (fortalezas != null ? !fortalezas.equals(that.fortalezas) : that.fortalezas != null) return false;
        if (oportunidades != null ? !oportunidades.equals(that.oportunidades) : that.oportunidades != null)
            return false;
        if (pendientesVisita != null ? !pendientesVisita.equals(that.pendientesVisita) : that.pendientesVisita != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (fechaCreacion != null ? fechaCreacion.hashCode() : 0);
        result = 31 * result + (fortalezas != null ? fortalezas.hashCode() : 0);
        result = 31 * result + (oportunidades != null ? oportunidades.hashCode() : 0);
        result = 31 * result + (pendientesVisita != null ? pendientesVisita.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_capitulo", referencedColumnName = "id", nullable = true)
    public PnCapitulo getPnCapituloByIdCapitulo() {
        return pnCapituloByIdCapitulo;
    }

    public void setPnCapituloByIdCapitulo(PnCapitulo pnCapituloByIdCapitulo) {
        this.pnCapituloByIdCapitulo = pnCapituloByIdCapitulo;
    }

    @ManyToOne
    @JoinColumn(name = "id_empleado", referencedColumnName = "id")
    public Empleado getEmpleadoByIdEmpleado() {
        return empleadoByIdEmpleado;
    }

    public void setEmpleadoByIdEmpleado(Empleado empleadoByIdEmpleado) {
        this.empleadoByIdEmpleado = empleadoByIdEmpleado;
    }

    private Participante participanteByIdParticipante;

    @ManyToOne
    @JoinColumn(name = "id_participante", referencedColumnName = "id", nullable = false)
    public Participante getParticipanteByIdParticipante() {
        return participanteByIdParticipante;
    }

    public void setParticipanteByIdParticipante(Participante participanteByIdParticipante) {
        this.participanteByIdParticipante = participanteByIdParticipante;
    }

    @ManyToOne
    @JoinColumn(name = "id_tipo_formato", referencedColumnName = "id", nullable = false)
    public TipoFormato getTipoFormatoByIdTipoFormato() {
        return tipoFormatoByIdTipoFormato;
    }

    public void setTipoFormatoByIdTipoFormato(TipoFormato tipoFormatoByIdTipoFormato) {
        this.tipoFormatoByIdTipoFormato = tipoFormatoByIdTipoFormato;
    }
}
