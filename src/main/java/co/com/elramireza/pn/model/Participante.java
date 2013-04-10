package co.com.elramireza.pn.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 2/01/2013
 * Time: 05:40:50 PM
 */
@Entity
@Table( name = "participante")
public class Participante {
    private int idParticipante;

    @Id
    @GenericGenerator(name = "generator", strategy = "increment")
    @GeneratedValue(generator = "generator")
    @Column(name = "id")
    public int getIdParticipante() {
        return idParticipante;
    }

    public void setIdParticipante(int idParticipante) {
        this.idParticipante = idParticipante;
    }

    private Timestamp fechaIngreso;

    @Basic
    @Column(name = "fecha_ingreso")
    public Timestamp getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Timestamp fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    private boolean estado;

    @Basic
    @Column(name = "estado")
    @Type(type = "org.hibernate.type.NumericBooleanType")
    public boolean getEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    private String observaciones;

    @Basic
    @Column(name = "observaciones")
    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    private Empresa empresaByIdEmpresa;

    @ManyToOne
    @JoinColumn(name = "id_empresa", referencedColumnName = "id", nullable = false)
    public Empresa getEmpresaByIdEmpresa() {
        return empresaByIdEmpresa;
    }

    public void setEmpresaByIdEmpresa(Empresa empresaByIdEmpresa) {
        this.empresaByIdEmpresa = empresaByIdEmpresa;
    }

    private PnPremio pnPremioByIdConvocatoria;

    @ManyToOne
    @JoinColumn(name = "id_convocatoria", referencedColumnName = "id", nullable = false)
    public PnPremio getPnPremioByIdConvocatoria() {
        return pnPremioByIdConvocatoria;
    }

    public void setPnPremioByIdConvocatoria(PnPremio pnPremioByIdConvocatoria) {
        this.pnPremioByIdConvocatoria = pnPremioByIdConvocatoria;
    }

    private PnEtapaParticipante pnEtapaParticipanteByIdEtapaParticipante;

    @ManyToOne
    @JoinColumn(name = "id_etapa_participante", referencedColumnName = "id_etapa_participante", nullable = false)
    public PnEtapaParticipante getPnEtapaParticipanteByIdEtapaParticipante() {
        return pnEtapaParticipanteByIdEtapaParticipante;
    }

    public void setPnEtapaParticipanteByIdEtapaParticipante(PnEtapaParticipante pnEtapaParticipanteByIdEtapaParticipante) {
        this.pnEtapaParticipanteByIdEtapaParticipante = pnEtapaParticipanteByIdEtapaParticipante;
    }

    private String fileInformePostula;

    @Basic
    @Column(name = "file_informe_postula")
    public String getFileInformePostula() {
        return fileInformePostula;
    }

    public void setFileInformePostula(String fileInformePostula) {
        this.fileInformePostula = fileInformePostula;
    }

    private String fileCertificadoConstitucion;

    @Basic
    @Column(name = "file_certificado_constitucion")
    public String getFileCertificadoConstitucion() {
        return fileCertificadoConstitucion;
    }

    public void setFileCertificadoConstitucion(String fileCertificadoConstitucion) {
        this.fileCertificadoConstitucion = fileCertificadoConstitucion;
    }

    private String fileEstadoFinanciero;

    @Basic
    @Column(name = "file_estado_financiero")
    public String getFileEstadoFinanciero() {
        return fileEstadoFinanciero;
    }

    public void setFileEstadoFinanciero(String fileEstadoFinanciero) {
        this.fileEstadoFinanciero = fileEstadoFinanciero;
    }

    private String fileConsignacion;

    @Basic
    @Column(name = "file_consignacion")
    public String getFileConsignacion() {
        return fileConsignacion;
    }

    public void setFileConsignacion(String fileConsignacion) {
        this.fileConsignacion = fileConsignacion;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Participante that = (Participante) o;

        if (fileCertificadoConstitucion != null ? !fileCertificadoConstitucion.equals(that.fileCertificadoConstitucion) : that.fileCertificadoConstitucion != null)
            return false;
        if (fileConsignacion != null ? !fileConsignacion.equals(that.fileConsignacion) : that.fileConsignacion != null)
            return false;
        if (fileEstadoFinanciero != null ? !fileEstadoFinanciero.equals(that.fileEstadoFinanciero) : that.fileEstadoFinanciero != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = fileCertificadoConstitucion != null ? fileCertificadoConstitucion.hashCode() : 0;
        result = 31 * result + (fileEstadoFinanciero != null ? fileEstadoFinanciero.hashCode() : 0);
        result = 31 * result + (fileConsignacion != null ? fileConsignacion.hashCode() : 0);
        return result;
    }
}
