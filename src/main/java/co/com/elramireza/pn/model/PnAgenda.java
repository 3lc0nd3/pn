package co.com.elramireza.pn.model;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:53 PM
 */
@Entity
@Table( name = "pn_agenda")
public class PnAgenda {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    private String tmpFechaDesde;

    @Transient
    public String getTmpFechaDesde() {
        return tmpFechaDesde;
    }

    public void setTmpFechaDesde(String tmpFechaDesde) {
        this.tmpFechaDesde = tmpFechaDesde;
    }

    private Timestamp fechaAgenda;

    @Basic
    @Column(name = "fecha_agenda")
    public Timestamp getFechaAgenda() {
        return fechaAgenda;
    }

    public void setFechaAgenda(Timestamp fechaAgenda) {
        this.fechaAgenda = fechaAgenda;
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

    private String notas;

    @Basic
    @Column(name = "notas_agenda")
    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

    private Empleado empleadoByIdEmpleadoCreador;

    @ManyToOne
    @JoinColumn(name = "id_empleado_creador", referencedColumnName = "id", nullable = false)
    public Empleado getEmpleadoByIdEmpleadoCreador() {
        return empleadoByIdEmpleadoCreador;
    }

    public void setEmpleadoByIdEmpleadoCreador(Empleado empleadoByIdEmpleadoCreador) {
        this.empleadoByIdEmpleadoCreador = empleadoByIdEmpleadoCreador;
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
}
