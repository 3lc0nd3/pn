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
@Table( name = "pn_agenda_invitado")
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

    private int idItem;

    @Transient
    public int getIdItem() {
        return idItem;
    }

    public void setIdItem(int idItem) {
        this.idItem = idItem;
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

    private PnSubCapitulo pnSubCapituloByIdPnSubcapitulo;

    @ManyToOne
    @JoinColumn(name = "id_pn_subcapitulo", referencedColumnName = "id", nullable = false)
    public PnSubCapitulo getPnSubCapituloByIdPnSubcapitulo() {
        return pnSubCapituloByIdPnSubcapitulo;
    }

    public void setPnSubCapituloByIdPnSubcapitulo(PnSubCapitulo pnSubCapituloByIdPnSubcapitulo) {
        this.pnSubCapituloByIdPnSubcapitulo = pnSubCapituloByIdPnSubcapitulo;
    }

	private int hora;

	@Basic
	@Column(name = "hora")
	public int getHora() {
		return hora;
	}

	public void setHora(int hora) {
		this.hora = hora;
	}

	private String  idEmpleado;

    @Basic
	@Column(name = "id_empleado")
    public String getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(String idEmpleado) {
        this.idEmpleado = idEmpleado;
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
