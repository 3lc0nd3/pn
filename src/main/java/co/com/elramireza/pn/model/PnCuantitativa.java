package co.com.elramireza.pn.model;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:56 PM
 */
@Entity
@Table( name = "pn_cuantitativa")
public class PnCuantitativa {
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

    private int total;

    @Basic
    @Column(name = "total")
    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnCuantitativa that = (PnCuantitativa) o;

        if (id != that.id) return false;
        if (valor != that.valor) return false;
        if (fechaCreacion != null ? !fechaCreacion.equals(that.fechaCreacion) : that.fechaCreacion != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + valor;
        result = 31 * result + (fechaCreacion != null ? fechaCreacion.hashCode() : 0);
        return result;
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

    private PnSubCapitulo pnSubCapituloByIdSubCapitulo;

    @ManyToOne
    @JoinColumn(name = "id_sub_capitulo", referencedColumnName = "id", nullable = false)
    public PnSubCapitulo getPnSubCapituloByIdSubCapitulo() {
        return pnSubCapituloByIdSubCapitulo;
    }

    public void setPnSubCapituloByIdSubCapitulo(PnSubCapitulo pnSubCapituloByIdSubCapitulo) {
        this.pnSubCapituloByIdSubCapitulo = pnSubCapituloByIdSubCapitulo;
    }

    private Empleado empleadoByIdEmpleado;

    @ManyToOne
    @JoinColumn(name = "id_empleado", referencedColumnName = "id", nullable = false)
    public Empleado getEmpleadoByIdEmpleado() {
        return empleadoByIdEmpleado;
    }

    public void setEmpleadoByIdEmpleado(Empleado empleadoByIdEmpleado) {
        this.empleadoByIdEmpleado = empleadoByIdEmpleado;
    }
}
