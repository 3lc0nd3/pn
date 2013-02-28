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
 * Time: 05:40:44 PM
 */
@Entity
@Table( name = "empresa")
public class Empresa {
    private int idEmpresa;

    @Id
    @GenericGenerator(name = "generator", strategy = "increment")
    @GeneratedValue(generator = "generator")
    @Column(name = "id")
    public int getIdEmpresa() {
        return idEmpresa;
    }

    public void setIdEmpresa(int idEmpresa) {
        this.idEmpresa = idEmpresa;
    }

    private String nombreEmpresa;

    @Basic
    @Column(name = "nombre")
    public String getNombreEmpresa() {
        return nombreEmpresa;
    }

    public void setNombreEmpresa(String nombreEmpresa) {
        this.nombreEmpresa = nombreEmpresa;
    }

    private int locCiudadEmpresa;

    @Transient
    public int getLocCiudadEmpresa() {
        return locCiudadEmpresa;
    }

    public void setLocCiudadEmpresa(int locCiudadEmpresa) {
        this.locCiudadEmpresa = locCiudadEmpresa;
    }

    private LocCiudad locCiudadByIdCiudad;

    @ManyToOne
    @JoinColumn(name = "id_ciudad", referencedColumnName = "id_ciudad", nullable = false)
    public LocCiudad getLocCiudadByIdCiudad() {
        return locCiudadByIdCiudad;
    }

    public void setLocCiudadByIdCiudad(LocCiudad locCiudadByIdCiudad) {
        this.locCiudadByIdCiudad = locCiudadByIdCiudad;
    }

    private int tipoEmpresa;

    @Transient
    public int getTipoEmpresa() {
        return tipoEmpresa;
    }

    public void setTipoEmpresa(int tipoEmpresa) {
        this.tipoEmpresa = tipoEmpresa;
    }

    private TipoEmpresa tipoEmpresaByIdTipoEmpresa;

    @ManyToOne
    @JoinColumn(name = "id_tipo_empresa", referencedColumnName = "id", nullable = false)
    public TipoEmpresa getTipoEmpresaByIdTipoEmpresa() {
        return tipoEmpresaByIdTipoEmpresa;
    }

    public void setTipoEmpresaByIdTipoEmpresa(TipoEmpresa tipoEmpresaByIdTipoEmpresa) {
        this.tipoEmpresaByIdTipoEmpresa = tipoEmpresaByIdTipoEmpresa;
    }

    private String nit;

    @Basic
    @Column(name = "nit")
    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    private String direccionEmpresa;

    @Basic
    @Column(name = "direccion")
    public String getDireccionEmpresa() {
        return direccionEmpresa;
    }

    public void setDireccionEmpresa(String direccionEmpresa) {
        this.direccionEmpresa = direccionEmpresa;
    }

    private String telFijoEmpresa;

    @Basic
    @Column(name = "tel_fijo")
    public String getTelFijoEmpresa() {
        return telFijoEmpresa;
    }

    public void setTelFijoEmpresa(String telFijoEmpresa) {
        this.telFijoEmpresa = telFijoEmpresa;
    }

    private String telMovilEmpresa;

    @Basic
    @Column(name = "tel_movil")
    public String getTelMovilEmpresa() {
        return telMovilEmpresa;
    }

    public void setTelMovilEmpresa(String telMovilEmpresa) {
        this.telMovilEmpresa = telMovilEmpresa;
    }

    private String webEmpresa;

    @Basic
    @Column(name = "web")
    public String getWebEmpresa() {
        return webEmpresa;
    }

    public void setWebEmpresa(String webEmpresa) {
        this.webEmpresa = webEmpresa;
    }

    private String emailEmpresa;

    @Basic
    @Column(name = "email")
    public String getEmailEmpresa() {
        return emailEmpresa;
    }

    public void setEmailEmpresa(String emailEmpresa) {
        this.emailEmpresa = emailEmpresa;
    }

    private String actividadPrincipal;

    @Basic
    @Column(name = "actividad_principal")
    public String getActividadPrincipal() {
        return actividadPrincipal;
    }

    public void setActividadPrincipal(String actividadPrincipal) {
        this.actividadPrincipal = actividadPrincipal;
    }

    private String productos;

    @Basic
    @Column(name = "productos")
    public String getProductos() {
        return productos;
    }

    public void setProductos(String productos) {
        this.productos = productos;
    }

    private String marcas;

    @Basic
    @Column(name = "marcas")
    public String getMarcas() {
        return marcas;
    }

    public void setMarcas(String marcas) {
        this.marcas = marcas;
    }

    private String alcanceMercado;

