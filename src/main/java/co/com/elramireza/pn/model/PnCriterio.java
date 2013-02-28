package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:55 PM
 */
@Entity
@Table( name = "pn_criterio", schema = "")
public class PnCriterio {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String criterio;

    @Basic
    @Column(name = "criterio")
    public String getCriterio() {
        return criterio;
    }

    public void setCriterio(String criterio) {
        this.criterio = criterio;
    }

    private PnCategoriaCriterio pnCategoriaCriterioByIdCategoriaCriterio;

    @ManyToOne
    @JoinColumn(name = "id_categoria_criterio", referencedColumnName = "id", nullable = false)
    public PnCategoriaCriterio getPnCategoriaCriterioByIdCategoriaCriterio() {
        return pnCategoriaCriterioByIdCategoriaCriterio;
    }

    public void setPnCategoriaCriterioByIdCategoriaCriterio(PnCategoriaCriterio pnCategoriaCriterioByIdCategoriaCriterio) {
        this.pnCategoriaCriterioByIdCategoriaCriterio = pnCategoriaCriterioByIdCategoriaCriterio;
    }

	private String evalua;

	@Column(name = "evalua")
	@Basic
	public String getEvalua() {
		return evalua;
	}

	public void setEvalua(String evalua) {
		this.evalua = evalua;
	}

	private String c20;

	@Column(name = "c_20")
	@Basic
	public String getC20() {
		return c20;
	}

	public void setC20(String c20) {
		this.c20 = c20;
	}

	private String c40;

	@Column(name = "c_40")
	@Basic
	public String getC40() {
		return c40;
	}

	public void setC40(String c40) {
		this.c40 = c40;
	}

	private String c60;

	@Column(name = "c_60")
	@Basic
	public String getC60() {
		return c60;
	}

	public void setC60(String c60) {
		this.c60 = c60;
	}

	private String c80;

	@Column(name = "c_80")
	@Basic
	public String getC80() {
		return c80;
	}

	public void setC80(String c80) {
		this.c80 = c80;
	}

	private String c100;

	@Column(name = "c_100")
	@Basic
	public String getC100() {
		return c100;
	}

	public void setC100(String c100) {
		this.c100 = c100;
	}

	private String c50;

	@Column(name = "c_50")
	@Basic
	public String getC50() {
		return c50;
	}

	public void setC50(String c50) {
		this.c50 = c50;
	}
}
