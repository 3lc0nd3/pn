package co.com.elramireza.pn.model;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:54 PM
 */
@Entity
@Table( name = "pn_conclusion")
public class PnConclusion {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String recomendacion;

    @Basic
    @Column(name = "recomendacion")
    public String getRecomendacion() {
        return recomendacion;
    }

    public void setRecomendacion(String recomendacion) {
        this.recomendacion = recomendacion;
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

        PnConclusion that = (PnConclusion) o;

        if (id != that.id) return false;
        if (fechaCreacion != null ? !fechaCreacion.equals(that.fechaCreacion) : that.fechaCreacion != null)
            return false;
        if (recomendacion != null ? !recomendacion.equals(that.recomendacion) : that.recomendacion != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (recomendacion != null ? recomendacion.hashCode() : 0);
        result = 31 * result + (fechaCreacion != null ? fechaCreacion.hashCode() : 0);
        return result;
    }

    private PnCapitulo pnCapituloByIdCapitulo;

    @ManyToOne
    @JoinColumn(name = "id_capitulo", referencedColumnName = "id", nullable = false)
    public PnCapitulo getPnCapituloByIdCapitulo() {
        return pnCapituloByIdCapitulo;
    }

    public void setPnCapituloByIdCapitulo(PnCapitulo pnCapituloByIdCapitulo) {
        this.pnCapituloByIdCapitulo = pnCapituloByIdCapitulo;
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
