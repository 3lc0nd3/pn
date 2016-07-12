package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 14/07/15
 * Time: 05:43 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "pn_aspirante_evaluador")
public class PnAspiranteEvaluador {
    private int id;
    private Persona personaByIdPersona;
    private PnTipoPremio tipoPremioById;
    private PnPremio pnPremioByIdConvocatoria;
    private Timestamp fechaRegistro;

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

    @ManyToOne
    @JoinColumn(name = "id_persona", referencedColumnName = "id", nullable = false)
    public Persona getPersonaByIdPersona() {
        return personaByIdPersona;
    }

    public void setPersonaByIdPersona(Persona personaByIdPersona) {
        this.personaByIdPersona = personaByIdPersona;
    }

    @ManyToOne
    @JoinColumn(name = "pn_tipo_premio", referencedColumnName = "id", nullable = false)
    public PnTipoPremio getTipoPremioById() {
        return tipoPremioById;
    }

    public void setTipoPremioById(PnTipoPremio tipoPremioById) {
        this.tipoPremioById = tipoPremioById;
    }

    @ManyToOne
    @JoinColumn(name = "pn_premio_activo", referencedColumnName = "id", nullable = true)
    public PnPremio getPnPremioByIdConvocatoria() {
        return pnPremioByIdConvocatoria;
    }

    public void setPnPremioByIdConvocatoria(PnPremio pnPremioByIdConvocatoria) {
        this.pnPremioByIdConvocatoria = pnPremioByIdConvocatoria;
    }
    @Basic
    @Column(name = "fecha_registro")
    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }


}
