package co.com.elramireza.pn.model;

import javax.persistence.*;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 24/08/15
 * Time: 01:20 AM
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "pn_modelo_sub_capitulo")
public class PnModeloSubCapitulo {
    private int id;
    private PnModeloSubCapitulo modeloCapitulo;
    private int ponderacion;
    private String codigoItem;
    private String subCapitulo;
    private String evaluaItem;
    private String c20;
    private String c40;
    private String c60;
    private String c80;
    private String c100;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    @ManyToOne
    @JoinColumn(name = "id_capitulo", referencedColumnName = "id", nullable = false)
    public PnModeloSubCapitulo getModeloCapitulo() {
        return modeloCapitulo;
    }

    public void setModeloCapitulo(PnModeloSubCapitulo modeloSubCapitulo) {
        this.modeloCapitulo = modeloSubCapitulo;
    }

    @Basic
    @Column(name = "ponderacion")
    public int getPonderacion() {
        return ponderacion;
    }

    public void setPonderacion(int ponderacion) {
        this.ponderacion = ponderacion;
    }

    @Basic
    @Column(name = "codigo_item")
    public String getCodigoItem() {
        return codigoItem;
    }

    public void setCodigoItem(String codigoItem) {
        this.codigoItem = codigoItem;
    }

    @Basic
    @Column(name = "sub_capitulo")
    public String getSubCapitulo() {
        return subCapitulo;
    }

    public void setSubCapitulo(String subCapitulo) {
        this.subCapitulo = subCapitulo;
    }

    @Basic
    @Column(name = "evalua_item")
    public String getEvaluaItem() {
        return evaluaItem;
    }

    public void setEvaluaItem(String evaluaItem) {
        this.evaluaItem = evaluaItem;
    }

    @Basic
    @Column(name = "c_20")
    public String getC20() {
        return c20;
    }

    public void setC20(String c20) {
        this.c20 = c20;
    }

    @Basic
    @Column(name = "c_40")
    public String getC40() {
        return c40;
    }

    public void setC40(String c40) {
        this.c40 = c40;
    }

    @Basic
    @Column(name = "c_60")
    public String getC60() {
        return c60;
    }

    public void setC60(String c60) {
        this.c60 = c60;
    }

    @Basic
    @Column(name = "c_80")
    public String getC80() {
        return c80;
    }

    public void setC80(String c80) {
        this.c80 = c80;
    }

    @Basic
    @Column(name = "c_100")
    public String getC100() {
        return c100;
    }

    public void setC100(String c100) {
        this.c100 = c100;
    }



}
