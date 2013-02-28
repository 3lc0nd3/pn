package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:57 PM
 */
@Entity
@Table( name = "pn_sub_capitulo")
public class PnSubCapitulo {
    private int id;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String evalua;

    @Basic
    @Column(name = "evalua_item")
    public String getEvalua() {
        return evalua;
    }

    public void setEvalua(String evalua) {
        this.evalua = evalua;
    }

    private int ponderacion;

    @Basic
    @Column(name = "ponderacion")
    public int getPonderacion() {
        return ponderacion;
    }

    public void setPonderacion(int ponderacion) {
        this.ponderacion = ponderacion;
    }

    private String subCapitulo;

    @Basic
    @Column(name = "sub_capitulo")
    public String getSubCapitulo() {
        return subCapitulo;
    }

    public void setSubCapitulo(String subCapitulo) {
        this.subCapitulo = subCapitulo;
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

    private String codigoItem;

    @Basic
    @Column(name = "codigo_item")
    public String getCodigoItem() {
        return codigoItem;
    }

    public void setCodigoItem(String codigoItem) {
        this.codigoItem = codigoItem;
    }

    private String c20;

    @Basic
    @Column(name = "c_20")
    public String getC20() {
        return c20;
    }

    public void setC20(String c20) {
        this.c20 = c20;
    }

    private String c40;

    @Basic
    @Column(name = "c_40")
    public String getC40() {
        return c40;
    }

    public void setC40(String c40) {
        this.c40 = c40;
    }

    private String c60;

    @Basic
    @Column(name = "c_60")
    public String getC60() {
        return c60;
    }

    public void setC60(String c60) {
        this.c60 = c60;
    }

    private String c80;

    @Basic
    @Column(name = "c_80")
    public String getC80() {
        return c80;
    }

    public void setC80(String c80) {
        this.c80 = c80;
    }

    private String c100;

    @Basic
    @Column(name = "c_100")
    public String getC100() {
        return c100;
    }

    public void setC100(String c100) {
        this.c100 = c100;
    }
}
