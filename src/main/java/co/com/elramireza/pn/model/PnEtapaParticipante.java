package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: Jan 28, 2013
 * Time: 12:12:08 PM
 */
@Entity
@Table( name = "pn_etapa_participante")
public class PnEtapaParticipante {
    private int idEtapaParticipante;

    @Id
    @Column(name = "id_etapa_participante")
    public int getIdEtapaParticipante() {
        return idEtapaParticipante;
    }

    public void setIdEtapaParticipante(int idEtapaParticipante) {
        this.idEtapaParticipante = idEtapaParticipante;
    }

    private String etapaParticipante;

    @Basic
    @Column(name = "etapa_participante")
    public String getEtapaParticipante() {
        return etapaParticipante;
    }

    public void setEtapaParticipante(String etapaParticipante) {
        this.etapaParticipante = etapaParticipante;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PnEtapaParticipante that = (PnEtapaParticipante) o;

        if (idEtapaParticipante != that.idEtapaParticipante) return false;
        if (etapaParticipante != null ? !etapaParticipante.equals(that.etapaParticipante) : that.etapaParticipante != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idEtapaParticipante;
        result = 31 * result + (etapaParticipante != null ? etapaParticipante.hashCode() : 0);
        return result;
    }
}