    @Basic
    @Column(name = "alcance_mercado")
    public String getAlcanceMercado() {
        return alcanceMercado;
    }

    public void setAlcanceMercado(String alcanceMercado) {
        this.alcanceMercado = alcanceMercado;
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

    private Timestamp fechaCreacion;

    @Basic
    @Column(name = "fecha_creacion")
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    private int empleados;

    @Basic
    @Column(name = "empleados")
    public int getEmpleados() {
        return empleados;
    }

    public void setEmpleados(int empleados) {
        this.empleados = empleados;
    }

    private String valorActivos;

    @Basic
    @Column(name = "valor_activos")
    public String getValorActivos() {
        return valorActivos;
    }

    public void setValorActivos(String valorActivos) {
        this.valorActivos = valorActivos;
    }

    private int idEmpresaCategoriaTamano;

    @Transient
    public int getIdEmpresaCategoriaTamano() {
        return idEmpresaCategoriaTamano;
    }

    public void setIdEmpresaCategoriaTamano(int idEmpresaCategoriaTamano) {
        this.idEmpresaCategoriaTamano = idEmpresaCategoriaTamano;
    }

    private EmpresaCategoriaTamano empresaCategoriaTamanoByIdCategoriaTamanoEmpresa;

    @ManyToOne
    @JoinColumn(name = "id_categoria_tamano_empresa", referencedColumnName = "id", nullable = false)
    public EmpresaCategoriaTamano getEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa() {
        return empresaCategoriaTamanoByIdCategoriaTamanoEmpresa;
    }

    public void setEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa(EmpresaCategoriaTamano empresaCategoriaTamanoByIdCategoriaTamanoEmpresa) {
        this.empresaCategoriaTamanoByIdCategoriaTamanoEmpresa = empresaCategoriaTamanoByIdCategoriaTamanoEmpresa;
    }

    private int idEmpresaCategoria;

    @Transient
    public int getIdEmpresaCategoria() {
        return idEmpresaCategoria;
    }

    public void setIdEmpresaCategoria(int idEmpresaCategoria) {
        this.idEmpresaCategoria = idEmpresaCategoria;
    }

    private EmpresaCategoria empresaCategoriaByIdCategoriaEmpresa;

    @ManyToOne
    @JoinColumn(name = "id_categoria_empresa", referencedColumnName = "id", nullable = false)
    public EmpresaCategoria getEmpresaCategoriaByIdCategoriaEmpresa() {
        return empresaCategoriaByIdCategoriaEmpresa;
    }

    public void setEmpresaCategoriaByIdCategoriaEmpresa(EmpresaCategoria empresaCategoriaByIdCategoriaEmpresa) {
        this.empresaCategoriaByIdCategoriaEmpresa = empresaCategoriaByIdCategoriaEmpresa;
    }

    private int publicaEmpresa;

    @Basic
    @Column(name = "publica")
    public int getPublicaEmpresa() {
        return publicaEmpresa;
    }

    public void setPublicaEmpresa(int publicaEmpresa) {
        this.publicaEmpresa = publicaEmpresa;
    }

	private byte[] fileInformePostulacionFile;

	@Transient
	public byte[] getFileInformePostulacionFile() {
		return fileInformePostulacionFile;
	}

	public void setFileInformePostulacionFile(byte[] fileInformePostulacionFile) {
		this.fileInformePostulacionFile = fileInformePostulacionFile;
	}

	private byte[] fileCertificadoConstitucionFile;

    @Transient
    public byte[] getFileCertificadoConstitucionFile() {
        return fileCertificadoConstitucionFile;
    }

    public void setFileCertificadoConstitucionFile(byte[] fileCertificadoConstitucionFile) {
        this.fileCertificadoConstitucionFile = fileCertificadoConstitucionFile;
    }

	private String fileInformePostulacion;

	@Basic
	@Column(name = "file_informe_p")
	public String getFileInformePostulacion() {
		return fileInformePostulacion;
	}

	public void setFileInformePostulacion(String fileInformePostulacion) {
		this.fileInformePostulacion = fileInformePostulacion;
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

    private byte[] fileEstadoFinancieroFile;

    @Transient
    public byte[] getFileEstadoFinancieroFile() {
        return fileEstadoFinancieroFile;
    }

    public void setFileEstadoFinancieroFile(byte[] fileEstadoFinancieroFile) {
        this.fileEstadoFinancieroFile = fileEstadoFinancieroFile;
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

    private byte[] fileConsignacionFile;

    @Transient
    public byte[] getFileConsignacionFile() {
        return fileConsignacionFile;
    }

    public void setFileConsignacionFile(byte[] fileConsignacionFile) {
        this.fileConsignacionFile = fileConsignacionFile;
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
}
