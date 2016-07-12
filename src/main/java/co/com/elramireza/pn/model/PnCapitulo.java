package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:54 PM
 */
@Entity
@Table( name = "pn_capitulo")
public class PnCapitulo {
    private int id;
    private int numeroCapitulo;
    private String nombreCapitulo;
    private String evaluaCapitulo;
    private int maximo;
    private PnTipoPremio pnTipoPremioById;

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

    @Basic
    @Column(name = "numero_capitulo")
    public int getNumeroCapitulo() {
        return numeroCapitulo;
    }

    public void setNumeroCapitulo(int numeroCapitulo) {
        this.numeroCapitulo = numeroCapitulo;
    }

    @Basic
    @Column(name = "criterio")
    public String getNombreCapitulo() {
        return nombreCapitulo;
    }

    public void setNombreCapitulo(String nombreCapitulo) {
        this.nombreCapitulo = nombreCapitulo;
    }


    @Basic
    @Column(name = "evalua_capitulo")
    public String getEvaluaCapitulo() {
        return evaluaCapitulo;
    }

    public void setEvaluaCapitulo(String evaluaCapitulo) {
        this.evaluaCapitulo = evaluaCapitulo;
    }


    @Basic
    @Column(name = "maximo")
    public int getMaximo() {
        return maximo;
    }

    public void setMaximo(int maximo) {
        this.maximo = maximo;
    }


    @ManyToOne
    @JoinColumn(name = "id_tipo_premio", referencedColumnName = "id", nullable = false)
    public PnTipoPremio getPnTipoPremioById() {
        return pnTipoPremioById;
    }

    public void setPnTipoPremioById(PnTipoPremio pnTipoPremioById) {
        this.pnTipoPremioById = pnTipoPremioById;
    }
}
