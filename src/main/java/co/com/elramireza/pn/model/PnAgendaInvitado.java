package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:53 PM
 */
@Entity
@Table(catalog = "pn", name = "pn_agenda_invitado")
public class PnAgendaInvitado {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String documentos;

    @Basic
    @Column(name = "documentos")
    public String getDocumentos() {
        return documentos;
    }

    public void setDocumentos(String documentos) {
        this.documentos = documentos;
    }

    private String preguntas;

    @Basic
    @Column(name = "preguntas")
    public String getPreguntas() {
        return preguntas;
    }

    public void setPreguntas(String preguntas) {
        this.preguntas = preguntas;
    }

    private String resultados;

    @Basic
    @Column(name = "resultados")
    public String getResultados() {
        return resultados;
    }

    public void setResultados(String resultados) {
        this.resultados = resultados;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnAgendaInvitado that = (PnAgendaInvitado) o;

        if (id != that.id) return false;
        if (documentos != null ? !documentos.equals(that.documentos) : that.documentos != null) return false;
        if (preguntas != null ? !preguntas.equals(that.preguntas) : that.preguntas != null) return false;
        if (resultados != null ? !resultados.equals(that.resultados) : that.resultados != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (documentos != null ? documentos.hashCode() : 0);
        result = 31 * result + (preguntas != null ? preguntas.hashCode() : 0);
        result = 31 * result + (resultados != null ? resultados.hashCode() : 0);
        return result;
    }

    private PnSubCapitulo pnSubCapituloByIdPnSubcapitulo;

    @ManyToOne
    @JoinColumn(name = "id_pn_subcapitulo", referencedColumnName = "id", nullable = false)
    public PnSubCapitulo getPnSubCapituloByIdPnSubcapitulo() {
        return pnSubCapituloByIdPnSubcapitulo;
    }

    public void setPnSubCapituloByIdPnSubcapitulo(PnSubCapitulo pnSubCapituloByIdPnSubcapitulo) {
        this.pnSubCapituloByIdPnSubcapitulo = pnSubCapituloByIdPnSubcapitulo;
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

    private PnAgenda pnAgendaByIdAgenda;

    @ManyToOne
    @JoinColumn(name = "id_agenda", referencedColumnName = "id", nullable = false)
    public PnAgenda getPnAgendaByIdAgenda() {
        return pnAgendaByIdAgenda;
    }

    public void setPnAgendaByIdAgenda(PnAgenda pnAgendaByIdAgenda) {
        this.pnAgendaByIdAgenda = pnAgendaByIdAgenda;
    }
}
