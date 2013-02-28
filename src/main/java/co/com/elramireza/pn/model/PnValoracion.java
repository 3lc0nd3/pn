package co.com.elramireza.pn.model;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:58 PM
 */
@Entity
@Table( name = "pn_valoracion")
public class PnValoracion {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private int valor;

    @Basic
    @Column(name = "valor")
    public int getValor() {
        return valor;
    }

    public void setValor(int valor) {
        this.valor = valor;
    }

    private Timestamp fecha;

    @Basic
    @Column(name = "fecha")
    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnValoracion that = (PnValoracion) o;

        if (id != that.id) return false;
        if (valor != that.valor) return false;
        if (fecha != null ? !fecha.equals(that.fecha) : that.fecha != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + valor;
        result = 31 * result + (fecha != null ? fecha.hashCode() : 0);
        return result;
    }

    private PnCapitulo pnCapituloByIdCapitulo;

    @ManyToOne
    @JoinColumn(name = "id_capitulo", referencedColumnName = "id")
    public PnCapitulo getPnCapituloByIdCapitulo() {
        return pnCapituloByIdCapitulo;
    }

    public void setPnCapituloByIdCapitulo(PnCapitulo pnCapituloByIdCapitulo) {
        this.pnCapituloByIdCapitulo = pnCapituloByIdCapitulo;
    }

    private Empleado empleadoByIdEmpleado;

    @ManyToOne
    @JoinColumn(name = "id_empleado", referencedColumnName = "id")
    public Empleado getEmpleadoByIdEmpleado() {
        return empleadoByIdEmpleado;
    }

    public void setEmpleadoByIdEmpleado(Empleado empleadoByIdEmpleado) {
        this.empleadoByIdEmpleado = empleadoByIdEmpleado;
    }

    private PnCriterio pnCriterioByIdPnCriterio;

    @ManyToOne
    @JoinColumn(name = "id_pn_criterio", referencedColumnName = "id", nullable = false)
    public PnCriterio getPnCriterioByIdPnCriterio() {
        return pnCriterioByIdPnCriterio;
    }

    public void setPnCriterioByIdPnCriterio(PnCriterio pnCriterioByIdPnCriterio) {
        this.pnCriterioByIdPnCriterio = pnCriterioByIdPnCriterio;
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

    private TipoFormato tipoFormatoByIdTipoFormato;

    @ManyToOne
    @JoinColumn(name = "id_tipo_formato", referencedColumnName = "id", nullable = false)
    public TipoFormato getTipoFormatoByIdTipoFormato() {
        return tipoFormatoByIdTipoFormato;
    }

    public void setTipoFormatoByIdTipoFormato(TipoFormato tipoFormatoByIdTipoFormato) {
        this.tipoFormatoByIdTipoFormato = tipoFormatoByIdTipoFormato;
    }
}
